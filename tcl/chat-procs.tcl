# /chat/tcl/chat-procs.tcl
ad_library {
    TCL Library for the chat system v.4

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 17, 2000
    @cvs-id $Id$
}

ad_proc -private chat_start_server {} { Start Java chat server. } {

    if [nsv_get chat server_started] {
	return
    }
    ns_log notice "chat_start_server: Starting chat server"
    set port [ad_parameter ServerPort]
    set path "ns/server/[ns_info server]/module/nssock"
    set host_location "[ns_config $path Address]"

    exec java -classpath [acs_root_dir]/packages/chat/java adChatServer start $port &

    set done 0

    # Wait until chat server started before spawning new threads connecting to the server.
    while { $done == 0} {
	if [catch {set fds [ns_sockopen -nonblock $host_location $port]} errmsg] {
	    set done 0
	} else {
	    set done 1
	}
    }

    # Free up resources.
    set r [lindex $fds 0]
    set w [lindex $fds 1]

    close $r
    close $w
    ns_thread begindetached "chat_broadcast_to_applets $host_location $port"
    ns_thread begindetached "chat_receive_from_server $host_location $port"

    ns_log notice "chat_start_server: Chat server started."
    nsv_set chat server_started 1
}

ad_proc -private chat_broadcast_to_applets {host port} { Broadcast chat message from HTML client to Java server. } {

    # Chat server must already started otherwise error will occur.
    set fds [ns_sockopen -nonblock $host $port]

    set r [lindex $fds 0]
    set w [lindex $fds 1]

    ns_log debug "chat_broadcast_to_applets: Ready to broadcast message to applets."

    # Register to java chat server.
    puts $w "<login><user_id>-1</user_id><user_name>AOL_WRITER</user_name><pw>T</pw><room_id>-1</room_id></login>"
    flush $w

    while { 1 } {
	# Wait until there is new message in queue.
	ns_mutex lock [nsv_get chat new_message]
	if [nsv_exists chat html_message] {
	    # Get message from queue.
	    puts $w [nsv_get chat html_message]
	    flush $w
	}
    }
}


ad_proc -private chat_receive_from_server {host port} { Receive messages from Java clients. } {

    set fds [ns_sockopen -nonblock $host $port]

    set r [lindex $fds 0]
    set w [lindex $fds 1]
    set r_fd [list $r]

    ns_log debug "chat_receive_from_server: Listening for messages from applets."

    puts $w "<login><user_id>-1</user_id><user_name>AOL_READER</user_name><pw>T</pw><room_id>-1</room_id></login>"
    flush $w

    set running 1

    while { $running } {
	set sel [ns_sockselect $r_fd {} {}]
	set rfds [lindex $sel 0]

	foreach r $rfds {

	    if {[ns_sockcheck $r] && [set line [string trim [gets $r]]] != ""} {
		regexp "<room_id>(.*)</room_id>" $line match room_id
		regexp "<from>(.*)</from>" $line match screen_name
		regexp "<body>(.*)</body>" $line match msg
		regexp "<from_user_id>(.*)</from_user_id>" $line match user_id
		if ![nsv_exists chat_room $room_id] {
		    nsv_set chat_room $room_id {}		    
		}


                if [catch {chat_post_message_to_db -creation_user $user_id $room_id $msg} errmsg] {
		    ns_log error "chat_post_message_to_db: error: $errmsg"
		}

                nsv_lappend chat_room $room_id $line

	    } else {
		set running 0
	    }
	}
    }
}

ad_proc -private chat_post_message_to_db {
    {-creation_user ""}
    {-creation_ip ""}
    room_id
    msg
} {
    Log chat message to the database.
} {

    db_exec_plsql post_message {}

}
ad_proc -public chat_room_new {
    {-description ""}
    {-moderated_p f}
    {-active_p t}
    {-archive_p f}
    {-context_id ""}
    {-creation_user ""}
    {-creation_ip ""}
    pretty_name

} {
    Create new chat room. Return room_id if successful else raise error.
} {

    db_transaction {
	set room_id [db_exec_plsql create_room {}]
    }

    db_exec_plsql grant_permission {}

    return $room_id
}

ad_proc -public chat_room_edit {
    room_id
    pretty_name
    description
    moderated_p
    active_p
    archive_p
} {
    Edit information on chat room. All information require.
} {
   db_exec_plsql edit_room {}
}

ad_proc -public chat_room_delete {
    room_id
} {
    Delete chat room.
} {
    db_exec_plsql delete_room {}
}

ad_proc -public chat_room_message_delete {
    room_id
} {
    Delete all message in the room.
} {
    db_exec_plsql delete_message {}
}

ad_proc -public chat_message_count {
    room_id
} {
    Get message count in the room.
} {

    return [db_exec_plsql message_count {}]
}



ad_proc -public room_active_status {
    room_id
} {
    Get room active status.
} {

    return [db_string get_active { select active_p from chat_rooms where room_id =  :room_id}]

}





ad_proc -public chat_room_name {
    room_id
} {
    Get chat room name.
} {
    return [db_string get_room_name {} -default "" ]

}

ad_proc -public chat_moderator_grant {
    room_id
    party_id
} {
    Grant party a chat moderate privilege to this chat room.
} {
    db_exec_plsql grant_moderator {}
}

ad_proc -public chat_moderator_revoke {
    room_id
    party_id
} {
    Revoke party a chat moderate privilege to this chat room.
} {

    db_exec_plsql revoke_moderator {}

}

ad_proc -public chat_user_grant {
    room_id
    party_id
} {
    Grant party a chat privilege to this chat room.
} {
    db_transaction {
	db_exec_plsql grant_user {}
    }
}


ad_proc -public chat_user_revoke {
    room_id
    party_id
} {
    Revoke party a chat privilege to this chat room.
} {
    db_transaction {
	db_exec_plsql revoke_user {}
    }
}

ad_proc -public chat_user_ban {
    room_id
    party_id
} {
    Explicit ban user from this chat room.
} {
    db_exec_plsql ban_user {}
}


ad_proc -public chat_user_unban {
    room_id
    party_id
} {
    unban user from this chat room.
} {
    db_exec_plsql ban_user {}
}

ad_proc -public chat_revoke_moderators {
    room_id
    revoke_list
} {
    Revoke a list of parties of a moderate privilege from this room.
} {
    foreach party_id $revoke_list {
	db_dml revoke_moderate {
	    begin
	        acs_persmission.revoke_permission(:room_id, :party_id, 'chat_moderate_room');
	    end
	}
    }

}

ad_proc -public chat_room_moderate_p {
    room_id
} {
    Return the moderate status of this chat room.
} {
    set moderate_p [db_string get_chat_room_moderate {
	select moderated_p
	from chat_rooms
	where room_id = :room_id
    }]

    return $moderate_p

}

ad_proc -public chat_user_name {
    user_id
} {
    Return display name of this user to use in chat.
} {

    return [db_exec_plsql get_chat_user_name {}]

}

ad_proc -public chat_message_post {
    room_id
    user_id
    message
    moderator_p
} {
    Post message to the chat room and broadcast to all applet clients. 
    Only use by HTML client.
} {
    if {$moderator_p == "1" } {
	set status "approved"
    } else {
	set status "pending"
    }

    set chat_msg "<message><from>[chat_user_name $user_id]</from><from_user_id>$user_id</from_user_id><room_id>$room_id</room_id><body>$message</body><status>$status</status></message>"
    # Add message to queue. Notify thread responsible for broadcast message to applets.

    nsv_set chat html_message $chat_msg
    ns_mutex unlock [nsv_get chat new_message]

}


ad_proc -public chat_moderate_message_post {
    room_id
    user_id
    message
} {
    Post moderate message to the chat room and broadcast to all applet clients. Only use by HTML client.
} {
    set chat_msg "<message><from>[chat_user_name $user_id]</from><from_user_id>$user_id</from_user_id><room_id>$room_id</room_id><body>$message</body><status>pending</status></message>"

    # Add message to queue. Notify thread responsible for broadcast message to applets.
    nsv_set chat html_message $chat_msg
    ns_mutex unlock [nsv_get chat new_message]
}




ad_proc -public chat_urlify_msg {
    msg
} {
    Convert all www.xxx.com into hyperlinks, adding an <A>..</a>.
} {

    # Check for http://xxxxx/.../.../
    # message line from the outer parts + url
    # This is the more specific variant.
    if {[regexp {(http\:\/\/[a-zA-Z0-9\-\.]+(/[^\ \/]*)*)} $msg match url]} {
	set msg_len [string length $msg]
	set left_idx [string first $url $msg]
	set left [string range $msg 0 [expr $left_idx - 1]]
	set right_start [expr $left_idx + [string length $url]]
	set right [string range $msg $right_start $msg_len]
	set link "<a href=\"$url\" target=training>$url</a>"
	set msg "$left$link$right"
	return $msg
    }

    # Check for www.xxxxx.yyy and build a new 
    # message line from the outer parts + url
    # this is the more generic variant
    if {[regexp {(www\.[a-zA-Z0-9\-]+\.[a-zA-Z]+(/[^\ \/]*)*)} $msg match url]} {
	set msg_len [string length $msg]
	set left_idx [string first $url $msg]
	set left [string range $msg 0 [expr $left_idx - 1]]
	set right_start [expr $left_idx + [string length $url]]
	set right [string range $msg $right_start $msg_len]
	set link "<a href=\"http://$url\" target=training>$url</a>"
	set msg "$left$link$right"
	return $msg
    }

    # Here we may check for email, other types of links etc.

    return $msg
}


ad_proc -public chat_message_retrieve {
    msgs
    room_id
    user_id
} {
    Retrieve all messages from the chat room starting from first_msg_id. Return messages are store in multirow format.
} {

    ns_log debug "chat_message_retrieve: starting message retrieve"

    # The first time html client enter chat room, chat_room variable is not initialize correctly.
    # Therefore I just hard code the variable.
    if ![nsv_exists chat_room $room_id] {
	nsv_set chat_room $room_id [list "<message><from>[chat_user_name $user_id]</from><room_id>$room_id</room_id><body>[_ chat.has_entered_the_room]</body><status>approved</status></message>"]
    }

    set user_name [chat_user_name $user_id]

    upvar "$msgs:rowcount" counter

    set chat_messages [nsv_get chat_room $room_id]
    set count [llength $chat_messages]

    set cnt $count
    set counter 0

    #foreach msg $chat_messages 
    for { set i [expr $cnt - 1] } { $i >= 0 } { set i [expr $i - 1] } {
	set msg [lindex $chat_messages $i]

	regexp "<from>(.*)</from>" $msg match screen_name
	regexp "<body>(.*)</body>" $msg match chat_msg
	regexp "<status>(.*)</status>" $msg match status

#	ad_return_complaint 1 "screen_name=$screen_name, chat_msg=$chat_msg, status=$status"

	# Make www.xxx.com into a clickable link
	set chat_msg [ns_quotehtml $chat_msg]
	set chat_msg [chat_urlify_msg $chat_msg]

	if {$status == "pending" || $status == "rejected"} {
	    continue;
	}

	upvar "$msgs:[expr {$counter + 1}]" array_val

	set array_val(screen_name) $screen_name
	set array_val(chat_msg) $chat_msg
	incr counter
	set array_val(rownum) $counter

	if {$screen_name == $user_name && $chat_msg == "has entered the room."} {
	    return
	}
    }

}


ad_proc -public chat_transcript_new {
    {-description ""}
    {-context_id ""}
    {-creation_user ""}
    {-creation_ip ""}
    pretty_name
    contents
    room_id
} {
    Create chat transcript.
} {

    db_transaction {
	set transcript_id [db_exec_plsql create_transcript {}]
        db_exec_plsql grant_permission {}
#
#	db_dml transcript_content {
#	    update chat_transcripts
#            set contents = empty_clob()
#           where transcript_id = :transcript_id
#            returning contents into :1
#	} -clobs [list $contents]
#    } on_error {
#	ad_return_complaint 1 "Insert fail: $errmsg"
    }

    return $transcript_id

}

ad_proc -public chat_transcript_delete {
    transcript_id
} {
    Delete chat transcript.
} {
    db_exec_plsql delete_transcript {}
}

ad_proc -public chat_transcript_edit {
    transcript_id
    pretty_name
    description
    contents
} {
    Edit chat transcript.
} {
    db_transaction {
	db_exec_plsql edit_transcript {

	}
	#db_dml transcript_content {
	#    update chat_transcripts
        #    set contents = empty_clob()
        #   where transcript_id = :transcript_id
        #    returning contents into :1
	#} -clobs [list $contents]
    }
	
}











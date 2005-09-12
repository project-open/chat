#/chat/www/chat.tcl
ad_page_contract {

    Decide which template to use HTML or Java.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
} {
    room_id
    client
    {message:html ""}
    {template_p 0}
} -properties {
    context_bar:onevalue
    user_id:onevalue
    user_name:onevalue
    message:onevalue
    room_id:onevalue
    room_name:onevalue 
    width:onevalue
    height:onevalue
    host:onevalue
    port:onevalue
    moderator_p:onevalue
    msgs:multirow
}

if { [catch {set room_name [chat_room_name $room_id]} errmsg] } {
    ad_return_complaint 1 "[_ chat.Room_not_found]"
}

set title $room_name
set context [list $title]
set focus "message.message"

set return_url "[ns_conn url]?[ns_conn query]"

set user_id [ad_conn user_id]
set read_p [ad_permission_p $room_id "chat_read"]
set write_p [ad_permission_p $room_id "chat_write"]
set ban_p [ad_permission_p $room_id "chat_ban"]
set admin_p [ad_permission_p $room_id "chat_moderator"]

set iframe_url "/chat/chat?room_id=$room_id&client=plain"
set base_url "/chat/chat?room_id=$room_id&client=html"

set moderate_room_p [chat_room_moderate_p $room_id]

if { $moderate_room_p == "t" } {
    set moderator_p [ad_permission_p $room_id "chat_moderator"]
} else {
    # This is an unmoderate room, therefore everyone is a moderator.
    set moderator_p "1"
}

if { ($read_p == "0" && $write_p == "0") || ($ban_p == "1") } {
    #Display unauthorize privilege page.
    ad_returnredirect unauthorized
    ad_script_abort
}

# Get chat screen name.
set user_name [chat_user_name $user_id]
# Determine which template to use for html or java client


# Get all messages fromt the current user in this room
# marketd as "template_p". These are "saved messages" that
# this user might want to use again.

switch $client {

    java {
	# Java Applet does chat
	set template_use "java-chat"
	# Get config paramater for applet.
	set width [ad_parameter AppletWidth "" 800]
	set height [ad_parameter AppletHeight "" 600]
	set host [ns_config "ns/server/[ns_info server]/module/nssock" Hostname]
	set port [ad_parameter ServerPort]
    }

    plain {
	# plain html window with message - suitable for inside the IFrame
	set template_use "plain-chat"
	chat_message_retrieve msgs $room_id $user_id
	if { ![empty_string_p $message] } {
	    chat_message_post $room_id $user_id $message $moderator_p
	}
    }

    default {
	# HTML Chat - contains an IFrame with the messages
	set template_use "html-chat"
	chat_message_retrieve msgs $room_id $user_id

	set export_form_vars [export_form_vars room_id return_url]

	if { ![empty_string_p $message] } {
	    chat_message_post $room_id $user_id $message $moderator_p

	    # Very, very ugly. I guess that chat_message_post really
	    # communicates with the chat server that in turn addes the
	    # message to the database. So this takes time, and we'll
	    # want to make sure that we'll really get the _last_ msg.
	    exec sleep 1

	    if {$template_p} {
		# Mark the last message posted by this user in this room
		# with "template_p = 't'". I've got _no_ idea who the msgs
		# enter into the DB, but it seems to work somehow with
		# chat_message_post ... :-(
		#
		db_dml update_chat_msgs_template "
			update chat_msgs
			set template_p = 't'
			where msg_id in (
				select	max(msg_id)
				from	chat_msgs
				where	creation_user = :user_id
					and room_id = :room_id
			)
		"

	    }
	}
    }
}


# Get all template messages
db_multirow template_msgs template_msgs {
	
}


db_multirow -extend { msg_encoded } template_msgs template_msgs {} {
    set msg_encoded [ns_urlencode $msg]
}




ad_return_template $template_use

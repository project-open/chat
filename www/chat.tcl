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

set context_bar [list $room_name]
set user_id [ad_conn user_id]
set read_p [ad_permission_p $room_id "chat_read"]
set write_p [ad_permission_p $room_id "chat_write"]
set ban_p [ad_permission_p $room_id "chat_ban"]
set admin_p [ad_permission_p $room_id "chat_moderator"]

#ad_return_complaint 1 "moderator=$moderator_p"

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


chat_message_retrieve template_msgs $room_id $user_id 1


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
	if { ![empty_string_p $message] } {
	    chat_message_post $room_id $user_id $message $moderator_p
	}
	set iframe_url "/chat/chat?room_id=$room_id&client=plain"
    }
}

ad_return_template $template_use











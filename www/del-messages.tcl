#/chat/www/index.tcl
ad_page_contract {
    Delete a number of messages

    @author Frank.Bergmann@project-open.com
    @creation-date September, 2005
    @cvs-id $Id$
} {
    room_id:integer
    msg:array,optional
    return_url
}

# ------------------------------------------------------------------
# Defaults & Security
# ------------------------------------------------------------------

set title "Delete Messages"
set context_bar "$title"
set user_id [ad_conn user_id]
set admin_p [ad_permission_p $room_id "chat_moderator"]
set package_id [ad_conn package_id]

if {!$admin_p} {
    ad_return_complaint 1 "Unsufficient permissions:<br>
    you have unsufficient permissions to delete messages
    for this chat room."
    return
}

# ------------------------------------------------------------------
# Delete Messages
# ------------------------------------------------------------------


set msg_list [array names msg]

foreach msg_id $msg_list {

    db_dml del_msg "
	delete from chat_msgs
	where msg_id = :msg_id
    "
}

ad_returnredirect $return_url
    








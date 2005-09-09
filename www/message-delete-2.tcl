#/chat/www/message-delete-2.tcl
ad_page_contract {
    Delete messages in the room.

    @author David Dao (ddao@arsdigita.com)
    @creation-date January 18, 2001
    @cvs-id $Id$
} {
    room_id:integer,notnull
}

ad_require_permission $room_id chat_room_delete


if { [catch {chat_room_message_delete $room_id} errmsg] } {
    ad_return_complaint 1 "[_ chat.Delete_messages_failed]: $errmsg"
}

ad_returnredirect .
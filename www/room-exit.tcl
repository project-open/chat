#/chat/www/room-exit.tcl
ad_page_contract {
    Post log off message.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 25, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
}

set user_id [ad_conn user_id]


set read_p [ad_permission_p $room_id "chat_read"]
set write_p [ad_permission_p $room_id "chat_write"]
set ban_p [ad_permission_p $room_id "chat_ban"]

if { ($read_p == "0" && $write_p == "0") || ($ban_p == "1") } {
    #Display unauthorize privilege page.
    ad_returnredirect unauthorized
    ad_script_abort
}

chat_message_post $room_id $user_id "[_ chat.has_left_the_room]." "1"

ad_returnredirect index

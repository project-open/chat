#/chat/www/room-enter.tcl
ad_page_contract {

    Perform initialize before chat "Need to change this comment"

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    client:trim
} 
chat_start_server
set user_id [ad_conn user_id]

set return_url [ns_urlencode "[ns_conn url]?[ns_conn query]" ]

set read_p  [ad_permission_p $room_id "chat_read"]
set write_p [ad_permission_p $room_id "chat_write"]
set ban_p   [ad_permission_p $room_id "chat_ban"]
set active  [room_active_status $room_id]


if { ($read_p == "0" && $write_p == "0") || ($ban_p == "1") || ($active == "f") } {
    #Display unauthorize privilege page.
    ad_returnredirect unauthorized?[export_url_vars return_url]
    ad_script_abort
}
if {$client == "html"} {


    chat_message_post $room_id $user_id "[_ chat.has_entered_the_room]." "1"
}

ad_returnredirect "chat?room_id=$room_id&client=$client"

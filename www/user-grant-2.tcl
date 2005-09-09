#/chat/www/user-grant-2.tcl
ad_page_contract {

    Grant chat user privilege.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    party_id:integer,notnull
}

ad_require_permission $room_id chat_user_grant

chat_user_grant $room_id $party_id

ad_returnredirect "room?room_id=$room_id"
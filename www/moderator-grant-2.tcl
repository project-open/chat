#/chat/www/moderator-grant-2.tcl
ad_page_contract {
    
    Add moderator to a room.
    
    @author David Dao (ddao@arsdigita.com)
    @creation-date November 17, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    party_id:integer,notnull
}

ad_require_permission $room_id chat_moderator_grant

chat_moderator_grant $room_id $party_id

ad_returnredirect "room?room_id=$room_id"

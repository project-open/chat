#/chat/www/moderator-grant.tcl
ad_page_contract {

    Add moderator to a room.
    @author David Dao (ddao@arsdigita.com)
    @creation-date November 16, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
} -properties {
    context_bar:onevalue
    title:onevalue
    action:onevalue
    submit_label:onevalue
    room_id:onevalue
    description:onevalue
    parties:multirow
}

ad_require_permission $room_id chat_moderator_grant

set context_bar [list "[_ chat.Grant_moderator]"]
set submit_label "[_ chat.Grant]"
set title "[_ chat.Grant_moderator]"
set action "moderator-grant-2"
set description "[_ chat.Grant_moderator_for] <b>[chat_room_name $room_id]</b> [_ chat.to]"
db_multirow parties list_parties {}

ad_return_template grant-entry


#/chat/www/user-revoke.tcl
ad_page_contract {
    
    Display confirmation before remove chat user.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    party_id:integer,notnull
}

ad_require_permission $room_id chat_user_revoke

set context_bar [list [list "room?room_id=$room_id" "[_ chat.Room_Information]"] "[_ chat.Revoke_user]"]

set party_pretty_name [db_string get_party_name {} ]

set pretty_name [chat_room_name $room_id]

ad_return_template

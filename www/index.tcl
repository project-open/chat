#/chat/www/index.tcl
ad_page_contract {
    Display a list of available chat rooms that the user has permission to edit.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 13, 2000
    @cvs-id $Id$
} {
} -properties {
    context_bar:onevalue
    package_id:onevalue
    user_id:onevalue
    room_create_p:onevalue
    rooms:multirow
}

set package_id [ad_conn package_id]

set context_bar [list]

set user_id [ad_conn user_id]

set room_create_p [ad_permission_p $package_id chat_room_create]


db_multirow rooms rooms_list {}


ad_return_template
    








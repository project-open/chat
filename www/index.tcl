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

# ------------------------------------------------------------------
# Defaults & Security
# ------------------------------------------------------------------

# This package may be available for unregistered users,
# depending on the concrete use. So can can't just require
# that the user should be logged in...

set title [_ chat.Chat_main_page]
set context_bar "$title"
set user_id [ad_conn user_id]
set package_id [ad_conn package_id]

set room_create_p [ad_permission_p $package_id chat_room_create]

# ------------------------------------------------------------------
# Calculate the list of chat rooms
# ------------------------------------------------------------------

db_multirow rooms rooms_list {}

ad_return_template

    








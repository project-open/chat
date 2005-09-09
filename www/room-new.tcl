#/chat/www/room-new.tcl
ad_page_contract {
    Display a form to create a new room.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 13, 2000
    @cvs-id $Id$
} {
} -properties {
    context_bar:onevalue
    room_id:onevalue
    title:onevalue
    action:onevalue
    submit_label:onevalue
    pretty_name:onevalue
    moderated_p:onevalue
}

ad_require_permission [ad_conn package_id] chat_room_create

set context_bar [list "[_ chat.Create_a_room]"]
set title "[_ chat.Create_a_room]"
set action "room-new-2"
set submit_label "[_ chat.Create_room]"
set pretty_name ""
set description ""
set moderated_p "f"
set archive_p "f"
set active_p "t"
set room_id ""

ad_return_template "room-entry"


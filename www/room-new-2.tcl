#/chat/www/room-new-2.tcl
ad_page_contract {
    Add a new room to the database.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 15, 2000
    @cvs-id $Id$
} {
    pretty_name:notnull,trim
    {description:trim ""}
    {moderated_p "f"}
    {archive_p "f"}
    {active_p "t"}
}

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set creation_ip [ad_conn peeraddr]

ad_require_permission $package_id chat_room_create

if {[catch {set room_id [chat_room_new -moderated_p $moderated_p \
                          -description $description \
                          -active_p $active_p \
                          -archive_p $archive_p \
                          -context_id $package_id \
                          -creation_user $user_id \
		          -creation_ip $creation_ip $pretty_name]} errmsg]} {
    ad_return_complaint 1 "[_ chat.Create_new_room_failed]: $errmsg"
}

ad_returnredirect "room?room_id=$room_id"







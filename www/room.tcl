#/www/chat/room.tcl
ad_page_contract {
    Display information about chat room.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 15, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
} -properties {
    context_bar:onevalue
    pretty_name:onevalue
    description:onevalue
    archive_p:onevalue
    moderated_p:onevalue
    active_p:onevalue
    room_view_p:onevalue
    room_edit_p:onevalue
    room_delete_p:onevalue
    user_ban_p:onevalue
    user_unban_p:onevalue
    user_grant_p:onevalue
    user_revoke_p:onevalue
    moderator_grant_p:onevalue
    moderator_revoke_p:onevalue
    transcript_create_p:onevalue
    transcript_delete_p:onevalue
    transcript_edit_p:onevalue
    transcript_view_p:onevalue
    moderators:multirow
    users_allow:multirow
    users_ban:multirow
    chat_transcripts:multirow
}

set context_bar [list "[_ chat.Room_Information]"]


###
# Get all available permission of this user on this room.
###
set room_view_p [ad_permission_p $room_id chat_room_view]
set room_edit_p [ad_permission_p $room_id chat_room_edit]
set room_delete_p [ad_permission_p $room_id chat_room_delete]
set user_ban_p [ad_permission_p $room_id chat_user_ban]
set user_unban_p [ad_permission_p $room_id chat_user_unban]
set user_grant_p [ad_permission_p $room_id chat_user_grant]
set user_revoke_p [ad_permission_p $room_id chat_user_revoke]
set moderator_grant_p [ad_permission_p $room_id chat_moderator_grant]
set moderator_revoke_p [ad_permission_p $room_id chat_moderator_revoke]
set transcript_create_p [ad_permission_p $room_id chat_transcript_create]
set transcript_delete_p [ad_permission_p $room_id chat_transcript_delete]
set transcript_edit_p [ad_permission_p $room_id chat_transcript_edit]
set transcript_view_p [ad_permission_p $room_id chat_transcript_view]

###
# End geting all available permissions.
###

###
# Get room basic information.
###


#db_1row room_info {
#    select pretty_name, description, decode(moderated_p, 't', 'Yes', 'No') as moderated_p,
#           decode(archive_p, 't', 'Yes', 'No') as archive_p,
#           decode(active_p, 't', 'Yes', 'No') as active_p
#    from chat_rooms
#    where room_id = :room_id
#}

db_1row room_info {
    select pretty_name, description, moderated_p, active_p, archive_p
    from chat_rooms
    where room_id = :room_id
}

# List available room moderators.
db_multirow moderators list_moderators {}

# List authorized chat users.
# db_multirow users_allow list_user_allow {}

# List user ban from chat
db_multirow users_ban list_user_ban {}


# List available chat transcript
db_multirow chat_transcripts list_transcripts {}

ad_return_template











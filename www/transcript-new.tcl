#/chat/www/transcript-new.tcl
ad_page_contract {
    Display available all available chat messages.
} {
    room_id:integer,notnull
} -properties {
    context_bar:onevalue
    title:onevalue
    action:onevalue
    room_id:onevalue
    transcript_id:onevalue
    transcript_name:onevalue
    description:onevalue
    contents:onevalue
}

ad_require_permission $room_id chat_transcript_create

set context_bar [list [list "room?room_id=$room_id" "[_ chat.Room_Information]"] "[_ chat.Create_transcript]"]

set transcript_id ""
set transcript_name "[_ chat.Untitled]"
set description ""
set contents ""
set action "transcript-new-2"
set title "[_ chat.Create_transcript]"
set submit_label "[_ chat.Create_transcript]"

#Build a list of all message.
db_foreach get_archives_messages {} {
    append contents "<b>$name</b>: $msg<br>\n"
}

ad_return_template "transcript-entry"









#/chat/www/transcript-edit.tcl
ad_page_contract {
    Retrieve transcript content.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 28, 2000
    @cvs-id $Id$
} {
    transcript_id:integer,notnull
    room_id:integer,notnull
} -properties {
    context_bar:onevalue
    title:onevalue
    room_id:onevalue
    transcript_id:onevalue
    transcript_name:onevalue
    description:onevalue
    contents:onevalue
    action:onevalue
    submit_label:onevalue
}

ad_require_permission $transcript_id chat_transcript_edit
set context_bar [list "[_ chat.Edit_transcript]"]

set title "[_ chat.Edit_transcript]"
set action "transcript-edit-2"
set submit_label "[_ chat.Edit]"

db_1row get_transcript_info {
    select pretty_name as transcript_name,
           description,
           contents
    from chat_transcripts
    where transcript_id = :transcript_id
}

ad_return_template "transcript-entry"


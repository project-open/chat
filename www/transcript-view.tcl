#/chat/www/transcript-view.tcl
ad_page_contract {
    Preview chat transcript.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 28, 2000
    @cvs-id $Id$
} {
    transcript_id:integer,notnull
} -properties {
    context_bar:onevalue
    transcript_name:onevalue
    transcript_id:onevalue
    room_id:onevalue
    description:onevalue
    contents:onevalue
}

ad_require_permission $transcript_id chat_transcript_view

set context_bar [list "[_ chat.View_transcript]"]
db_1row get_transcript {
    select pretty_name as transcript_name,
           description,
           contents,
           room_id
    from chat_transcripts
    where transcript_id=:transcript_id
}

ad_return_template

#/chat/www/transcript-delete.tcl
ad_page_contract {
    Display confirmation before delete chat transcript.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 28, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    transcript_id:integer,notnull
} -properties {
    context_bar:onevalue
    room_id:onevalue
    transcript_id:onevalue
}

ad_require_permission $transcript_id chat_transcript_delete

set context_bar [list "[_ chat.Delete_transcript]"]
ad_return_template

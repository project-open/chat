#/chat/www/transcript-delete-2.tcl
ad_page_contract {
    Delete chat transcript.
} {
    room_id:integer,notnull
    transcript_id:integer,notnull
    
}

ad_require_permission $transcript_id chat_transcript_delete



if { [catch {chat_transcript_delete $transcript_id} errmsg] } {
    ad_return_complaint 1 "[_ chat.Delete_transcript_failed]: $errmsg"
}

ad_returnredirect "room?room_id=$room_id"

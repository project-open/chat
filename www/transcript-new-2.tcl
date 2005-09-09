#/chat/www/transcript-new-2.tcl
ad_page_contract {
    Save transcript.
} {
    room_id:integer,notnull
    transcript_name:trim,notnull
    {description:trim ""}
    contents:trim,notnull,html
} 

ad_require_permission $room_id chat_transcript_create

set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set creation_ip [ad_conn peeraddr]


set transcript_id [chat_transcript_new -description $description \
                                                   -context_id $package_id \
                                                   -creation_user $user_id \
                                                   -creation_ip $creation_ip \
						    $transcript_name $contents $room_id]


ad_returnredirect "transcript-view?room_id=$room_id&transcript_id=$transcript_id"







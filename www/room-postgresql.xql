<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="list_moderators">
  <querytext>
    select party_id, acs_object__name(party_id) as name
    from acs_object_party_privilege_map
    where object_id = :room_id
    and privilege = 'chat_room_moderate'
  </querytext>
</fullquery>

<fullquery name="list_user_allow">
  <querytext>
    select distinct party_id, acs_object__name(party_id) as name
    from acs_object_party_privilege_map
    where object_id = :room_id
    and (privilege = 'chat_read' or privilege = 'chat_write')
 </querytext>
</fullquery>


<fullquery name="list_user_ban">
  <querytext>
   select party_id, acs_object__name(party_id) as name
    from acs_object_party_privilege_map
    where object_id = :room_id
    and privilege = 'chat_ban'
  </querytext>
</fullquery>


<fullquery name="list_transcripts">
  <querytext>
   select transcript_id, pretty_name
    from chat_transcripts
    where room_id = :room_id
 </querytext>
</fullquery>

</queryset>









<?xml version="1.0"?>
<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>


<fullquery name="get_archives_messages">
  <querytext>
    select msg, person.name(creation_user) as name
    from chat_msgs
    where room_id = :room_id
          and msg is not null
    order by msg_id
  </querytext>
</fullquery>


</queryset>

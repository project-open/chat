<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="get_archives_messages">
  <querytext>
    select msg, person__name(creation_user) as name
    from chat_msgs
    where room_id = :room_id
          and msg is not null
    order by msg_id
  </querytext>
</fullquery>

</queryset>

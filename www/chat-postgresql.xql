<?xml version="1.0"?>
<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="template_msgs">
  <querytext>

	select
		*
	from
		chat_msgs
	where
		creation_user = :user_id
		and room_id = :room_id
		and template_p = 't'
	order by
		creation_date
  </querytext>
</fullquery>

</queryset>


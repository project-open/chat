<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="rooms_list">
	<querytext>

select r.* 
from (
	select 
		rm.room_id, 
		rm.pretty_name, 
		rm.description, 
		rm.moderated_p, 
		rm.active_p, 
		rm.archive_p,
		acs_permission__permission_p(room_id, :user_id, 'chat_room_admin') as admin_p
	from 
		chat_rooms rm, 
		acs_objects obj
	where 
		obj.context_id = :package_id
		and rm.room_id = obj.object_id
	order by 
		rm.pretty_name
	) r
where
	r.admin_p = 't' or r.active_p = 't'

    	</querytext>
</fullquery>

</queryset>
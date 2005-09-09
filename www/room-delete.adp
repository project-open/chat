<!--
    Display confirmation for deleting chat room.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Confirm_room_delete#</property>

<form method="post" action="room-delete-2">	
<input type=hidden name=room_id value=@room_id@>
#chat.Are_you_sure_you_want_to_delete# @pretty_name@?
<p><input type=submit value=#chat.Yes#>
</form>



<!--
     Display a list of available rooms.

     @author David Dao (ddao@arsidigta.com)
     @creation-date November 13, 2000
     @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Chat_main_page#</property>


<if @room_create_p@ ne 0>
[<a href="room-new">#chat.Create_a_new_room#</a>]
</if>

<if @rooms:rowcount@ eq 0>
<p><i>#chat.There_are_no_rooms_available#</i>
</if>
<else>
<table>
    <multiple name=rooms>
    <if @rooms.active_p@ eq "t" or @rooms.admin_p@ eq "t">
    <tr>
	<td valign=top><dt><p><b>@rooms.pretty_name@</b></td>

        <td valign=top>
            [<a href="room-enter?room_id=@rooms.room_id@&client=html">#chat.HTML_chat#</a>]
<!--
            [<a href="room-enter?room_id=@rooms.room_id@&client=java">#chat.Java_chat#</a>]
	    <if @rooms.moderated_p@> (#chat.Moderated#) </if>
-->
	    <if @rooms.admin_p@ eq "t">[<a href="room?room_id=@rooms.room_id@">#chat.room_admin#</a>] #chat.Active#:@rooms.active_p@</if>
        </td>

        <td valign=top>
        <i>@rooms.description@</i></td>
     </tr>
     </if>
     </multiple>
</table>
</else>

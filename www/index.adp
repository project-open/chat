<master>
<property name="context_bar">@context_bar;noquote@</property>
<property name="title">@title@</property>

<h2>Chat Rooms</h2>

<table class="list">

  <tr class="list-header">
    <th class="list-narrow">Room Name</th>
    <th class="list-narrow">Description</th>
    <th class="list-narrow">Admin</th>
  </tr>

<multiple name=rooms>
    <if @rooms.active_p@ eq "t" or @rooms.admin_p@ eq "t">
	<if @rooms.rownum@ odd>
	  <tr class="list-odd">
	</if> <else>
	  <tr class="list-even">
	</else>
	
	<td class="list-narrow">
		<a href="room-enter?room_id=@rooms.room_id@&client=html">
		  @rooms.pretty_name@
		</a>
		<if @rooms.moderated_p@> 
		  (#chat.Moderated#)
		</if>
	</td>
	<td class="list-narrow">
	      @rooms.description@
	</td>
		<td class="list-narrow">
		<if @rooms.admin_p@ eq "t">
		  <a href="room?room_id=@rooms.room_id@">
		    Admin
		  </a>
		</if>
		</td>
	</tr>
    </if>
</multiple>

<if @rooms:rowcount@ eq 0>
  <tr>
    <td colspan=99 align=center>
      <i>There are no active chat rooms in the moment</i>
    </td>
  </tr>
</if>

</table>


<if @room_create_p@ ne 0>
[<a href="room-new">#chat.Create_a_new_room#</a>]
</if>


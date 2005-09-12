<master>
  <property name="context">@context;noquote@</property>
  <property name="title">@room_name;noquote@</property>
  <property name="focus">asdf</property>
  <property name="focus">message.message</property>

<table valign=top>
<tr valign=top>
<td>

	<table cellpadding=1 cellspacing=0 class="table-display">
	<tr class="table-header">
	  <th colspan=2>Chat Room</th>
	</tr>
	<tr>
	  <td></td>
	  <td>[<a href="room-exit?room_id=@room_id@">#chat.Log_off#</a>]</td>
	</tr>
	<tr>
	  <td></td>
	  <td>
		<IFRAME 
			SRC=@iframe_url;noquote@ 
			TITLE="project-open.com" 
			WIDTH=400 
			HEIGHT=300 
			SCROLLING=YES
			FRAMEBORDER=0
		>
		Your browser doesn't support IFrames.<br>
		This IFrame should have shown you a chat
		conversaton.<br>
		Please upgrade to a more recent version
		of your browser.
		</IFRAME>
	  </td>
	</tr>
	<tr>
	  <td></td>
	  <td>
		<form name=message method=post action="chat">
		<input name=message size=40>
		<input type=hidden name="room_id" value="@room_id@">
		<input type=hidden name="client" value="html">
		<input type=submit value="Send">
	<if @admin_p@ eq 1>
		<input type=checkbox name=template_p value="1"> Template
	</if>
	<else>
		<input type=hidden name=template_p value="0">
	</else>
		</form>
	  </td>
	</tr>
	</table>
	

</td>
<td>

<if @admin_p@ eq 1>

	<form action="del-messages" method=POST>
	@export_form_vars;noquote@
	<table cellpadding=1 cellspacing=0 class="table-display">
	<tr class="table-header">
	  <th>Tempate Messages</th>
	  <th>Del</th>
	</tr>
	
	<multiple name=template_msgs>
	<tr>
	  <td class="odd" width=400>
	    <a href="@base_url@&message=@template_msgs.msg_encoded@">@template_msgs.msg;noquote@</a>
	    <br>
	  </td>
	  <td class="odd">
	    <input type=checkbox name=msg.@template_msgs.msg_id@ value="1">
	  </td>
	</tr>
	</multiple>

	<tr>
	<td colspan=2 align=right>
	  <input type=submit value="Del">
	</td>
	</tr>

	</table>

</if>

</td>
</tr>
</table>

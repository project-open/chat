<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">@room_name;noquote@</property>
<property name="refresh">3</property>

<table valign=middle>
<tr>
  <td></td>
  <td>[<a href="room-exit?room_id=@room_id@">#chat.Log_off#</a>]</td>
</tr>

<tr>
  <td>Msgs:</td>
  <td>
	<IFRAME 
		SRC=@iframe_url;noquote@ 
		TITLE="project-open.com" 
		WIDTH=400 
		HEIGHT=300 
		SCROLLING=NO 
		FRAMEBORDER=1
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
	<form method=post action="chat">
	<input name=message size=40>
	<input type=hidden name="room_id" value="@room_id@">
	<input type=hidden name="client" value="html">
	<input type=submit value="Send">
	</form>
  </td>
</tr>

</table>



<!--
<ul>

<if @message@ ne "">
<if @moderator_p@ eq "1">
@user_name@: @message@<br>
</if>
</if>
<multiple name=msgs>
@msgs.screen_name@: @msgs.chat_msg@<br>
</multiple>

</ul>

-->




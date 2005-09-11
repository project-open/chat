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
  <td></td>
  <td>
	<IFRAME 
		SRC=@iframe_url;noquote@ 
		TITLE="project-open.com" 
		WIDTH=400 
		HEIGHT=300 
		SCROLLING=NO 
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
	<form method=post action="chat">
	<input name=message size=40>
	<input type=hidden name="room_id" value="@room_id@">
	<input type=hidden name="client" value="html">
	<input type=submit value="Send">

<if @admin_p@ eq 1>
	<input type=checkbox name=template_p> Template
</if>
<else>
	<input type=hidden name=template_p value="">
</else>
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
</ul>
-->

<if @admin_p@ eq 1>

  <h2>Template Message: @admin_p@</h2>

  <multiple name=template_msgs>
  @template_msgs.chat_msg;noquote@<br>
  </multiple>

</if>


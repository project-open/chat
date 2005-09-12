<master src="/www/blank-master">
<property name="header_stuff">
  <meta http-equiv="refresh" content="5">
</property>


<if @message@ ne "">
<if @moderator_p@ eq "1">
@user_name@: @message@<br>
</if>
</if>
<multiple name=msgs>
<b>@msgs.screen_name@</b>: @msgs.chat_msg;noquote@<br>
</multiple>



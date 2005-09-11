<!--
     Display detail information about available room.

     @author David Dao (ddao@arsdigita.com)
     @creation-date November 13, 2000
     @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Room_Information#</property>

<h4>#chat.Room_Information#</h4>
<if @room_view_p@ eq "1">
<ul>
<li>#chat.Room_name#: @pretty_name@
<li>#chat.Description#: <blockquote>@description@</blockquote>
<li>#chat.Moderated#: @moderated_p@
<li>#chat.Active#:  @active_p@
<li>#chat.Archive#: @archive_p@
<if @room_edit_p@ eq "1">
<p>(<a href="room-edit?room_id=@room_id@">#chat.Edit#</a>)
</if>
</ul>
</if>
<else>
<p><i>#chat.No_information_available#.
</else>


<b>#chat.Users_ban#</b>
<ul>
<multiple name=users_ban>
   <li>@users_ban.name@</li>
   <if @user_unban_p@ eq "1">(<a href="user-unban?room_id=@room_id@&party_id=@users_ban.party_id@">#chat.unban#</a>)</if>
</multiple>
   <if @user_ban_p@ eq "1">
      <p>(<a href="user-ban?room_id=@room_id@">#chat.Ban_user#</a>)
   </if>
</ul>
<b>#chat.Room_moderators#</b>
<ul>
<multiple name=moderators>
   <li>@moderators.name@
   <if @moderator_revoke_p@ eq "1">
       (<a href="moderator-revoke?party_id=@moderators.party_id@&room_id=@room_id@">#chat.remove#</a>)
   </if>
</multiple>

<if @moderator_grant_p@ eq "1">
   <p>(<a href="moderator-grant?room_id=@room_id@">#chat.Add_moderator#</a>)
</if>
</ul>
<p><b>#chat.Transcripts#</b>
<ul>
<multiple name=chat_transcripts>
<li>@chat_transcripts.pretty_name@ 
(<a href="transcript-view?transcript_id=@chat_transcripts.transcript_id@">#chat.View#</a>)
<if @transcript_delete_p@ eq "1">
 (<a href="transcript-delete?transcript_id=@chat_transcripts.transcript_id@&room_id=@room_id@">#chat.remove#</a>)
</if>
</multiple>
<if @transcript_create_p@ eq "1">
<p>(<a href="transcript-new?room_id=@room_id@">#chat.Create_transcript#</a>)
</if>

</ul>
<if @room_delete_p@ eq "1">
<p><b>#chat.Extreme_Actions#</b>
<ul>
<li><a href="message-delete?room_id=@room_id@">#chat.Delete_all_messages_in_the_room#</a>
<li><a href="room-delete?room_id=@room_id@">#chat.Delete_room#</a>
</ul>
</if>


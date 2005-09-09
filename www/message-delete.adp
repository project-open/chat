<!--
    Display confirmation for delete chat messages in the room.

    @author David Dao (ddao@arsdigita.com)
    @creation-date January 18, 2001
    @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Confirm_message_delete#</property>

<form method="post" action="message-delete-2">
<input type=hidden name=room_id value=@room_id@>
#chat.Are_you_sure_you_want_to_delete# @message_count@ #chat.messages_in# @pretty_name@?
<p><input type=submit value=#chat.Yes#>
</form>
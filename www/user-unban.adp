<!--
    Display confirmation.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 22, 2000
    @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Confirm_unban_user#</property>

<form method=post action=user-unban-2>
<input type=hidden name=room_id value="@room_id@">
<input type=hidden name=party_id value="@party_id@">
#chat.Are_you_sure_you_want_to_unban#  <b>@party_pretty_name@</b> #chat.from# @pretty_name@?
<p><input type=submit value="#chat.Unban#">
</form>

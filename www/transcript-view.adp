<!--
     Chat transcript preview.

     @author David Dao (ddao@arsdigita.com)
     @creation-date November 27, 2000
     @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">#chat.Transcript_preview#</property>

[<a href="transcript-edit?transcript_id=@transcript_id@&room_id=@room_id@">#chat.Edit#</a>]
<ul>
<li>#chat.Name#: <b>@transcript_name@</b>
<li>#chat.Description#: <b><i>@description@</i></b>
<li>#chat.Contents#:  <p> <pre>@contents@</pre>

<ul>
<p>@contents@
</ul>
</ul>



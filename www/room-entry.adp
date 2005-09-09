<!--
    Create/edit form for room information.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 17, 2000
    @cvs-id $Id$
-->
<master>
<property name="context">@context_bar;noquote@</property>
<property name="title">@title;noquote@</property>

<form action="@action@" method="post">
   <input type="hidden" name="room_id" value="@room_id@">
   <blockquote>
      <table>
         <tr>
            <th align="right">#chat.Room_name#:</th>
            <td><input size="50" name="pretty_name" value="@pretty_name@"></td>
	 </tr>
         <tr>
            <th align="right">#chat.Description#:</th>
            <td><textarea name="description" rows=6 cols=65>@description@</textarea>
         </tr>
         <tr>
	    <th align="right">#chat.Moderated#:</th>
	    <if @moderated_p@ eq "t">
               <td><input type="checkbox" name="moderated_p" value="t" checked></td>
	    </if>
            <else>
               <td><input type="checkbox" name="moderated_p" value="t"></td>
	    </else>
          </tr>
	<tr>
	   <th align="right">#chat.Active#:</th>
	   <if @active_p@ eq "t">
	      <td><input type="checkbox" name="active_p" value="t" checked></td>
	   </if>
	   <else>
	      <td><input type="checkbox" name="active_p" value="t"></td>
           </else>
         </tr>
         <tr>
	   <th align="right">#chat.Archive#:</th>
           <if @archive_p@ eq "t">
	      <td><input type="checkbox" name="archive_p" value="t" checked></td>
           </if>
           <else>
              <td><input type="checkbox" name="archive_p" value="t"></td>
           </else>
          </tr>
          <tr>
            <th></th>
            <td><input type="submit" value="@submit_label@"></td>
       </table>
    </blockquote>
</form>







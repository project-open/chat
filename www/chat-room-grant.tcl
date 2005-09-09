ad_page_contract {
    
    @author David Dao (ddao@arsdigita.com)
    @creation-date November 16, 2000
    @cvs-id $Id$
} {
    room_id:integer,notnull
    pretty_name:trim,notnull
    require_privilege:trim,notnull
    assign_privilege:trim,notnull
}

ad_require_permission $room_id $require_privilege

doc_body_append "[ad_header "Grant permission on $pretty_name"]

<h2>Grant permission on $pretty_name</h2>

[list "Grant permission on $pretty_name"]

<hr>

<form method=post action=chat-room-grant-2>
[export_form_vars room_id require_privilege assign_privilege]
<select name=party_id>
"

db_foreach parties {
  select party_id, acs_object.name(party_id) as name
  from parties
} {
  doc_body_append "<option value=$party_id>$name</option>\n"
}

doc_body_append "
</select>

</form>

[ad_footer]
"

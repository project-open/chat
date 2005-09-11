#/chat/www/unauthorized.tcl
ad_page_contract {
    Display unauthorized message.

    @author David Dao (ddao@arsdigita.com)
    @creation-date November 24, 2000.
    @cvs-id $Id$
} {
    { return_url "" }

} -properties {
    context_bar:onevalue
}

set context_bar [list "[_ chat.Unauthorized_privilege]"]
# set return_url [ns_set iget [ns_conn headers] Referer]

ad_return_template
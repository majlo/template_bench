<!DOCTYPE html>
<html>
  <head><title>Welcome</title></head>
    <body>
        <h2><TMPL_VAR NAME=message></h2>
        This page was generated from the template "templates/example/welcome.html.ep"
        and the layout "templates/layouts/default.html.ep",
        <a href="<TMPL_VAR NAME=c.url_for>">click here</a> to reload the page or
        <a href="/index.html">here</a> to move forward to a static page.
    </body>
</html>

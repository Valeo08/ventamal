<%@ page pageEncoding="UTF-8" %>
<% if (request.getAttribute("email-valido").equals("NO")) { %>
<div class="mt-2 alert alert-danger" role="alert">
    This email is already registered in <strong>Ventamal</strong>.
</div>
<% } %>

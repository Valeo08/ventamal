<%@ page pageEncoding="UTF-8" %>
<% if (request.getAttribute("tlf-valido").equals("NO")) { %>
<div class="mt-2 alert alert-danger" role="alert">
    That phone is already registered in <strong>Ventamal</strong>.
</div>
<% } %>
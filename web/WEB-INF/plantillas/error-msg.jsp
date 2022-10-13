<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
String msj = (String)request.getAttribute("msj");

if (msj != null) {%>
<div class="col-md-6 offset-md-3 text-center my-auto">
    <div id="articulo-error" class="mt-2" role="alert">
        <h3 class="fs-3"><%=msj%></h3>
        <a href="inicio" class="mx-auto mt-5 btn btn-lg btn-primary fw-bold">
        Back to home
        </a>
    </div>
</div>
<% } %>

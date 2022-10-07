<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="valeo.ventamal.entidades.Comentario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    
String msj = (String)request.getAttribute("msj");
List<Comentario> comentarios = (List<Comentario>)request.getAttribute("comentarios");

%>

<% if (msj != null) {%>
<div id="articulo-error" class="mt-2 alert alert-danger" role="alert">
    <%=msj%>
</div>
<%}%>

<% if (comentarios != null && comentarios.size() > 0) {%>
<%for (Comentario c : comentarios) {%>
<div class="mb-3">
    <%
    String formato1 = "dd/MM/yyyy";
    String formato2 = "HH:mm";
    SimpleDateFormat sdf1 = new SimpleDateFormat(formato1);
    SimpleDateFormat sdf2 = new SimpleDateFormat(formato2);
    Date fecha = new Date(c.getFechaPublicacion().getTime());
    %>
    <p class="fs-5 mb-2"><%=c.getUsuario().getNombre()%></p>
    <p class="fs-6 p-2 mb-1"><%=c.getTexto()%></p>
    <p class="small fw-light">Posted on <%=sdf1.format(fecha)%> at <%=sdf2.format(fecha)%></p>
</div>
<%}%>
<%} else {%>
<p>There are no comments yet.</p>
<%}%>

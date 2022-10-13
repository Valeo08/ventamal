<%@page import="valeo.ventamal.entidades.Articulo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

List<Articulo> articulos = (List<Articulo>)request.getAttribute("articulos");

%>

<% if (articulos != null && !articulos.isEmpty()) { for (Articulo a : articulos) {%>
<div class="col mb-2">
    <a href="articulo?id=<%=a.getId()%>" class="text-decoration-none text-reset">
        <div class="card h-100">
            <% if (a.tieneImagen()) {%>
            <img class="card-img-overlay img-fluid rounded card-img-custom
                 <%if(a.isVendido()) {%>img-vendido<%}%>" src="datos/<%=a.getUsuario().getId()%>/<%=a.getId()%>.jpg"/>
            <%}%>
            
            <% if (a.isVendido()) {%>
            <div class="rotulo-vendido">SOLD</div>
            <%}%>
            
            <div class="card-body">
                <h5 class="card-title fw-bold fs-4"><%=a.getNombre()%></h5>
                <p class="card-text">
                    <span class="fs-5">Price: <%=a.getPrecio()%> &euro;</span>

                    <% if (!a.tieneImagen()) {%>
                    <br><br>
                    <%=a.getDescripcion()%>
                    <%}%>
                </p>
            </div>
        </div>
    </a>
</div>
<%}} else { %>
<div class="col-12 mb-2">No matching products were found.</div>
<%}%>
<%@page import="valeo.ventamal.entidades.Articulo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

List<Articulo> articulos = (List<Articulo>)request.getAttribute("articulos");

%>

<% if (articulos != null && !articulos.isEmpty()) { for (Articulo a : articulos) {%>
<div class="col mb-2">
    <div class="card h-100">
        <a href="articulo?id=<%=a.getId()%>" class="text-decoration-none text-reset">
            <% if (a.tieneImagen()) {%>
            <img class="card-img-top img-fluid rounded" src="img/<%=a.getId()%>.jpg"
                 width="0.5em" height="0.5em"/>
            <%}%>
            <div class="card-body">
              <h5 class="card-title fw-bold"><%=a.getNombre()%></h5>
              <p class="card-text">
                  Postal code: <%=a.getUsuario().getCp()%>
                  <br>
                  Price: <%=a.getPrecio()%> &euro;

                  <% if (!a.tieneImagen()) {%>
                  <br><br>
                  <%=a.getDescripcion()%>
                  <%}%>
              </p>
            </div>
        </a>
    </div>
</div>
<%}} else { %>
<div class="col-12 mb-2">No matching products were found.</div>
<%}%>
<%--
    Si el usuario está logueado verá una barra de navegación con más
    opciones disponibles (publicar, artículos de su interés, etc) en
    comparación al caso de que cuando no ha iniciado sesión.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    boolean logueado = session.getAttribute("usuario") != null;
%>

<nav class="navbar navbar-expand-md p-0" id="navbar">
    <div class="container-fluid navbar-light">
        <a class="navbar-brand fs-4 fw-bold p-1" href="inicio">
            <img id="logo" loading="lazy" src="img/logo.svg" alt="Ventamal logo">
            Ventamal
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" id="nav-inicio" aria-current="page" href="inicio">Home</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" id="nav-articulos" href="articulos">Products</a>
                </li>
                
                <%-- Solo disponible cuando el usuario está logueado --%>
                <% if (logueado) { %>
                <li class="nav-item">
                    <a class="nav-link" id="nav-publicar" href="publicar">Publish</a>
                </li>
                
                <li class="nav-item">
                    <a class="nav-link" id="nav-interes" href="interes">Interest</a>
                </li>
                <% } %>
                <%-- Solo disponible cuando el usuario está logueado --%>
                
                <%-- Solo disponible cuando el usuario no está logueado --%>
                <% if (!logueado) { %>
                <li class="nav-item">
                    <a class="nav-link" id="nav-login" href="iniciar-sesion">Log in</a>
                </li>
                <% } %>
                <%-- Solo disponible cuando el usuario no está logueado --%>
            </ul>
            
            <%-- Solo disponible cuando el usuario está logueado --%>
            <% if (logueado) { %>
            <ul class="navbar-nav" id="nav-logout">
                <li class="nav-item">
                    <a class="nav-link" href="#modal-logout" data-bs-toggle="modal" 
                       data-bs-target="#modal-logout">Log out</a>
                </li>
            </ul>
            
            <div class="modal fade" id="modal-logout" data-bs-backdrop="static" data-bs-keyboard="false" 
                 tabindex="-1" aria-labelledby="modal-logout-label" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modal-logout-label">Confirm</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                        Do you want to close the current session?
                        </div>
                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                          <a class="btn btn-primary" href="logout">Log out</a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <%-- Solo disponible cuando el usuario está logueado --%>
        </div>
        
    </div>
</nav>

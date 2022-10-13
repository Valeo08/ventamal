<%--
    Si el usuario está logueado verá un mensaje de bienvenida,
    en caso contrario habrá un formulario para iniciar sesión
    o registrarse, si no lo está ya.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% boolean logueado = session.getAttribute("usuario") != null; %>

<% if (logueado) { %>

<h3 class="fs-4">
    Hi, <%=session.getAttribute("usuario")%>
</h3>

<p class="fs-5 me-4">
    Welcome back to Ventamal. Have a look at the articles that have been 
    published, or publish one yourself.
</p>

<% } else { %>

<h3 class="fs-4">
    <i class="bi bi-box-arrow-in-left"></i>
    Log in
</h3>
<div id="wrapper-login-lateral" class="p-4">
    <form method="POST" action="login">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
        </div>

        <div class="mb-3">
            <label for="pass" class="form-label">Password</label>
            <input type="password" class="form-control" id="pass" name="pass" placeholder="Password" required>
        </div>

        <div class="mb-3 row">
            <div class="mb-2 col-sm-10">
                <input class="btn btn-primary" type="submit" value="Log in">
            </div>
            <div class="col-sm-10 fs-6">
                No account?
                <a class="text-decoration-none" href="alta"> Sign up</a>.
            </div>
        </div>
    </form>
</div>

<% } %>
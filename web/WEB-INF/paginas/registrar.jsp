<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

Boolean error = (Boolean)request.getAttribute("error");
String msj = (String)request.getAttribute("msj");
String email = (String)request.getAttribute("email");
String nombre = (String)request.getAttribute("nombre");
String cp = (String)request.getAttribute("cp");
String tlf = (String)request.getAttribute("tlf");
String direccion = (String)request.getAttribute("direccion");
String facebook = (String)request.getAttribute("facebook");
String twitter = (String)request.getAttribute("twitter");

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Sign up</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div id="wrapper-registro" class="col-xl-4 offset-xl-4 col-md-6 offset-md-3 col-10 offset-1 border border-2 rounded-2 p-3 mb-5">
                    <h3 class="fs-4">Sign up</h3>
                    <% if (error != null && error) { %>
                    <div id="registro-error" class="mt-2 alert alert-danger" role="alert">
                        Registration failed: <%=msj%>
                    </div>
                    <% } %>
                    <form id="form-registro" method="POST" action="registrar" validate onsubmit="return validar();">
                        <div class="row">
                            <div class="col-md-12 col-12 mb-3">
                                <label for="email" class="form-label">Email<span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required
                                       <% if (email != null && email != "") { %>value="<%=email%>"<%}%>  onchange="validarEmail();"/>
                                <div id="info-correo"></div>
                            </div>

                            <div class="col-md-12 col-12 mb-3">
                                <div class="row">
                                    <div class="col-md-6 col-12 mb-md-0 mb-sm-0 mb-3">
                                        <label for="pass" class="form-label">Password<span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="pass" name="pass" placeholder="Password" required>
                                    </div>

                                    <div class="col-md-6 col-12">
                                        <label for="pass2" class="form-label">Repeat password<span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" id="pass2" name="pass2" placeholder="Password" required>
                                    </div>

                                    <div id="info-pass" class="col-md-12 col-12"></div>
                                </div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="nombre" class="form-label">Full name<span class="text-danger">*</span></label>
                                <input type="text" name="nombre" id="nombre" class="form-control" placeholder="Full name" required
                                       <% if (nombre != null && nombre != "") { %>value="<%=nombre%>"<%}%> />
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="direccion" class="form-label">Address</label>
                                <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Address"
                                       <% if (direccion != null && direccion != "") { %>value="<%=direccion%>"<%}%> />
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="cp" class="form-label">Postal code<span class="text-danger">*</span></label>
                                <input type="number" name="cp" id="cp" class="form-control" placeholder="Postal code" required
                                       <% if (cp != null && cp != "") { %>value="<%=cp%>"<%}%> />
                                <div id="info-cp"></div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="facebook" class="form-label">Facebook</label>
                                <input type="url" name="facebook" id="facebook" class="form-control" placeholder="Profile URL"
                                       <% if (facebook != null && facebook != "") { %>value="<%=facebook%>"<%}%> />
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="twitter" class="form-label">Twitter</label>
                                <input type="url" name="twitter" id="twitter" class="form-control" placeholder="Profile URL"
                                       <% if (twitter != null && twitter != "") { %>value="<%=twitter%>"<%}%> />
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="telefono" class="form-label">Phone number<span class="text-danger">*</span></label>
                                <input type="tel" name="telefono" id="telefono" class="form-control" placeholder="Phone number" required
                                       <% if (tlf != null && tlf != "") { %>value="<%=tlf%>"<%}%> onchange="validarTlf();"/>
                                <div id="info-tlf"></div>
                            </div>

                            <div class="col-md-12 col-12 mb-3 row">
                                <div class="mb-2 col-sm-10">
                                    <input class="btn btn-primary" type="submit" value="Sign up">
                                </div>
                                <div class="col-sm-10 fs-6">
                                    Already have an account?
                                    <a class="text-decoration-none" href="iniciar-sesion"> Log in</a>.
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/registrar.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

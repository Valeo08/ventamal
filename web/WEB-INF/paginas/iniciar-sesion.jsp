<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

Boolean error = (Boolean)request.getAttribute("error");
String email = (String)request.getAttribute("email");

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Log in</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div id="wrapper-login" class="col-xl-4 offset-xl-4 col-md-6 offset-md-3 col-10 offset-1 border border-2 rounded-2 p-3">
                    <h3 class="fs-4">Log in</h3>
                    <% if (error != null && error) { %>
                    <div id="iniciar-error" class="mt-2 alert alert-danger" role="alert">
                        Incorrect email or password.
                    </div>
                    <% } %>
                    <form method="POST" action="login">
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email"
                                   <% if (email != null && email != "") { %>value="<%=email%>"<%}%> required>
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
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>

        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

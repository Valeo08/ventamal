<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% String root = getServletContext().getContextPath(); %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="<%=root%>/img/favicon.ico">
        
        <title>Ventamal</title>
        
        <link href="<%=root%>/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="<%=root%>/css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!-- jsp:include page="/WEB-INF/plantillas/navbar.jsp"/ -->
        
        <div class="container" id="error-wrapper">
            <div class="row">
                <div class="col-md-6 offset-md-3 text-center my-auto">
                    <h2 class="fs-1 fw-bold fst-italic">
                        404 Error
                    </h2>
                    
                    <h3 class="fs-3 fw-bold"> 
                        Page not found.
                    </h3>
                    
                    <a href="<%=root%>/inicio" class="mx-auto mt-5 btn btn-lg btn-primary fw-bold">
                        Back to home
                    </a>
                </div>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="<%=root%>/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

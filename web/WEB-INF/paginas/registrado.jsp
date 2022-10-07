<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Registered</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div id="wrapper-registro" class="col-xl-4 offset-xl-4 col-md-6 offset-md-3 col-10 offset-1 border border-2 rounded-2 p-3 mb-5">
                    <div class="text-center my-3">
                        <h4 class="fs-5">You have successfully registered in Ventamal.</h4>
                        
                        <a href="inicio" class="mx-auto mt-5 btn btn-primary fw-bold">
                        Back to home
                        </a>
                    </div>
                </div>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>

        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

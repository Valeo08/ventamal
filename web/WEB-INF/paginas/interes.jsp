<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Products of interest</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div class="col-sm-12 col-md-10 offset-md-1 col-xl-6 offset-xl-3">
                    <h3 class="fs-3 fw-bold mb-4">My products of interest</h3>
                    
                    <div id="no-articulos"></div>
                    
                    <div class="row row-cols-xl-3 row-cols-md-2 row-cols-1 mb-3" id="lista-articulos">
                        
                    </div>
                </div>
                
                <%-- Barra lateral --%>
                <div class="col-sm-12 col-md-6 offset-md-3 col-xl-3 offset-xl-0 px-5 pt-5">
                    <jsp:include page="/WEB-INF/plantillas/lateral.jsp"/>
                </div>
                <%-- Barra lateral --%>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/clase-interes.js" type="text/javascript"></script>
        <script src="js/interes.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Ventamal</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div class="col-sm-12 col-md-8 offset-md-2 col-xl-6 offset-xl-3 pt-3 pb-5">
                    <h1 class="fs-1 text-center fw-bold">Ventamal</h1>
                    <h3 class="fs-3 text-center">
                        The best portal for buying and selling second-hand products.
                    </h3>

                    <div class="text-center mt-5">
                        <a href="articulos">
                            <button class="btn btn-primary btn-lg" type="button">See all products</button>
                        </a>
                    </div>
                </div>
                
                <%-- Espaciado --%>
                <div class="col-sm-12 col-md-2 col-xl-3"></div>
                
                <%-- Últimos artículos --%>
                <div class="col-sm-10 offset-sm-1 col-md-8 offset-md-2 col-xl-6 offset-xl-3">
                    <h3 class="fs-4 mb-3">Latest products</h3>
                    <div class="row row-cols-xl-3 row-cols-md-2 row-cols-1 mb-3" id="lista-articulos">
                        <jsp:include page="/WEB-INF/jspf/articulos-filtrados.jsp"/>
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
        
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>

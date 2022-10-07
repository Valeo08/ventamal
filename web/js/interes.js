/* Para manejar los artículos de interés */
var articulosInteres;

/* Cargar los artículos de interés */
window.onload = function() {
    articulosInteres = new Interes();
    init_ajax();
    
    let url = "articulos-interes";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = verArticulos;
    
    let articulos = JSON.stringify(articulosInteres.obtener());
    let datos = "articulos=" + encodeURIComponent(articulos);
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
};

/* Inicializar AJAX */
var xhr;
function init_ajax(){
    if (window.XMLHttpRequest)
        xhr = new XMLHttpRequest();
    else if (window.ActiveXObject)
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
}

/* Cargar artículos en la lista */
function verArticulos() {
    if (xhr.readyState === 4)
        if (xhr.status === 200) {
            let respuesta = xhr.responseText;
            let mostrar;
            if (respuesta.trim() === "") {
                mostrar = "<p class=\"fs-5 p-4\">"
                    + "You have not added any products to your interests.</p>";
                document.getElementById("no-articulos").innerHTML = mostrar;
            } else {
                document.getElementById("lista-articulos").innerHTML = respuesta;
            }
        }
}


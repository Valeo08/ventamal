/* Funciones para manejar los artículos de interés */
var articulosInteres;

function actualizarBotonInteres() {
    let idArticulo = document.getElementById("id-articulo");
    if (idArticulo !== null) {
        let btn = document.getElementById("boton-interes");
        let btnP1 = "<button class=\"btn btn-primary w-100\" ";
        let btnP2 = ">";
        let btnP3 = "</button>";
        let btnV = "";
        let btnOn1 = "onclick=\"agregarInteres();\""; 
        let btnOn2 = "onclick=\"quitarInteres();\"";

        if (articulosInteres.existe(Number(idArticulo.value))) {
            btnV = "Remove product from interest list";
            btn.innerHTML = btnP1 + btnOn2 + btnP2 + btnV + btnP3;
        } else {
            btnV = "Add product to interest list";
            btn.innerHTML = btnP1 + btnOn1 + btnP2 + btnV + btnP3;
        }
    }
}

function agregarInteres() {
    let idArticulo = document.getElementById("id-articulo");
    if (idArticulo !== null)
        articulosInteres.agregar(Number(idArticulo.value));
    
    actualizarBotonInteres();
}

function quitarInteres() {
    let idArticulo = document.getElementById("id-articulo");
    if (idArticulo !== null)
        articulosInteres.quitar(Number(idArticulo.value));
    
    actualizarBotonInteres();
}

/* Poblar el input de las opciones de visibilidad de comentario */
window.onload = function() {
    let vs = document.getElementById("visibilidad");
    if (vs !== null) {
        let opcionesSel = ["Public", "Only for the seller", "Private"];
        let opciones = ["publico", "vendedor", "privado"];
        let i;
        for (i = 0; i < opcionesSel.length; i++) {
            let opt = document.createElement("option");
            opt.value = opciones[i];
            opt.innerHTML = opcionesSel[i];
            vs.append(opt);
        }
    }
    
    let idArticulo = document.getElementById("id-articulo");
    if (idArticulo !== null) {
        articulosInteres = new Interes();
        actualizarBotonInteres();
    }
};

/* Validar el formulario antes de publicar comentario */
function validar() {
    let valido = true;
    
    let opciones = ["publico", "vendedor", "privado"];
    let vs = document.getElementById("visibilidad").value;
    let optVal = false, i = 0;
    while (!optVal && i < opciones.length) {
        if (vs === opciones[i])
            optVal = true;
        i++;
    }
    if (!optVal) valido = false;
    
    let texto = document.getElementById("texto").value;
    if (texto.equals === "" || texto.trim().length === 0)
        valido = false;
    
    if (!valido) alert("Invalid comment.");
    
    return valido;
}

/* Inicializar AJAX */
var xhr;
function init_ajax(){
    if (window.XMLHttpRequest)
        xhr = new XMLHttpRequest();
    else if (window.ActiveXObject)
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
}

/* Publicar el comentario */
function comentar() {
    init_ajax();
    
    let url = "comentar";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = verComentarios;

    let idArticulo = document.getElementById("id-articulo");
    let visibilidad = document.getElementById("visibilidad");
    let texto = document.getElementById("texto");
    let datos = "idarticulo=" + encodeURIComponent(idArticulo.value)
            + "&visibilidad=" + encodeURIComponent(visibilidad.value)
            + "&texto=" + encodeURIComponent(texto.value);
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
    
    document.getElementById("texto").value = "";
    return false;
}

/* Listar los comentarios */
function verComentarios() {
    if (xhr.readyState === 4)
        if (xhr.status === 200)
            document.getElementById("lista-comentarios").innerHTML = xhr.responseText;
}

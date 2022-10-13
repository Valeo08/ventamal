var categorias = ["Cars", "Bikes", "Fashion and Accessories",
    "TV, Audio and Photo", "Mobile phones", "Computers and Electronics", 
    "Sport and Entertainment", "Consoles and Video Games", "Home and Garden",
    "Household appliances", "Film, Books and Music", "Collecting",
    "Services", "Other"];

var estados = ["New", "Pre-owned", "Deteriorated", "Poor condition"];

/* Poblar el input de las categorías y estados disponibles */
window.onload = function() {
    let i;
    
    let cs = document.getElementById("categoria");
    for (i = 0; i < categorias.length; i++) {
        let opt = document.createElement("option");
        opt.value = categorias[i];
        opt.innerHTML = categorias[i];
        cs.append(opt);
    }
    let tempCategoria = document.getElementById("temp-categoria");
    cs.value = tempCategoria.value;
    tempCategoria.remove();
    
    let es = document.getElementById("estado");
    for (i = 0; i < estados.length; i++) {
        let opt = document.createElement("option");
        opt.value = estados[i];
        opt.innerHTML = estados[i];
        es.append(opt);
    }
    let tempEstado = document.getElementById("temp-estado");
    es.value = tempEstado.value;
    tempEstado.remove();
};

/* Prevenir fallos en el formulario */
document.getElementById("ano-adquisicion").addEventListener("input", function() {
    comprobarNumero(this);
    if (this.value.length > 4) this.value = this.value.substr(0,4);
    if (this.value === "0") this.value = "";
}, false);

document.getElementById("precio").addEventListener("input", function() {
    let v = this.value;
    let f = /^(?=.+)(?:[1-9]\d*|0)?(?:\.\d+)?$/;
    if (isNaN(v) || !f.test(v)) this.value = "";
}, false);

function comprobarNumero(input) {
    let i = parseInt(input.value);
    input.value = (isNaN(i) || i < 0) ? "" : i;
}

/* Validar el formulario antes de publicar */
function validar() {
    let valido = true;
    
    let alertIni = "<div class=\"mt-2 alert alert-danger\" role=\"alert\">";
    let alertFin = "</div>";   
    
    let nombre = document.getElementById("nombre-art").value;
    let categoria = document.getElementById("categoria").value;
    let estado = document.getElementById("estado").value;
    let anoAdquisicion = document.getElementById("ano-adquisicion").value;
    let precio = document.getElementById("precio").value;
    let imagen = document.getElementById("imagen").value;
    
    // Validar categoria
    let i = 0, catVal = false;
    while (!catVal && i < categorias.length) {
        if (categoria === categorias[i])
            catVal = true;
        i++;
    }
    if (!catVal) valido = false;
    
    // Validar estado
    if (estado !== "") {
        i = 0, estVal = false;
        while (!estVal && i < estados.length) {
            if (estado === estados[i])
                estVal = true;
            i++;
        }
        if (!estVal) valido = false;
    }
    
    // Validar año de adquisición
    if (anoAdquisicion !== "") {
        if (anoAdquisicion.length !== 4 || (!isNaN(anoAdquisicion) 
                && Number(anoAdquisicion) < 0)) {
            let mensajeAad = "Invalid year of acquisition";
            document.getElementById("info-ano-adquisicion").style.display="block";
            document.getElementById("info-ano-adquisicion").innerHTML = alertIni + mensajeAad + alertFin;
            valido = false;
        } else {
            document.getElementById("info-ano-adquisicion").innerHTML = "";
            document.getElementById("info-ano-adquisicion").style.display="none";
        }
    }
    
    // Validar precio
    let f = /^(?=.+)(?:[1-9]\d*|0)?(?:\.\d+)?$/;
    if (isNaN(precio) || !f.test(precio)) {
        let mensajePrecio = "Invalid price";
        document.getElementById("info-precio").style.display="block";
        document.getElementById("info-precio").innerHTML = alertIni + mensajePrecio + alertFin;
        valido = false;
    } else {
        document.getElementById("info-precio").innerHTML = "";
        document.getElementById("info-precio").style.display="none";
    }
    
    // Validar imagen
    if (imagen !== "") {
        let idxDot = imagen.lastIndexOf(".") + 1;
        var extFile = imagen.substr(idxDot, imagen.length).toLowerCase();
        if (extFile==="png" || extFile==="gif"
                || extFile==="jpeg" || extFile==="jpg"){
            document.getElementById("info-imagen").innerHTML = "";
            document.getElementById("info-imagen").style.display="none";
        } else {
            let mensajeImagen = "Invalid file or format. Only images in PNG, "
                + "GIF, JPEG or JPG format are allowed.";
            document.getElementById("info-imagen").style.display="block";
            document.getElementById("info-imagen").innerHTML = alertIni + mensajeImagen + alertFin;
            valido = false;
        }
    }
    
    // Comprobar si todos los elementos obligatorios se han rellenado
    if (nombre === "" || categoria === "" || precio === "")
        valido = false;
    
    return valido;
}

/* Confirmar eliminación */
document.getElementById("texto-confirmar").addEventListener("input", function() {
    let activo = (this.value === "DELETE");
    let boton = document.getElementById("boton-confirmar");
    
    if (activo) {
        boton.classList.remove("disabled");
        boton.setAttribute("tabindex", "1");
    } else {
        boton.classList.add("disabled");
        boton.setAttribute("aria-disabled", "-1");
    }
    
    boton.setAttribute("aria-disabled", "" + !activo);
}, false);

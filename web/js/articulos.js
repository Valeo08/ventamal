var categorias = ["Cars", "Bikes", "Fashion and Accessories",
    "TV, Audio and Photo", "Mobile phones", "Computers and Electronics", 
    "Sport and Entertainment", "Consoles and Video Games", "Home and Garden",
    "Household appliances", "Film, Books and Music", "Collecting",
    "Services", "Other"];

/* Poblar el filtro por categorías de las categorías disponibles */
window.onload = function() {
    let fs = document.getElementById("filtro-categoria");
    
    let i;
    for (i = 0; i < categorias.length; i++) {
        let opt = document.createElement("option");
        opt.value = categorias[i];
        opt.innerHTML = categorias[i];
        fs.append(opt);
    }
};

/* Prevenir fallos en el filtro de búsqueda */
document.getElementById("filtro-cp").addEventListener("input", function() {
    let i = document.getElementById("filtro-cp");
    if (i.value.length > 5) i.value = i.value.substr(0,5);
}, false);

document.getElementById("filtro-precio-desde").addEventListener("input", function() {
    let i = document.getElementById("filtro-precio-desde");
    comprobarNumero(i);
}, false);

document.getElementById("filtro-precio-hasta").addEventListener("input", function() {
    let i = document.getElementById("filtro-precio-hasta");
    comprobarNumero(i);
}, false);

function comprobarNumero(input) {
    let i = parseInt(input.value);
    input.value = (isNaN(i) || i < 0) ? "" : i;
}

/* Validar el filtro antes de realizar la consulta */
function validarFiltro() {
    let valido = true;
    
    // Campos
    let categoria = document.getElementById("filtro-categoria");
    let cp = document.getElementById("filtro-cp");
    let precioDesde = document.getElementById("filtro-precio-desde");
    let precioHasta = document.getElementById("filtro-precio-hasta");
    
    // Validar la categoría
    let i = 0, catVal = false;
    while (!catVal && i < categorias.length) {
        if (categoria.value === categorias[i])
            catVal = true;
        i++;
    }
    if (categoria.value !== "" && !catVal) {
        alert("Invalid category.");
        valido = false;
    }
    
    // Validar el código postal
    let regexCp = /((^[5]{1})[0-2][0-9]{3})|((^[0]{1})[1-9]{1}[0-9]{3})|((^[1-4]{1})[0-9]{1}[0-9]{3})$/;
    if (!isNaN(parseInt(cp.value)) && cp.value.length > 5) {
        alert("Invalid postal code.");
        valido = false;
    }
    if (cp.value !== "" && !regexCp.test(cp.value)) {
        alert("Spanish postal code must be between 01000 and 52999.");
        valido = false;
    }
    
    // Validar el precio
    if (precioDesde.value !== "" && precioHasta.value !== "") {
        let desde = parseInt(precioDesde.value);
        let hasta = parseInt(precioHasta.value);
        
        if (!isNaN(desde) && !isNaN(hasta) && desde >= hasta) {
            alert("The upper price limit is smaller than the lower limit.");
            valido = false;
        }
    }
    
    console.log(valido);
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

function filtrar() {
    init_ajax();
    
    let url = "filtro";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = articulosFiltrados;

    // Campos
    let nombre = document.getElementById("filtro-nombre");
    let categoria = document.getElementById("filtro-categoria");
    let cp = document.getElementById("filtro-cp");
    let precioDesde = document.getElementById("filtro-precio-desde");
    let precioHasta = document.getElementById("filtro-precio-hasta");

    let datos = "nombre=" + encodeURIComponent(nombre.value) +
            "&categoria=" + encodeURIComponent(categoria.value) +
            "&cp=" + encodeURIComponent(cp.value) +
            "&pmenor=" + encodeURIComponent(precioDesde.value) +
            "&pmayor=" + encodeURIComponent(precioHasta.value);
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
    
    document.getElementById("filtros-cerrar").click();
    return false;
}

function articulosFiltrados() {
    if (xhr.readyState === 4)
        if (xhr.status === 200)
            document.getElementById("lista-articulos").innerHTML = xhr.responseText;
}
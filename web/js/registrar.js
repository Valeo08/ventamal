/* Prevenir fallos en el formulario de registro */
document.getElementById("cp").addEventListener("input", function() {
    let i = document.getElementById("cp");
    if (i.value.length > 5) i.value = i.value.substr(0,5);
    
    if (i.value.length === 5) {
        let regexCp = /((^[5]{1})[0-2][0-9]{3})|((^[0]{1})[1-9]{1}[0-9]{3})|((^[1-4]{1})[0-9]{1}[0-9]{3})$/;
        if (!regexCp.test(i.value)) {
            let alertIni = "<div class=\"mt-2 alert alert-danger\" role=\"alert\">";
            let alertFin = "</div>";
            let mensajeCp = "Spanish postal code must be between 01000 and 52999.";
            document.getElementById("info-cp").style.display="block";
            document.getElementById("info-cp").innerHTML = alertIni + mensajeCp + alertFin;
        } else {
            document.getElementById("info-cp").innerHTML = "";
            document.getElementById("info-cp").style.display="none";
        }
    }
}, false);

/* Variable de validación de email y teléfono */
// Se actualizan cuando se intenta registrar (al validar)
var emailCorrecto, tlfCorrecto;

/* Inicializar AJAX */
var xhr;
function init_ajax(){
    if (window.XMLHttpRequest)
        xhr = new XMLHttpRequest();
    else if (window.ActiveXObject)
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
}

/* Comprobar si el email está ya registrado con AJAX */
function validarEmail() {
    init_ajax();
    
    let url = "comprobar-email";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = emailValido;

    let email = document.getElementById("email");
    let datos = "email=" + encodeURIComponent(email.value);
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
}

function emailValido() {    
    if (xhr.readyState === 4)
        if (xhr.status === 200) {
            document.getElementById("info-correo").innerHTML = xhr.responseText;
            emailCorrecto = true;
            if (xhr.getResponseHeader("email-disponible") !== null)
                if (parseInt(xhr.getResponseHeader("email-disponible")) === 0) 
                    emailCorrecto = false;
        }
}

/* Comprobar si el telefono está ya registrado con AJAX */
function validarTlf() {
    init_ajax();
    
    let url = "comprobar-tlf";
    xhr.open("POST", url, true);
    xhr.onreadystatechange = tlfValido;
    
    let tlf = document.getElementById("telefono");
    let datos = "tlf=" + encodeURIComponent(tlf.value);
    
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send(datos);
}

function tlfValido() {
    if (xhr.readyState === 4)
        if (xhr.status === 200) {
            document.getElementById("info-tlf").innerHTML = xhr.responseText;
            tlfCorrecto = true;
            if (xhr.getResponseHeader("tlf-disponible") !== null)
                if (parseInt(xhr.getResponseHeader("tlf-disponible")) === 0) 
                    tlfCorrecto = false;
        }
}

/* Validar formulario */
function validar() {
    let valido = true;
    
    let alertIni = "<div class=\"mt-2 alert alert-danger\" role=\"alert\">";
    let alertFin = "</div>";   
    
    let email = document.getElementById("email").value;
    let pass = document.getElementById("pass").value;
    let pass2 = document.getElementById("pass2").value;
    let nombre = document.getElementById("nombre").value;
    let cp = document.getElementById("cp").value;
    let tlf = document.getElementById("telefono").value;
    
    // Validar email
    validarEmail();
    if (!emailCorrecto) valido = false;
    
    // Validar contraseñas
    let mensajePass = "";
    if (pass === "" || pass2 === "")
        mensajePass = "You must fill in the password fields.";
    if (pass !== pass2)
        mensajePass = "Passwords must match.";
    if (pass.toString().length < 8)
        mensajePass = "The password must be at least 8 characters long.";
    if (pass.toString().split(" ").length !== 1)
        mensajePass = "The password cannot include blanks.";
    if (mensajePass !== "") {
        document.getElementById("info-pass").style.display="block";
        document.getElementById("info-pass").innerHTML = alertIni + mensajePass + alertFin;
        valido = false;
    } else {
        document.getElementById("info-pass").innerHTML = "";
        document.getElementById("info-pass").style.display="none";
    }
    
    // Validar código postal
    let mensajeCp = "";
    if (cp === "") mensajeCp = "You must enter a postal code.";
    if (cp.length !== 5) mensajeCp = "Spanish postal code must be 5 digits long.";
    let regexCp = /((^[5]{1})[0-2][0-9]{3})|((^[0]{1})[1-9]{1}[0-9]{3})|((^[1-4]{1})[0-9]{1}[0-9]{3})$/;
    if (!regexCp.test(cp))
        mensajeCp = "Spanish postal code must be between 01000 and 52999.";
    if (mensajeCp !== "") {
        document.getElementById("info-cp").style.display="block";
        document.getElementById("info-cp").innerHTML = alertIni + mensajeCp + alertFin;
        valido = false;
    } else {
        document.getElementById("info-cp").innerHTML = "";
        document.getElementById("info-cp").style.display="none";
    }
    
    // Validar teléfono
    validarTlf();
    if (!tlfCorrecto) valido = false;
    
    // Comprobar si todos los elementos obligatorios se han rellenado
    if (email === "" || pass === "" || pass2 === "" || nombre === ""
            || cp === "" || tlf === "")
        valido = false;
    
    return valido;
}
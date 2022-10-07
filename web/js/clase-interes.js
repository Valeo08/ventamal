class Interes {
    constructor(clave) {
        this.clave = clave || "articulos";
        this.articulos = this.obtener();
    }

    agregar(articulo) {
        if (!this.existe(articulo.id)) {
            this.articulos.push(articulo);
            console.log(this.articulos);
            this.guardar();
        }
    }

    quitar(id) {
        let indice = this.articulos.findIndex(articulo => articulo == id);
        if (indice != -1) {
            this.articulos.splice(indice, 1);
            this.guardar();
        }
    }

    guardar() {
        sessionStorage.setItem(this.clave, JSON.stringify(this.articulos));
    }

    obtener() {
        const articulosCodificados = sessionStorage.getItem(this.clave);
        return JSON.parse(articulosCodificados) || [];
    }

    existe(id) {
        return this.articulos.find(articulo => articulo == id);
    }

    obtenerConteo() {
        return this.articulos.length;
    }
}



var database = require("../config/database.config");
var temporal = {};


temporal.createModel = function(callback) {
	if(database) {
        
        var query = 
        "CREATE TABLE TEMP("+
        "nombre_compania VARCHAR(50) null,"+
        "contacto_compania VARCHAR(50) null,"+
        "correo_compania VARCHAR(50) null,"+
        "telefono_compania VARCHAR(50) null,"+
        "tipo char(1) not null,"+
        "nombre VARCHAR(50) not null,"+
        "correo VARCHAR(50) not null,"+
        "telefono VARCHAR(50) not null,"+
        "fecha_registro date not null,"+
        "direccion VARCHAR(50) not null,"+
        "ciudad VARCHAR(50) not null,"+
        "codigo_postal int,"+
        "region VARCHAR(50),"+
        "producto VARCHAR(50),"+
        "cantidad int not null,"+
        "precio_unitario decimal(3) not null);";

        database.query(query, function(error, resultado){
			if(error) throw error;
			callback(resultado);
		});
	}
}

module.exports = temporal;

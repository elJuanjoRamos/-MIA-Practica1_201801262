var database = require("../config/database.config");
var temporal = {};


temporal.createModel = function(callback) {
	if(database) {
        
                var query = 
                "CREATE TABLE TEMP("+
                "nombre_compania VARCHAR(150) null,"+
                "contacto_compania VARCHAR(150) null,"+
                "correo_compania VARCHAR(150) null,"+
                "telefono_compania VARCHAR(150) null,"+
                "tipo char(1) not null,"+
                "nombre VARCHAR(150) not null,"+
                "correo VARCHAR(150) not null,"+
                "telefono VARCHAR(150) not null,"+
                "fecha_registro date not null,"+
                "direccion VARCHAR(150) not null,"+
                "ciudad VARCHAR(150) not null,"+
                "codigo_postal int,"+
                "region VARCHAR(150),"+
                "producto VARCHAR(150),"+
                "cantidad int not null,"+
                "precio_unitario decimal(3) not null);";

                database.query(query, function(error, resultado){
                                if(error) throw error;
                                callback(resultado);
                        });
	}
}



temporal.insertData = function(callback) {
	if(database) {
        
        var query = 
                "SET GLOBAL local_infile = 1; "+
                "LOAD DATA INFILE '/var/lib/mysql-files/DataCenterData.csv' "+
                "into table TEMP "+
                "character set latin1 "+
                "fields terminated by ';' "+
                "lines terminated by ' \r \n ' "+
                "ignore 1 lines "+
                " (nombre_compania, contacto_compania, correo_compania, telefono_compania, tipo, nombre, correo, telefono, @var1, direccion, ciudad, codigo_postal, region, producto, categoria_producto, cantidad, precio_unitario)"
                " set fecha_registro = str_to_date(@var1, '%d/%m/%Y');"
        ;
        database.query(query, function(error, resultado){
			if(error) throw error;
			callback(resultado);
		});
	}
}

temporal.deleteData = function(callback) {
	if(database) {
        
        var query ="DROP TABLE TEMP;";
        database.query(query, function(error, resultado){
			if(error) throw error;
			callback(resultado);
		});
	}
}


temporal.getDatatemp = function(callback) {
	if(database) {
        
        var query ="SELECT * FROM TEMP;";
        database.query(query, function(error, resultado){
			if(error) throw error;
			callback(resultado);
		});
	}
}




module.exports = temporal;

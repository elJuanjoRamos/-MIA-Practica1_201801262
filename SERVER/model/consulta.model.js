var database = require("../config/database.config");
var consulta = {};


consulta.consulta2 = function (callback) {
        if (database) {

                var query =
                        "select P.id_person, P.name_person, SUM(quantity) as cant_productos, SUM(total) as total_dinero from VENTA " +
                        "JOIN PERSON AS P ON P.id_person = VENTA.id_person  " +
                        "group by P.id_person order by cant_productos desc limit 1;";

                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
}



consulta.consulta1 = function (callback) {
    if (database) {

            var query =
                    "SELECT  P.name_person, P.phone_person, DT.id_compra, sum(total) as total_pagado FROM DETAILCOMPRA AS DT " +
                    "JOIN COMPRA ON COMPRA.id_compra = DT.id_compra " +
                    "JOIN PERSON AS P ON P.id_person =  COMPRA.id_person " + 
                    "group by id_compra ORDER BY total_pagado desc limit 1;  ";

            database.query(query, function (error, result) {
                    if (error) throw error;
                    callback(result);
            });
    }
}


consulta.consulta3 = function (callback) {
    if (database) {

            var query = "CALL CALL_CONSULTA3;";

            database.query(query, function (error, result) {
                    if (error) throw error;
                    callback(result);
            });
    }
}


consulta.consulta4 = function (callback) {
    if (database) {

            var query = "CALL CALL_CONSULTA4;";

            database.query(query, function (error, result) {
                    if (error) throw error;
                    callback(result);
            });
    }
}


consulta.consulta5 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA5;";

                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }


consulta.consulta6 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA6;";
    
                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }
    
    consulta.consulta7 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA7;";
    
                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }
    
    
    consulta.consulta8 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA8;";
    
                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }
    
    
    consulta.consulta9 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA9;";
    
                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }
    

    consulta.consulta10 = function (callback) {
        if (database) {
    
                var query = "CALL CALL_CONSULTA10;";
    
                database.query(query, function (error, result) {
                        if (error) throw error;
                        callback(result);
                });
        }
    }
    

module.exports = consulta;

var mysql = require('mysql');
var params =  {
    host: 'localhost',
    //user: 'root',
    //password: 'password',
    user: 'practica1a',
    password: 'P@ssword1',
    database: 'PRACTICA1',
    port: '3306'
}
var connection = mysql.createConnection(params);

if (connection) {
    console.log("Conexion con base de datos exitosa :p");
}

module.exports = connection;
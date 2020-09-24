var mysql = require('mysql');
var params =  {
    host: 'localhost',
    user: 'root',
    password: 'password',
    database: 'PRACTICA1',
    port: '3306'
}
var connection = mysql.createConnection(params);

module.exports = connection;
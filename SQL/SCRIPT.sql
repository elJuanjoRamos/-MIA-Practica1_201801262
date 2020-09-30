CREATE DATABASE PRACTICA1;
USE PRACTICA1;


CREATE TABLE TEMP(
	nombre_compania VARCHAR(100) null,
    contacto_compania VARCHAR(100) null,
    correo_compania VARCHAR(100) null,
    telefono_compania VARCHAR(100) null,
    tipo char(1) not null,
    nombre VARCHAR(200) not null,
    correo VARCHAR(200) not null,
    telefono VARCHAR(100) not null,
    fecha_registro date not null,
    direccion VARCHAR(100) not null,
    ciudad VARCHAR(100) not null,
    codigo_postal int,
    region VARCHAR(100),
    producto VARCHAR(100),
    categoria_producto VARCHAR(100),
    cantidad int not null,
    precio_unitario decimal(3) not null);

DROP TABLE TEMP;

SELECT * FROM TEMP;

SHOW GLOBAL VARIABLES LIKE 'local_infile'; 
SHOW VARIABLES LIKE "secure_file_priv";

/*home/eljuanjoramos/Documentos/ARCHIVOS/-MIA-Practica1_201801262/SERVER/DataCenterData.csv*/


SET GLOBAL local_infile = 1; 
LOAD DATA INFILE '/var/lib/mysql-files/DataCenterData.csv'
into table TEMP
character set latin1
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines
(nombre_compania, contacto_compania, correo_compania, telefono_compania, tipo, nombre, correo, telefono, @var1, direccion, ciudad, codigo_postal, region, producto, categoria_producto, cantidad, precio_unitario)
set fecha_registro = str_to_date(@var1, '%d/%m/%Y');


CREATE USER 'practica1a'@'localhost' identified BY 'P@ssword1';
GRANT ALL PRIVILEGES ON * . * TO 'practica1a'@'localhost';
FLUSH PRIVILEGES








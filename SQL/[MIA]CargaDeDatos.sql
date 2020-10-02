USE PRACTICA1;

SET GLOBAL local_infile = 1; 
LOAD DATA INFILE '/var/lib/mysql-files/DataCenterData.csv'
into table TEMP
character set latin1
fields terminated by ';'
lines terminated by '\r\n'
ignore 1 lines
(nombre_compania, contacto_compania, correo_compania, telefono_compania, tipo, nombre, correo, telefono, @var1, direccion, ciudad, codigo_postal, region, producto, categoria_producto, cantidad, precio_unitario)
set fecha_registro = str_to_date(@var1, '%d/%m/%Y');


CALL INSERT_COMPANY();

CALL INSERT_PRODUCT_CATEGORY();
 
CALL INSERT_CLIENT_TYPE();

CALL INSERT_PERSON();

CALL INSERT_PRODUCT(0);


CALL INSERT_COMPRAS();

CALL INSERT_DETALLE();

CALL INSERT_VENTAS();









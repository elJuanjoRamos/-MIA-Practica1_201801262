DROP DATABASE IF EXISTS PRACTICA1;
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




/*MODELO ER*/

CREATE TABLE COMPANY(
	id_company INT auto_increment NOT NULL primary KEY,
	name_company VARCHAR(100) NULL,
    contact_company VARCHAR(100) null,
    mail_company VARCHAR(100) null,
    phone_company VARCHAR(100) null
);

CREATE TABLE CLIENT_TYPE(
	id_type INT auto_increment NOT NULL primary KEY,
    name_type char(1) not null
);

CREATE TABLE PERSON(
	id_person INT auto_increment NOT NULL primary KEY,
    id_type INT NOT NULL,
    name_person VARCHAR(200) not null,
    mail_person VARCHAR(200) not null,
    phone_person VARCHAR(100) not null,
    date_registro VARCHAR(100) not null,
    direction VARCHAR(100) not null,
    city VARCHAR(100) not null,
    postal_code int,
    region VARCHAR(100),
    FOREIGN KEY(id_type) REFERENCES CLIENT_TYPE(id_type)
);

CREATE TABLE PRODUCT_CATEGORY(
	id_category INT auto_increment NOT NULL primary KEY,
    name_category varchar(100) NOT NULL    
);

CREATE TABLE PRODUCT(
	id_product int auto_increment NOT NULL PRIMARY KEY,
    name_product VARCHAR(100) NOT NULL,
    precio_unitario decimal(3) not null,
    id_category INT NOT NULL, 
    FOREIGN KEY(id_category) REFERENCES PRODUCT_CATEGORY(id_category)
);



CREATE TABLE COMPRA(
	id_compra INT auto_increment NOT NULL primary KEY,
    id_person INT NOT NULL,
    id_company INT NOT NULL,
    FOREIGN KEY(id_person) REFERENCES PERSON(id_person),
    FOREIGN KEY(id_company) REFERENCES COMPANY(id_company)
);

CREATE TABLE DETAILCOMPRA(
	id_deteail INT auto_increment NOT NULL primary KEY,
    id_compra INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    total 	INT not null,
    FOREIGN KEY(id_product) REFERENCES PRODUCT(id_product),    
    FOREIGN KEY(id_compra) REFERENCES COMPRA(id_compra)        
);


CREATE TABLE VENTA(
	id_compra INT auto_increment NOT NULL primary KEY,
    id_person INT NOT NULL,
    id_company INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    total 	INT not null,
    FOREIGN KEY(id_person) REFERENCES PERSON(id_person),
    FOREIGN KEY(id_company) REFERENCES COMPANY(id_company),    
    FOREIGN KEY(id_product) REFERENCES PRODUCT(id_product)    
);










/*PROCEDURES*/

delimiter //
CREATE PROCEDURE INSERT_COMPANY()
BEGIN
	INSERT INTO COMPANY(name_company, contact_company, mail_company, phone_company)
	SELECT distinct 
		nombre_compania,  contacto_compania, correo_compania, telefono_compania 
	FROM TEMP;
END; //



delimiter //
CREATE PROCEDURE INSERT_PRODUCT_CATEGORY()
BEGIN
	INSERT INTO PRODUCT_CATEGORY(name_category)
	SELECT DISTINCT 
		categoria_producto 
	FROM TEMP;
END; //


delimiter //
CREATE PROCEDURE INSERT_CLIENT_TYPE()
BEGIN
	INSERT INTO CLIENT_TYPE(name_type)
	SELECT DISTINCT 
		tipo 
	FROM TEMP;
END; //


delimiter //
CREATE PROCEDURE INSERT_PERSON()
BEGIN
	INSERT INTO PERSON(id_type, name_person, mail_person, phone_person, date_registro, direction, city, postal_code, region)
	SELECT distinct  
		(SELECT id_type FROM CLIENT_TYPE WHERE name_type = T.tipo), T.nombre, T.correo, T.telefono, T.fecha_registro, T.direccion, T.ciudad, T.codigo_postal, T.region 
	from TEMP AS T;
END; //





delimiter //
CREATE PROCEDURE INSERT_PRODUCT(p1 INT)
BEGIN

	INSERT INTO PRODUCT(name_product, precio_unitario, id_category)
	SELECT distinct 
		producto, precio_unitario, (SELECT id_category from PRODUCT_CATEGORY WHERE name_category = categoria_producto) as categor FROM TEMP;

  /*label1: LOOP
    SET p1 = p1 + 1;
    IF p1 <= (select max(id_category) from PRODUCT_CATEGORY) THEN
    
      INSERT INTO PRODUCT(name_product, precio_unitario, id_category)
      SELECT distinct 
		producto, precio_unitario, (select id_category from PRODUCT_CATEGORY where id_category = p1) as categor FROM TEMP 
      where 
		categoria_producto = (SELECT name_category FROM PRODUCT_CATEGORY where id_category = p1) group by producto, precio_unitario;

      ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
  SET @x = p1;*/
END; //













delimiter //
CREATE PROCEDURE INSERT_COMPRAS()

BEGIN

INSERT INTO COMPRA(id_person, id_company)        

SELECT distinct

(SELECT id_person FROM PERSON where name_person = T.nombre  
	AND mail_person = T.correo AND phone_person = T.telefono AND direction = T.direccion 
    AND city = T.ciudad AND postal_code = T.codigo_postal  AND region = T.region AND id_type = 1) AS idProveedor, 
        
    (SELECT id_company FROM COMPANY WHERE name_company = T.nombre_compania 
    AND contact_company = T.contacto_compania AND mail_company = T.correo_compania AND phone_company = T.telefono_compania   ) as company 



FROM TEMP AS T where tipo = 'P';

END; //


delimiter //
CREATE PROCEDURE INSERT_DETALLE()

BEGIN

INSERT INTO DETAILCOMPRA(id_compra, id_product, quantity, total)        
SELECT distinct 	
	/*id DETALLE */
	(SELECT id_compra FROM COMPRA WHERE id_person = (SELECT id_person FROM PERSON 
		where name_person = T.nombre  AND mail_person = T.correo AND phone_person = T.telefono AND 
		direction = T.direccion AND city = T.ciudad AND postal_code = T.codigo_postal  AND region = T.region) AND
		/*id compay*/
		id_company = (SELECT id_company FROM COMPANY WHERE name_company = T.nombre_compania)) as compra, 

	/*id producto*/
	(SELECT id_product FROM PRODUCT
		where name_product = T.producto  AND precio_unitario = T.precio_unitario) AS idProducto,
	/*Cantidad de producto*/
	(T.cantidad),
	/*Total*/
	(T.cantidad * T.precio_unitario) as total
 
FROM TEMP AS T 
WHERE tipo = 'P';



END; //








delimiter //
CREATE PROCEDURE INSERT_VENTAS()

BEGIN

INSERT INTO VENTA(id_person, id_company, id_product, quantity, total)        
SELECT distinct 	
            /*id proveedor*/
			(SELECT id_person FROM PERSON 
            where name_person = T.nombre  AND mail_person = T.correo AND phone_person = T.telefono AND 
            direction = T.direccion AND city = T.ciudad AND postal_code = T.codigo_postal  AND region = T.region) AS idProveedor ,

			/*id compay*/
            (SELECT id_company FROM COMPANY WHERE name_company = T.nombre_compania) as company, 
            
			/*id producto*/
			(SELECT id_product FROM PRODUCT
            where name_product = T.producto  AND precio_unitario = T.precio_unitario) AS idProducto,
            /*Cantidad de producto*/
            (T.cantidad),
            /*Total*/
            (T.cantidad * T.precio_unitario)
             
        FROM TEMP AS T 
		WHERE tipo = 'C';	


/*  label1: LOOP
    SET p1 = p1 + 1;
    IF p1 <= (select max(id_company) from COMPANY) THEN
		
        INSERT INTO VENTA(id_person, id_company, id_product, quantity, total)        
		
        SELECT distinct 
			
            /*id proveedor
			(SELECT id_person FROM PERSON 
            where name_person = T.nombre  AND mail_person = T.correo AND phone_person = T.telefono AND 
            direction = T.direccion AND city = T.ciudad AND postal_code = T.codigo_postal  AND region = T.region) AS idProveedor ,

			/*id compay
            p1, 
            
			/*id producto
			(SELECT id_product FROM PRODUCT
            where name_product = T.producto  AND precio_unitario = T.precio_unitario) AS idProducto,
            /*Cantidad de producto
            (T.cantidad),
            /*Total
            (T.cantidad * T.precio_unitario)
             
        FROM TEMP AS T 
		WHERE 
			T.nombre_compania = (SELECT name_company FROM COMPANY WHERE id_company = p1) AND tipo = 'C'; 

      ITERATE label1;
    END IF;
    LEAVE label1;
  END LOOP label1;
  SET @x = p1;*/
END; //









/*PROCEDURE CONSULTAS*/
delimiter //
CREATE PROCEDURE CALL_CONSULTA3()
BEGIN
	
	(select  P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
	count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode FROM COMPRA
	JOIN PERSON AS P ON P.id_person =  COMPRA.id_person
	group by P.direction, P.region,P.city, P.postal_code  order by pedido_dir desc, pedido_region desc, pedido_city desc, pedido_postalcode desc limit 1)
	union
	(select  P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
	count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode FROM COMPRA
	JOIN PERSON AS P ON P.id_person =  COMPRA.id_person
	group by P.direction, P.region,P.city, P.postal_code  order by pedido_dir asc, pedido_region asc, pedido_city asc, pedido_postalcode asc LIMIT 1);

END; //


delimiter //
CREATE PROCEDURE CALL_CONSULTA4()
BEGIN
	
	SELECT P.id_person, P.name_person, count(P.id_person) as noCompras, sum(total) as total FROM VENTA
	JOIN PERSON AS P ON P.id_person = VENTA.id_person
	JOIN PRODUCT AS PR ON VENTA.id_product = PR.id_product
	JOIN PRODUCT_CATEGORY AS PC ON PR.id_category = PC.id_category
	WHERE PR.id_category = (select PC.id_category where PC.name_category = 'Cheese')
	GROUP by P.id_person, P.name_person order by total desc limit 5;

END; //


delimiter //
CREATE PROCEDURE CALL_CONSULTA6()
BEGIN
	
	(SELECT P.id_category, C.name_category, sum(total) as total_vendido from DETAILCOMPRA
		JOIN PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
		JOIN PRODUCT_CATEGORY as C on C.id_category = P.id_category
	group by P.id_category  order by count(P.id_category) desc limit 1)
	union
	(SELECT P.id_category, C.name_category, sum(total) as total_vendido from DETAILCOMPRA
		JOIN PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
		JOIN PRODUCT_CATEGORY as C on C.id_category = P.id_category
	group by P.id_category  order by count(P.id_category) asc limit 1);

END; //





CREATE USER 'practica1a'@'localhost' identified BY 'P@ssword1';
GRANT ALL PRIVILEGES ON * . * TO 'practica1a'@'localhost';
FLUSH PRIVILEGES


ALTER USER 'practica1a'@'localhost' IDENTIFIED WITH mysql_native_password BY 'P@ssword1';
flush privileges;



DROP TABLE TEMP;

SELECT * FROM TEMP;

SHOW GLOBAL VARIABLES LIKE 'local_infile'; 
SHOW VARIABLES LIKE "secure_file_priv";





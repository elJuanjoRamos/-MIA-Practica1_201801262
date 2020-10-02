USE PRACTICA1;


CALL INSERT_COMPANY();

CALL INSERT_PRODUCT_CATEGORY();
 
CALL INSERT_CLIENT_TYPE();

CALL INSERT_PERSON();

CALL INSERT_PRODUCT(0);


CALL INSERT_COMPRAS();

CALL INSERT_DETALLE();


CALL INSERT_VENTAS();

/*CONSULTA 1*/

SELECT  P.name_person, P.phone_person, DT.id_compra, sum(total) as total_pagado FROM DETAILCOMPRA AS DT
JOIN COMPRA ON COMPRA.id_compra = DT.id_compra
JOIN PERSON AS P ON P.id_person =  COMPRA.id_person
group by id_compra ORDER BY total_pagado desc limit 1;

/*CONSULTA 2*/
select P.id_person, P.name_person, SUM(quantity) as cant_productos, SUM(total) as total_dinero from VENTA
JOIN PERSON AS P ON P.id_person = VENTA.id_person 
group by P.id_person order by cant_productos desc limit 1;

/*CONSULTA 3*/

(select  P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode FROM COMPRA
JOIN PERSON AS P ON P.id_person =  COMPRA.id_person
group by P.direction, P.region,P.city, P.postal_code  order by pedido_dir desc, pedido_region desc, pedido_city desc, pedido_postalcode desc limit 1)
union
(select  P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode FROM COMPRA
JOIN PERSON AS P ON P.id_person =  COMPRA.id_person
group by P.direction, P.region,P.city, P.postal_code  order by pedido_dir asc, pedido_region asc, pedido_city asc, pedido_postalcode asc LIMIT 1);



/*CONSULTA 4*/

SELECT P.id_person, P.name_person, count(P.id_person) as noCompras, sum(total) as total FROM VENTA
JOIN PERSON AS P ON P.id_person = VENTA.id_person
JOIN PRODUCT AS PR ON VENTA.id_product = PR.id_product
JOIN PRODUCT_CATEGORY AS PC ON PR.id_category = PC.id_category
WHERE PR.id_category = (select PC.id_category where PC.name_category = 'Cheese')
GROUP by P.id_person, P.name_person order by total desc;


SELECT P.id_person, P.name_person, sum(total) as total FROM VENTA
JOIN PERSON AS P ON P.id_person = VENTA.id_person
JOIN PRODUCT AS PR ON VENTA.id_product = PR.id_product
JOIN PRODUCT_CATEGORY AS PC ON PR.id_category = PC.id_category
WHERE PR.id_category = (select PC.id_category where PC.name_category = 'Cheese');




/*CONSULTA 5*/

SELECT P.id_person, P.name_person, P.date_registro, sum(total) as total FROM VENTA
JOIN PERSON AS P ON P.id_person = VENTA.id_person
group by id_person order  by total desc;

/*CONSULTA 6*/


(SELECT P.id_category, C.name_category, sum(total) as total_vendido from DETAILCOMPRA
JOIN PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN PRODUCT_CATEGORY as C on C.id_category = P.id_category
group by P.id_category  order by count(P.id_category) desc limit 1)
union
(SELECT P.id_category, C.name_category, sum(total) as total_vendido from DETAILCOMPRA
JOIN PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN PRODUCT_CATEGORY as C on C.id_category = P.id_category
group by P.id_category  order by count(P.id_category) asc limit 1
);





select * from PRODUCT_CATEGORY WHERE id_category = 1;


SELECT sum(total) FROM DETAILCOMPRA 
JOIN PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN PRODUCT_CATEGORY as C on C.id_category = P.id_category
WHERE C.name_category = 'Fresh Vegetables'





SELECT id_product, count(id_product) from DETAILCOMPRA
group by id_product
;




select * from DETAILCOMPRA

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

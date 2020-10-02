USE PRACTICA1;

/*CONSULTA 1*/

SELECT  
	P.name_person, P.phone_person, DT.id_compra, sum(total) as total_pagado 
FROM 
	DETAILCOMPRA AS DT
JOIN 
	COMPRA ON COMPRA.id_compra = DT.id_compra
JOIN 
	PERSON AS P ON P.id_person =  COMPRA.id_person
GROUP BY 
	id_compra 
ORDER BY 
	total_pagado DESC limit 1;


/*CONSULTA 2*/
SELECT 
	P.id_person, P.name_person, SUM(quantity) as cant_productos, SUM(total) as total_dinero 
FROM 
	VENTA
JOIN 
	PERSON AS P ON P.id_person = VENTA.id_person 
GROUP BY 
	P.id_person 
ORDER BY 
	cant_productos DESC limit 1;


/*CONSULTA 3*/

(SELECT  
	P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
	count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode 
FROM
	COMPRA
JOIN 
	PERSON AS P ON P.id_person =  COMPRA.id_person
GROUP BY 
	P.direction, P.region,P.city, P.postal_code  
ORDER BY 
	pedido_dir DESC, pedido_region DESC, pedido_city DESC, pedido_postalcode DESC limit 1)
union
(SELECT  
	P.direction,P.region,P.city, P.postal_code,  count(P.direction)  as pedido_dir, count(P.region) as pedido_region,
	count(P.city)  as pedido_city, count(P.postal_code) as pedido_postalcode 
FROM 
	COMPRA
JOIN 
	PERSON AS P ON P.id_person =  COMPRA.id_person
GROUP BY 
	P.direction, P.region,P.city, P.postal_code 
ORDER BY 
	pedido_dir asc, pedido_region asc, pedido_city asc, pedido_postalcode asc LIMIT 1);




/*CONSULTA 4*/

SELECT 
	P.id_person, P.name_person, count(P.id_person) as noCompras, sum(total) as total 
FROM 
	VENTA
JOIN 
	PERSON AS P ON P.id_person = VENTA.id_person
JOIN 
	PRODUCT AS PR ON VENTA.id_product = PR.id_product
JOIN 
	PRODUCT_CATEGORY AS PC ON PR.id_category = PC.id_category
WHERE 
	PR.id_category = (SELECT id_category FROM PRODUCT_CATEGORY where name_category = 'Cheese')
GROUP BY 
	P.id_person, P.name_person 
ORDER BY 
	total DESC limit 5;


/*CONSULTA 5*/

SELECT 
	P.id_person, P.name_person, MONTH(P.date_registro) AS mes_registro, sum(total) as total 
FROM VENTA 
JOIN 
	PERSON AS P ON P.id_person = VENTA.id_person 
GROUP BY
	id_person 
ORDER BY 
	total DESC;



/*CONSULTA 6*/


(SELECT 
	P.id_category, C.name_category, sum(total) as total_vendido 
FROM 
	DETAILCOMPRA
JOIN 
	PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN 
	PRODUCT_CATEGORY as C on C.id_category = P.id_category
GROUP BY 
	P.id_category  
ORDER BY 
	count(P.id_category) DESC limit 1)

union
(SELECT 
	P.id_category, C.name_category, sum(total) as total_vendido 
FROM 
	DETAILCOMPRA
JOIN 
	PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN 
	PRODUCT_CATEGORY as C on C.id_category = P.id_category
GROUP BY 
	P.id_category 
ORDER BY 
	count(P.id_category) asc limit 1
);




/*CONSULTA 7*/
SELECT 
	PE.id_person , PE.name_person, PE.mail_person, PE.phone_person, PE.date_registro, concat(PE.direction, ",", PE.city) as direction, 
	sum(quantity) as total_vendido,  sum(total) as total_dinero
FROM 
	DETAILCOMPRA
JOIN 
	COMPRA AS CO ON CO.id_compra = DETAILCOMPRA.id_compra
JOIN 
	PRODUCT AS P ON P.id_product = DETAILCOMPRA.id_product
JOIN 
	PRODUCT_CATEGORY as C on C.id_category = P.id_category
JOIN 
	PERSON AS PE ON CO.id_person = PE.id_person
WHERE 
	C.name_category = 'Fresh Vegetables'
GROUP BY 
	CO.id_person 
ORDER BY 
	total_dinero DESC LIMIT 5;



/*CONSULTA 8*/
SELECT 
	P.id_person, P.direction, P.city, P.postal_code, P.region, sum(total) as total 
FROM 
	VENTA 
JOIN 
	PERSON AS P ON P.id_person = VENTA.id_person 
GROUP BY
	id_person 
ORDER BY 
	total DESC;




/*CONSULTA 9*/

SELECT 
	P.name_person, P.phone_person, DT.id_compra, sum(quantity) as cant_comprada, sum(total) as total
FROM 
	DETAILCOMPRA AS DT
JOIN 
	COMPRA ON COMPRA.id_compra = DT.id_compra
JOIN 
	PERSON AS P ON P.id_person =  COMPRA.id_person
GROUP BY 
	DT.id_compra 
ORDER BY 
	cant_comprada asc limit 1;
    
    


/*CONSULTA 10*/

SELECT 
	P.id_person, P.name_person, P.mail_person, P.phone_person, P.date_registro,
	CONCAT(P.direction, " -- " ,P.region, " -- ", P.city) AS ADRESS,  sum(quantity) as cantidad_comprada 
FROM 
	VENTA
JOIN 
	PERSON AS P ON P.id_person = VENTA.id_person
JOIN 
	PRODUCT AS PR ON VENTA.id_product = PR.id_product
JOIN 
	PRODUCT_CATEGORY AS PC ON PR.id_category = PC.id_category
WHERE 
	PR.id_category = (SELECT PC.id_category where PC.name_category = 'Seafood')
GROUP BY 
	P.id_person, P.name_person 
ORDER BY 
	cantidad_comprada DESC limit 10;

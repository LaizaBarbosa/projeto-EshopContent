-- EXERCICIO A
SELECT * FROM product;

-- EXERCICIO B
SELECT userName 
FROM users;

-- EXERCICIO C
SELECT DISTINCT s.sName AS nomeLoja, COUNT(pName) AS quantidadeProduto
FROM store AS s
JOIN product AS p
ON s.sId = p.sId
GROUP BY sName;

-- EXERCICIO D
SELECT u.userName, a.contactPhoneNum, a.province, a.city, a.streetAddr, a.postalCode
FROM address AS a
JOIN users AS u ON u.userId = a.userId 
JOIN buyer AS b ON b.userId = a.userId; 

-- EXERCICIO E
SELECT *
FROM product 
WHERE pType = 'laptop';

-- EXERCICIO F 
SELECT DISTINCT sp.streetAddr, sp.city, sp.province, sp.startTime, sp.endTime, c.userId
FROM servicepoint AS sp
JOIN after_sales_service_at AS af ON sp.spId = af.spId
JOIN product AS p ON p.brand = af.brandName
JOIN save_to_shopping_cart AS c ON p.pId = c.pId
JOIN users AS u ON c.userId = 5;

-- validação
SELECT * FROM servicepoint;
SELECT * FROM ADDRESS WHERE USERID = 5;

-- EXERCICIO G
SELECT s.sId, c.userId, c.quantity, s.sName
FROM save_to_shopping_cart AS c
JOIN product AS p ON c.pId = p.pId
JOIN store AS s ON s.sId = 8; 

-- EXERCICIO H 
-- retorna null
SELECT * 
FROM comments 
WHERE pId = 123456789;
 
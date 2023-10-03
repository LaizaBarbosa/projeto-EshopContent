DROP TABLE store;
DROP TABLE address;

CREATE DATABASE eShopConnect;

USE eShopConnect;

CREATE TABLE users(
	userId INT NOT NULL AUTO_INCREMENT,
    userName VARCHAR(40) NOT NULL,
    phoneNumber VARCHAR(12),
	PRIMARY KEY (userId)
);

CREATE TABLE buyer(
	userId INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (userId),
    foreign key (userId) references users(userId)
);

CREATE TABLE seller(
	userId INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (userId),
    foreign key (userId) references users(userId)
);

CREATE TABLE bankCard(
	cardNumber CHAR(16) PRIMARY KEY NOT NULL,
    expiryDate DATE NOT NULL,
    bank VARCHAR(20) NOT NULL
);

CREATE TABLE creditcard(
	cardNumber VARCHAR(16) PRIMARY KEY NOT NULL,
    organizationBank VARCHAR(20) NOT NULL,
	userId INT NOT NULL,
    FOREIGN KEY(CardNumber) REFERENCES bankCard(cardNumber),
    FOREIGN KEY (userId) REFERENCES users(userId)
);

CREATE TABLE debitcard(
	cardNumber VARCHAR(16) PRIMARY KEY NOT NULL,
    organizationBank VARCHAR(20) NOT NULL,
	userId INT NOT NULL,
    FOREIGN KEY(CardNumber) REFERENCES bankCard(cardNumber),
    FOREIGN KEY (userId) REFERENCES users(userId)
);

CREATE TABLE store(
	sId	VARCHAR(4) PRIMARY KEY NOT NULL,
	sName VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    streetAddr VARCHAR(30) NOT NULL,
    customerGrade INT,
    startTime TIME
);

CREATE TABLE Brand(
	brandName VARCHAR(50) NOT NULL PRIMARY KEY 
);

CREATE TABLE Product(
	pId INT PRIMARY KEY NOT NULL,
    sId VARCHAR(4) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    pName VARCHAR(120) NOT NULL,
    pType VARCHAR(50),
    modelNumber VARCHAR(50) NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    color VARCHAR(20),
    amount INT DEFAULT NULL,
	FOREIGN KEY (sId) REFERENCES store(sId),
    FOREIGN KEY (brand) REFERENCES Brand(brandName)
);


CREATE TABLE OrderItem(
	itemId INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    pId INT NOT NULL,
    price DECIMAL(6,2) NOT NULL,
    creationTime TIME NOT NULL,
    FOREIGN KEY (pId) REFERENCES Product(pId)
);

CREATE TABLE Orders(
	orderNumber INT PRIMARY KEY NOT NULL,
    paymentStatus ENUM('Paid', 'Unpaid'),
    creationTime TIME NOT NULL,
    totalAmount DECIMAL(10,2) NULL
);

CREATE TABLE address(
	addrId INT PRIMARY KEY NOT NULL,
    userId INT NOT NULL,
    userName VARCHAR(50) NOT NULL,
    contactPhoneNum VARCHAR(20) NOT NULL,
    province VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    streetAddr VARCHAR(100) NOT NULL,
    postalCode VARCHAR(12) NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(userId)
);

CREATE TABLE Comments(
	creationTime DATE NOT NULL,
    userId INT NOT NULL,
	pId INT NOT NULL,
    grade FLOAT,
    content VARCHAR(500),
    PRIMARY KEY (creationTime, userId, pId),
    FOREIGN KEY (userId) REFERENCES users(userId),
    FOREIGN KEY (pId) REFERENCES Product(pId)
);

CREATE TABLE Save_to_Shopping_Cart(
	userId INT NOT NULL,
	pId INT NOT NULL,
    addTime DATE NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (userId, pId),
    FOREIGN KEY (userId) REFERENCES buyer(userId),
    FOREIGN KEY (pId) REFERENCES Product(pId)
);

CREATE TABLE Contain(
	orderNumber INT NOT NULL,
    itemId INT NOT NULL,
    quantity INT NOT NULL,
	PRIMARY KEY (orderNumber, itemId),
    FOREIGN KEY (orderNumber) REFERENCES Orders(OrderNumber),
    FOREIGN KEY (itemId) REFERENCES OrderItem(itemId)
);

CREATE TABLE Payment(
	orderNumber INT NOT NULL,
    cardNumber VARCHAR(25) NOT NULL,
	payTime DATE NOT NULL,
    PRIMARY KEY (orderNumber, cardNumber),
    FOREIGN KEY (orderNumber) REFERENCES Orders(OrderNumber),
    FOREIGN KEY (cardNumber) REFERENCES bankCard(cardNumber)
);

CREATE TABLE deliver_to(
	addrId INT NOT NULL,
    orderNumber INT NOT NULL,
    timeDelivered DATE NOT NULL,
    PRIMARY KEY (addrId, orderNumber),
    FOREIGN KEY (orderNumber) REFERENCES Orders(OrderNumber),
    FOREIGN KEY (addrId) REFERENCES Address(addrId)
);

CREATE TABLE Manage(
	userId INT NOT NULL,
    sId	VARCHAR(4) NOT NULL,
    setUpTime DATE NOT NULL,
	PRIMARY KEY (userId, sId),
    FOREIGN KEY (userId) REFERENCES seller(userId),
    FOREIGN KEY (sId) REFERENCES store(sId)
);

CREATE TABLE ServicePoint(
	spId INT PRIMARY KEY NOT NULL,
    streetAddr VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50) NOT NULL,
    startTime VARCHAR(20),
    endTime VARCHAR(20)
);

CREATE TABLE After_Sales_Service_At(
	brandName VARCHAR(20) NOT NULL,
    spId INT NOT NULL,
    PRIMARY KEY (brandName, spId),
    FOREIGN KEY (spId) REFERENCES ServicePoint(spId),
    FOREIGN KEY (brandName) REFERENCES Brand(brandName)
);


-- ALTERAÇÕES
ALTER TABLE store
DROP COLUMN startTime;

ALTER TABLE store
ADD COLUMN startTime DATE;

ALTER TABLE Orders
MODIFY COLUMN creationTime DATE;

-- DESABILITA AS FK'S
SET FOREIGN_KEY_CHECKS = 0;
SET FOREIGN_KEY_CHECKS = 1;





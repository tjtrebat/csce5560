DROP TABLE IF EXISTS checkout_products;
DROP TABLE IF EXISTS checkout_addresses;
DROP TABLE IF EXISTS checkout_confirmation;

CREATE TABLE checkout_confirmation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    confirmation_number VARCHAR(250) NOT NULL
);

CREATE TABLE checkout_addresses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    confirmation_id INT NOT NULL,
    billing_addr_1 VARCHAR(250) NOT NULL,
    billing_addr_2 VARCHAR(250),
    billing_city VARCHAR(250) NOT NULL,
    billing_state CHAR(2) NOT NULL,
    billing_zip CHAR(5) NOT NULL,
    mailing_addr_1 VARCHAR(250) NOT NULL,
    mailing_addr_2 VARCHAR(250),
    mailing_city VARCHAR(250) NOT NULL,
    mailing_state CHAR(2) NOT NULL,
    mailing_zip CHAR(5) NOT NULL,
    FOREIGN KEY (confirmation_id) REFERENCES checkout_confirmation(id)
);

CREATE TABLE product_checkout (
    id INT PRIMARY KEY AUTO_INCREMENT,
    confirmation_id INT NOT NULL,    
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (confirmation_id) REFERENCES checkout_confirmation(id),    
    FOREIGN KEY (product_id) REFERENCES products(id)
);

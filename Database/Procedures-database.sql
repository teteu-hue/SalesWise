-- Users
CREATE OR REPLACE PROCEDURE insert_user(
    p_username VARCHAR(100),
    p_password_hash VARCHAR(255),
    p_email VARCHAR(100) DEFAULT NULL,
    p_role VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Users(username, password_hash, role, email)
    VALUES (p_username, p_password_hash, p_email, p_role);
END $$;

-- Products
CREATE OR REPLACE PROCEDURE insert_product(
    p_name VARCHAR(100),
    p_price DECIMAL(10, 2),
    p_stock_quantity INT DEFAULT 0,
    p_description TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Products(name, price, stock_quantity, description)
    VALUES (p_name, p_price, p_stock_quantity, p_description)
END $$;

-- Customers
CREATE OR REPLACE PROCEDURE insert_customer(
    p_name VARCHAR(100),
    p_phone VARCHAR(20) DEFAULT NULL,
    p_address TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$ 
BEGIN
    INSERT INTO Customers(name, phone, address)
    VALUES(p_name, p_phone, p_address)
END $$;

-- Orders
CREATE OR REPLACE PROCEDURE create_order(
    p_id_customer INT,
    p_total_amount DECIMAL(10, 2) DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Orders(id_customer, total_amount)
    VALUES(p_id_customer, p_total_amount)
END $$:

-- OrderItems
CREATE OR REPLACE PROCEDURE create_order_items(
    p_id_order INT,
    p_id_product INT,
    p_quantity INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO OrderItems(id_order, id_product, p_quantity)
    VALUES(p_id_order, p_id_product, p_quantity)
END $$;
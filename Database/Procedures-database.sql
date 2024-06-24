-- Users
CREATE OR REPLACE PROCEDURE insert_user(
    p_username VARCHAR(100),
    p_password_hash VARCHAR(255),
    p_role VARCHAR(20),
    p_email VARCHAR(100) DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Users(username, password_hash, role, email)
    VALUES (p_username, p_password_hash, p_role, p_email);
END $$;

-- Products
CREATE OR REPLACE PROCEDURE insert_product(
    p_name VARCHAR(100),
    p_price DECIMAL(10, 2),
    p_id_categorie INT,
    p_stock_quantity INT DEFAULT 0,
    p_description TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_status BOOLEAN;
BEGIN
    v_status = TRUE;

    INSERT INTO Products(name, price, id_categorie, stock_quantity, description, status)
    VALUES (p_name, p_price, p_id_categorie, p_stock_quantity, p_description, v_status);
END $$;

CREATE OR REPLACE PROCEDURE update_product(
    p_id_product INT,
    p_name VARCHAR(100) DEFAULT NULL,
    p_price DECIMAL(10, 2) DEFAULT NULL,
    p_id_categorie INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Products
    SET
        name = COALESCE(p_name, name),
        price = COALESCE(p_price, price),
        id_categorie = COALESCE(p_id_categorie, id_categorie),
        updated_at = CURRENT_TIMESTAMP
    WHERE
        p_id_product = id_product;
END $$;

CREATE OR REPLACE PROCEDURE delete_product(
    p_id_product INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_id_product <= 0 THEN
        RAISE EXCEPTION 'Não é possível deletar um valor abaixo de zero!';
    END IF;

    DELETE FROM Products
    WHERE p_id_product = id_product;
END $$;

-- Categories
CREATE OR REPLACE PROCEDURE insert_categorie(
    p_name VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Categories(name)
    VALUES (p_name);
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
    VALUES(p_name, p_phone, p_address);
END $$;

-- Orders
CREATE OR REPLACE PROCEDURE create_order(
    p_id_customer INT,
    p_total_amount DECIMAL(10, 2) DEFAULT 0
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Orders(id_customer, total_amount)
    VALUES(p_id_customer, p_total_amount);
END $$;

-- OrderItems
CREATE OR REPLACE PROCEDURE create_order_items(
    p_id_order INT,
    p_id_product INT,
    p_stock_quantity INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_unit_price DECIMAL(10, 2);
BEGIN
    -- Obter o preço unitário dos produtos
    SELECT price INTO v_unit_price
    FROM Products
    WHERE id_product = p_id_product;

    INSERT INTO OrderItems(id_order, id_product, quantity, unit_price)
    VALUES(p_id_order, p_id_product, p_stock_quantity, v_unit_price);
END $$;

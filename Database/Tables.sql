-- Tabela Users para gerenciamento de usuários
CREATE TABLE Users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NULL,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('admin', 'seller')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela Products para gerenciamento de produtos
CREATE TABLE Products (
    id_product SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Categories (
    id_categorie SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

ALTER TABLE Products
ADD COLUMN id_categorie INT NOT NULL;

ALTER TABLE Products
ADD FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie);

-- Tabela Customers para gerenciamento de clientes
CREATE TABLE Customers (
    id_customer SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE OrderStatus(
    id_status SERIAL PRIMARY KEY,
    status_order VARCHAR(20) UNIQUE NOT NULL
);

-- Tabela Orders para gerenciamento de pedidos
CREATE TABLE Orders (
    id_order SERIAL PRIMARY KEY,
    id_customer INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_status INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_customer) REFERENCES Customers(id_customer),
    FOREIGN KEY (id_status) REFERENCES OrderStatus(id_status)
);

-- Tabela OrderItems para gerenciamento de itens de pedidos
CREATE TABLE OrderItems (
    id_order_items SERIAL PRIMARY KEY,
    id_order INT NOT NULL,
    id_product INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_order) REFERENCES Orders(id_order),
    FOREIGN KEY (id_product) REFERENCES Products(id_product)
);

INSERT INTO OrderStatus (status_order) VALUES ('pending'), ('shipped'), ('delivered'), ('cancelled');

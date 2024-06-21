-- ******************** FUNCTIONS ********************
-- Atualizar o valor total 'total_price'
CREATE OR REPLACE FUNCTION calculate_total_price()
RETURNS TRIGGER AS $$
BEGIN
    NEW.total_price := NEW.quantity * NEW.unit_price;
    RETURN NEW;
END $$
LANGUAGE plpgsql;

-- Atualizar o valor total de um pedido
CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN 
    UPDATE Orders
    SET total_amount = (
        SELECT COALESCE(SUM(total_price), 0) -- retorna o primeiro valor não nulo
        FROM OrderItems
        WHERE id_order = NEW.id_order
    )
    WHERE id_order = NEW.id_order;

    RETURN NEW;
END $$ 
LANGUAGE plpgsql;

-- Atualizar o estoque de produtos
CREATE OR REPLACE FUNCTION check_and_update_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE v_stock_quantity INT;
BEGIN 
    -- Verificando a quantidade que existe no estoque
    SELECT stock_quantity INTO v_stock_quantity FROM Products WHERE id_product = NEW.id_product;

    -- Verifica se o estoque está zerado
    IF v_stock_quantity = 0 THEN
        RAISE EXCEPTION 'O estoque do produto está zerado, por favor insira um valor válido';
    END IF;

    -- Verifica se a quantidade informada ultrapassa o valor do estoque
    IF v_stock_quantity < NEW.quantity THEN
        RAISE EXCEPTION 'A quantidade de venda é maior que o estoque atual do produto';
    END IF;

    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE id_product = NEW.id_product;

    RETURN NEW;
END $$;

-- Sempre que um pedido é criado adiciona o status 'pending' para o mesmo

CREATE OR REPLACE FUNCTION set_pending_status()
RETURNS TRIGGER AS $$
BEGIN
    NEW.id_status := (SELECT id_status FROM OrderStatus WHERE id_status = 1);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- ******************** TRIGGERS ********************
-- Trigger após inserir um item no pedido
CREATE TRIGGER after_insert_order_item
AFTER INSERT ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION update_order_total();

-- Trigger após atualizar 
CREATE TRIGGER after_update_order_item
AFTER UPDATE ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION update_order_total();

-- Trigger após excluir um item do pedido
CREATE TRIGGER after_delete_order_item
AFTER DELETE ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION update_order_total();

-- Trigger usado para calcular o 'total_price'
CREATE TRIGGER before_insert_order_item
BEFORE INSERT ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION calculate_total_price();

-- Trigger usado para calcular o 'total_price'
CREATE TRIGGER before_update_order_item
BEFORE UPDATE ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION calculate_total_price();

-- Trigger utilizado para atualizar o estoque do produto
CREATE TRIGGER before_insert_order_item_stock
BEFORE INSERT ON OrderItems
FOR EACH ROW
EXECUTE FUNCTION check_and_update_stock();

-- Trigger utilizada após criar um pedido
CREATE TRIGGER set_status_to_pending
BEFORE INSERT ON Orders
FOR EACH ROW
EXECUTE FUNCTION set_pending_status();
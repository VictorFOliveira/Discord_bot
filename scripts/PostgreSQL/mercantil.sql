-- Tabela de Fornecedores
CREATE TABLE IF NOT EXISTS fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    quantidade_em_estoque INT DEFAULT 0,
    fornecedor_id INT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_fornecedor FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id) ON DELETE CASCADE,
    CONSTRAINT chk_preco_unitario CHECK (preco_unitario > 0)
);

-- Tabela de Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_cpf CHECK (cpf ~ '^\d{3}\.\d{3}\.\d{3}-\d{2}$')
);

-- Tabela de Vendas
CREATE TABLE IF NOT EXISTS vendas (
    id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_venda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE
);

-- Tabela de Itens de Venda
CREATE TABLE IF NOT EXISTS itens_venda (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_venda FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE,
    CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- Tabela de Pagamentos
CREATE TABLE IF NOT EXISTS pagamentos (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    data_pagamento TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_pagamento VARCHAR(50) NOT NULL,
    CONSTRAINT fk_venda_pagamento FOREIGN KEY (venda_id) REFERENCES vendas(id) ON DELETE CASCADE
);

-- Índices para otimizar consultas frequentes
CREATE INDEX IF NOT EXISTS idx_produto_fornecedor ON produtos(fornecedor_id);
CREATE INDEX IF NOT EXISTS idx_cliente_id ON vendas(cliente_id);
CREATE INDEX IF NOT EXISTS idx_venda_id ON itens_venda(venda_id);
CREATE INDEX IF NOT EXISTS idx_produto_id ON itens_venda(produto_id);

-- Inserindo dados de exemplo

-- Fornecedores
INSERT INTO fornecedores (nome, cnpj, endereco, telefone, email) VALUES
('Fornecedor A', '12.345.678/0001-99', 'Rua A, 123, Centro', '11987654321', 'fornecedora@exemplo.com'),
('Fornecedor B', '98.765.432/0001-00', 'Avenida B, 456, Bairro', '11976543210', 'fornecedorb@exemplo.com');

-- Produtos
INSERT INTO produtos (nome, descricao, preco_unitario, quantidade_em_estoque, fornecedor_id) VALUES
('Produto 1', 'Descrição do Produto 1', 20.00, 100, 1),
('Produto 2', 'Descrição do Produto 2', 15.50, 50, 2),
('Produto 3', 'Descrição do Produto 3', 30.00, 200, 1);

-- Clientes
INSERT INTO clientes (nome, cpf, endereco, telefone, email) VALUES
('Carlos Silva', '123.456.789-10', 'Rua X, 321, Centro', '11912345678', 'carlos.silva@cliente.com'),
('Ana Souza', '987.654.321-00', 'Avenida Y, 654, Bairro', '11923456789', 'ana.souza@cliente.com');

-- Vendas
INSERT INTO vendas (cliente_id, valor_total, forma_pagamento) VALUES
(1, 60.00, 'Cartão de Crédito'),
(2, 45.00, 'Dinheiro');

-- Itens de Venda
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario, valor_total) VALUES
(1, 1, 2, 20.00, 40.00),
(1, 2, 1, 15.50, 15.50),
(2, 2, 2, 15.50, 31.00);

-- Pagamentos
INSERT INTO pagamentos (venda_id, valor_pago, tipo_pagamento) VALUES
(1, 60.00, 'Cartão de Crédito'),
(2, 45.00, 'Dinheiro');

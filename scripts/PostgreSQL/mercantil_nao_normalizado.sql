-- Tabela de Vendas (não normalizada)
CREATE TABLE IF NOT EXISTS vendas (
    id SERIAL PRIMARY KEY,
    cliente_nome VARCHAR(100) NOT NULL,
    cliente_cpf VARCHAR(14) NOT NULL,
    cliente_endereco TEXT,
    cliente_telefone VARCHAR(15),
    cliente_email VARCHAR(100),
    produto_nome VARCHAR(100) NOT NULL,
    produto_descricao TEXT,
    produto_preco DECIMAL(10, 2) NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    data_venda TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    forma_pagamento VARCHAR(50) NOT NULL
);

-- Tabela de Produtos (não normalizada)
CREATE TABLE IF NOT EXISTS produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_em_estoque INT DEFAULT 0
);

-- Tabela de Fornecedores (não normalizada)
CREATE TABLE IF NOT EXISTS fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela de Clientes (não normalizada)
CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela de Pagamentos (não normalizada)
CREATE TABLE IF NOT EXISTS pagamentos (
    id SERIAL PRIMARY KEY,
    venda_id INT NOT NULL,
    cliente_nome VARCHAR(100) NOT NULL,
    cliente_cpf VARCHAR(14) NOT NULL,
    valor_pago DECIMAL(10, 2) NOT NULL,
    tipo_pagamento VARCHAR(50) NOT NULL,
    data_pagamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Estoque (não normalizada)
CREATE TABLE IF NOT EXISTS estoque (
    id SERIAL PRIMARY KEY,
    produto_nome VARCHAR(100) NOT NULL,
    produto_descricao TEXT,
    quantidade_em_estoque INT DEFAULT 0,
    fornecedor_nome VARCHAR(100) NOT NULL,
    fornecedor_cnpj VARCHAR(20) NOT NULL
);

-- Inserindo Dados de Exemplo

-- Fornecedores
INSERT INTO fornecedores (nome, cnpj, endereco, telefone, email) VALUES
('Fornecedor A', '12.345.678/0001-99', 'Rua A, 123, Centro', '11987654321', 'fornecedora@exemplo.com'),
('Fornecedor B', '98.765.432/0001-00', 'Avenida B, 456, Bairro', '11976543210', 'fornecedorb@exemplo.com');

-- Produtos
INSERT INTO produtos (nome, descricao, preco, quantidade_em_estoque) VALUES
('Produto 1', 'Descrição do Produto 1', 20.00, 100),
('Produto 2', 'Descrição do Produto 2', 15.50, 50),
('Produto 3', 'Descrição do Produto 3', 30.00, 200);

-- Clientes
INSERT INTO clientes (nome, cpf, endereco, telefone, email) VALUES
('Carlos Silva', '123.456.789-10', 'Rua X, 321, Centro', '11912345678', 'carlos.silva@cliente.com'),
('Ana Souza', '987.654.321-00', 'Avenida Y, 654, Bairro', '11923456789', 'ana.souza@cliente.com');

-- Vendas
INSERT INTO vendas (cliente_nome, cliente_cpf, cliente_endereco, cliente_telefone, cliente_email, produto_nome, produto_descricao, produto_preco, quantidade, valor_total, forma_pagamento) VALUES
('Carlos Silva', '123.456.789-10', 'Rua X, 321, Centro', '11912345678', 'carlos.silva@cliente.com', 'Produto 1', 'Descrição do Produto 1', 20.00, 2, 40.00, 'Cartão de Crédito'),
('Ana Souza', '987.654.321-00', 'Avenida Y, 654, Bairro', '1

CREATE TABLE IF NOT EXISTS usuarios (
    id SERIAL PRIMARY KEY,                  
    nome VARCHAR(100) NOT NULL,              
    email VARCHAR(100) UNIQUE NOT NULL,     
    telefone VARCHAR(15) NOT NULL,           
    endereco TEXT,                           
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE IF NOT EXISTS motoristas (
    id SERIAL PRIMARY KEY,                  
    nome VARCHAR(100) NOT NULL,             
    email VARCHAR(100) UNIQUE NOT NULL,     
    telefone VARCHAR(15) NOT NULL,          
    placa VARCHAR(10) UNIQUE NOT NULL,       
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

CREATE TABLE IF NOT EXISTS corridas (
    id SERIAL PRIMARY KEY,                   
    usuario_id INT NOT NULL,                 
    motorista_id INT NOT NULL,                
    data_hora TIMESTAMP NOT NULL,            
    origem VARCHAR(255) NOT NULL,             
    destino VARCHAR(255) NOT NULL,            
    preco DECIMAL(10, 2) NOT NULL CHECK (preco >= 0), 
    status VARCHAR(50) NOT NULL DEFAULT 'pendente', 
    CONSTRAINT fk_usuario FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,  
    CONSTRAINT fk_motorista FOREIGN KEY (motorista_id) REFERENCES motoristas(id) ON DELETE CASCADE, 
    CONSTRAINT chk_status CHECK (status IN ('pendente', 'concluída', 'cancelada')),  
    CHECK (data_hora >= CURRENT_TIMESTAMP) -- 

CREATE INDEX IF NOT EXISTS idx_usuario_id ON corridas(usuario_id);
CREATE INDEX IF NOT EXISTS idx_motorista_id ON corridas(motorista_id);

CREATE UNIQUE INDEX IF NOT EXISTS idx_usuario_motorista_data_hora ON corridas(usuario_id, motorista_id, data_hora);

INSERT INTO usuarios (nome, email, telefone) VALUES
('João Silva', 'joao.silva@example.com', '11999999999'),
('Maria Oliveira', 'maria.oliveira@example.com', '11888888888');

INSERT INTO motoristas (nome, email, telefone, carro, placa) VALUES
('Carlos Souza', 'carlos.souza@example.com', '123456789', 'Honda Civic', 'ABC1234'),
('Ana Santos', 'ana.santos@example.com', '987654321', 'Toyota Corolla', 'XYZ9876');

-- Inserindo corridas fictícias
INSERT INTO corridas (usuario_id, motorista_id, data_hora, origem, destino, preco, status) VALUES
(1, 1, '2025-01-12 10:30:00', 'Rua A', 'Rua B', 45.00, 'pendente'),
(2, 2, '2025-01-12 11:00:00', 'Avenida X', 'Avenida Y', 55.00, 'concluída');

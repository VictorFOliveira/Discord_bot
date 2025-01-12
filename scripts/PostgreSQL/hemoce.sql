CREATE TABLE IF NOT EXISTS doadores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    tipo_sanguineo VARCHAR(3) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_tipo_sanguineo CHECK (tipo_sanguineo IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
    CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS hospitais (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco TEXT NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS doacoes (
    id SERIAL PRIMARY KEY,
    doador_id INT NOT NULL,
    hospital_id INT NOT NULL,
    data_doacao TIMESTAMP NOT NULL,
    quantidade DECIMAL(5,2) NOT NULL CHECK (quantidade > 0), 
    tipo_sanguineo VARCHAR(3) NOT NULL,
    CONSTRAINT fk_doador FOREIGN KEY (doador_id) REFERENCES doadores(id) ON DELETE CASCADE,
    CONSTRAINT fk_hospital FOREIGN KEY (hospital_id) REFERENCES hospitais(id) ON DELETE CASCADE,
    CONSTRAINT chk_tipo_sanguineo_doacao CHECK (tipo_sanguineo IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
    CHECK (data_doacao <= CURRENT_TIMESTAMP)
);

CREATE INDEX IF NOT EXISTS idx_doador_id ON doacoes(doador_id);
CREATE INDEX IF NOT EXISTS idx_hospital_id ON doacoes(hospital_id);
CREATE INDEX IF NOT EXISTS idx_tipo_sanguineo ON doacoes(tipo_sanguineo);

-- Inserindo dados de exemplo

INSERT INTO doadores (nome, email, telefone, tipo_sanguineo, data_nascimento) VALUES
('José da Silva', 'jose.silva@example.com', '11987654321', 'O+', '1990-03-15'),
('Ana Pereira', 'ana.pereira@example.com', '11876543210', 'A-', '1985-06-25');

INSERT INTO hospitais (nome, endereco, telefone, email) VALUES
('Hospital São José', 'Rua das Flores, 123', '1132123456', 'saude@saosjose.com'),
('Hospital Santa Cruz', 'Avenida Paulista, 456', '1132435678', 'contato@hospitalsantacruz.com');

INSERT INTO doacoes (doador_id, hospital_id, data_doacao, quantidade, tipo_sanguineo) VALUES
(1, 1, '2025-01-10 08:30:00', 450.00, 'O+'),
(2, 2, '2025-01-11 09:15:00', 500.00, 'A-');

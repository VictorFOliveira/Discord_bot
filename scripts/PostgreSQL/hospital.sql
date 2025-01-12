-- Tabela de Médicos
CREATE TABLE IF NOT EXISTS medicos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    especialidade VARCHAR(100) NOT NULL,
    crm VARCHAR(20) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pacientes
CREATE TABLE IF NOT EXISTS pacientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('M', 'F')),
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_data_nascimento CHECK (data_nascimento <= CURRENT_DATE)
);

-- Tabela de Consultas
CREATE TABLE IF NOT EXISTS consultas (
    id SERIAL PRIMARY KEY,
    paciente_id INT NOT NULL,
    medico_id INT NOT NULL,
    data_consulta TIMESTAMP NOT NULL,
    tipo_consulta VARCHAR(100) NOT NULL,
    observacoes TEXT,
    CONSTRAINT fk_paciente FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    CONSTRAINT fk_medico FOREIGN KEY (medico_id) REFERENCES medicos(id) ON DELETE CASCADE,
    CHECK (data_consulta <= CURRENT_TIMESTAMP)
);

-- Tabela de Tratamentos
CREATE TABLE IF NOT EXISTS tratamentos (
    id SERIAL PRIMARY KEY,
    consulta_id INT NOT NULL,
    descricao TEXT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE,
    CONSTRAINT fk_consulta FOREIGN KEY (consulta_id) REFERENCES consultas(id) ON DELETE CASCADE,
    CONSTRAINT chk_data_inicio CHECK (data_inicio <= CURRENT_DATE),
    CONSTRAINT chk_data_fim CHECK (data_fim >= data_inicio OR data_fim IS NULL)
);

-- Tabela de Medicamentos
CREATE TABLE IF NOT EXISTS medicamentos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    tipo VARCHAR(50),
    dosagem VARCHAR(50),
    quantidade_em_estoque INT DEFAULT 0,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Prescrições
CREATE TABLE IF NOT EXISTS prescricoes (
    id SERIAL PRIMARY KEY,
    tratamento_id INT NOT NULL,
    medicamento_id INT NOT NULL,
    quantidade INT NOT NULL,
    frequencia VARCHAR(100) NOT NULL,
    data_prescricao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tratamento FOREIGN KEY (tratamento_id) REFERENCES tratamentos(id) ON DELETE CASCADE,
    CONSTRAINT fk_medicamento FOREIGN KEY (medicamento_id) REFERENCES medicamentos(id) ON DELETE CASCADE
);

-- Tabela de Internações
CREATE TABLE IF NOT EXISTS internacoes (
    id SERIAL PRIMARY KEY,
    paciente_id INT NOT NULL,
    leito VARCHAR(20) NOT NULL,
    data_internacao TIMESTAMP NOT NULL,
    data_alta TIMESTAMP,
    CONSTRAINT fk_paciente_internacao FOREIGN KEY (paciente_id) REFERENCES pacientes(id) ON DELETE CASCADE,
    CONSTRAINT chk_data_internacao CHECK (data_internacao <= CURRENT_TIMESTAMP),
    CONSTRAINT chk_data_alta CHECK (data_alta >= data_internacao OR data_alta IS NULL)
);

-- Índices para melhorar o desempenho
CREATE INDEX IF NOT EXISTS idx_paciente_id ON consultas(paciente_id);
CREATE INDEX IF NOT EXISTS idx_medico_id ON consultas(medico_id);
CREATE INDEX IF NOT EXISTS idx_tratamento_id ON prescricoes(tratamento_id);
CREATE INDEX IF NOT EXISTS idx_medicamento_id ON prescricoes(medicamento_id);

-- Inserindo dados de exemplo

-- Médicos
INSERT INTO medicos (nome, especialidade, crm, telefone, email) VALUES
('Dr. João Silva', 'Cardiologia', 'CRM12345', '11987654321', 'joao.silva@hospital.com'),
('Dra. Maria Oliveira', 'Neurologia', 'CRM67890', '11976543210', 'maria.oliveira@hospital.com');

-- Pacientes
INSERT INTO pacientes (nome, data_nascimento, sexo, endereco, telefone, email) VALUES
('Carlos Souza', '1985-07-10', 'M', 'Rua das Acácias, 45', '11912345678', 'carlos.souza@exemplo.com'),
('Ana Costa', '1990-03-25', 'F', 'Av. Brasil, 10', '11923456789', 'ana.costa@exemplo.com');

-- Consultas
INSERT INTO consultas (paciente_id, medico_id, data_consulta, tipo_consulta, observacoes) VALUES
(1, 1, '2025-01-10 09:00:00', 'Consulta de rotina', 'Paciente apresenta quadro estável de hipertensão.'),
(2, 2, '2025-01-11 14:30:00', 'Consulta neurológica', 'Paciente apresenta dores de cabeça frequentes.');

-- Tratamentos
INSERT INTO tratamentos (consulta_id, descricao, data_inicio, data_fim) VALUES
(1, 'Tratamento para hipertensão', '2025-01-10', '2025-02-10'),
(2, 'Tratamento para dores de cabeça', '2025-01-11', NULL);

-- Medicamentos
INSERT INTO medicamentos (nome, descricao, tipo, dosagem, quantidade_em_estoque) VALUES
('Losartana', 'Medicamento para controle de pressão arterial', 'Comprimido', '50mg', 100),
('Ibuprofeno', 'Analgésico e anti-inflamatório', 'Comprimido', '200mg', 150);

-- Prescrições
INSERT INTO prescricoes (tratamento_id, medicamento_id, quantidade, frequencia) VALUES
(1, 1, 30, '1 comprimido por dia'),
(2, 2, 20, '1 comprimido a cada 8 horas');

-- Internações
INSERT INTO internacoes (paciente_id, leito, data_internacao, data_alta) VALUES
(1, 'Leito 101', '2025-01-10 10:00:00', NULL);

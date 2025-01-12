-- Tabela de Alunos (não normalizada)
CREATE TABLE IF NOT EXISTS alunos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_nascimento DATE,
    curso_nome VARCHAR(100),
    professor_nome VARCHAR(100),
    turma_nome VARCHAR(50)
);

-- Tabela de Professores (não normalizada)
CREATE TABLE IF NOT EXISTS professores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    endereco TEXT,
    telefone VARCHAR(15),
    email VARCHAR(100),
    salario DECIMAL(10, 2),
    materia_nome VARCHAR(100)
);

-- Tabela de Cursos (não normalizada)
CREATE TABLE IF NOT EXISTS cursos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    carga_horaria INT NOT NULL,
    professor_nome VARCHAR(100)
);

-- Tabela de Notas (não normalizada)
CREATE TABLE IF NOT EXISTS notas (
    id SERIAL PRIMARY KEY,
    aluno_nome VARCHAR(100) NOT NULL,
    aluno_cpf VARCHAR(14) NOT NULL,
    curso_nome VARCHAR(100) NOT NULL,
    nota DECIMAL(5, 2) NOT NULL,
    data_avaliacao DATE
);

-- Tabela de Matrículas (não normalizada)
CREATE TABLE IF NOT EXISTS matriculas (
    id SERIAL PRIMARY KEY,
    aluno_nome VARCHAR(100) NOT NULL,
    aluno_cpf VARCHAR(14) NOT NULL,
    curso_nome VARCHAR(100) NOT NULL,
    turma_nome VARCHAR(50),
    data_matricula DATE
);

-- Inserindo Dados de Exemplo

-- Alunos
INSERT INTO alunos (nome, cpf, endereco, telefone, email, data_nascimento, curso_nome, professor_nome, turma_nome) VALUES
('João Silva', '123.456.789-10', 'Rua A, 123, Centro', '11987654321', 'joao.silva@escola.com', '2000-01-01', 'Matemática', 'Prof. Marcos', 'Turma A'),
('Ana Souza', '987.654.321-00', 'Avenida B, 456, Bairro', '11976543210', 'ana.souza@escola.com', '2000-02-15', 'História', 'Prof. Carla', 'Turma B'),
('Lucas Almeida', '321.654.987-11', 'Rua C, 789, Centro', '11965432109', 'lucas.almeida@escola.com', '2000-03-10', 'Biologia', 'Prof. Roberto', 'Turma A');

-- Professores
INSERT INTO professores (nome, cpf, endereco, telefone, email, salario, materia_nome) VALUES
('Prof. Marcos', '123.987.456-00', 'Rua X, 111, Centro', '11912345678', 'marcos@escola.com', 3000.00, 'Matemática'),
('Prof. Carla', '987.321.654-00', 'Avenida Y, 222, Bairro', '11923456789', 'carla@escola.com', 3500.00, 'História'),
('Prof. Roberto', '456.123.789-00', 'Rua Z, 333, Centro', '11934567890', 'roberto@escola.com', 4000.00, 'Biologia');

-- Cursos
INSERT INTO cursos (nome, descricao, carga_horaria, professor_nome) VALUES
('Matemática', 'Curso de Matemática Básica', 120, 'Prof. Marcos'),
('História', 'Curso de História Geral', 100, 'Prof. Carla'),
('Biologia', 'Curso de Biologia Celular', 150, 'Prof. Roberto');

-- Notas
INSERT INTO notas (aluno_nome, aluno_cpf, curso_nome, nota, data_avaliacao) VALUES
('João Silva', '123.456.789-10', 'Matemática', 8.5, '2024-06-01'),
('Ana Souza', '987.654.321-00', 'História', 9.0, '2024-06-01'),
('Lucas Almeida', '321.654.987-11', 'Biologia', 7.5, '2024-06-01');

-- Matrículas
INSERT INTO matriculas (aluno_nome, aluno_cpf, curso_nome, turma_nome, data_matricula) VALUES
('João Silva', '123.456.789-10', 'Matemática', 'Turma A', '2024-01-15'),
('Ana Souza', '987.654.321-00', 'História', 'Turma B', '2024-01-16'),
('Lucas Almeida', '321.654.987-11', 'Biologia', 'Turma A', '2024-01-17');

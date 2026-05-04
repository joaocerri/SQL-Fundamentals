CREATE TABLE users (
    id VARCHAR(128) PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    plano VARCHAR(50) DEFAULT 'freemium',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_settings (
    user_id VARCHAR(128) PRIMARY KEY,
    taxa_horaria_padrao DECIMAL(10, 2) DEFAULT 0.00,
    moeda VARCHAR(10) DEFAULT 'BRL',
    tema_interface VARCHAR(20) DEFAULT 'dark',
    pomodoro_trabalho_min INT DEFAULT 25,
    pomodoro_pausa_min INT DEFAULT 5,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(128) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    contato VARCHAR(255),
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(128) NOT NULL,
    client_id INT NULL,
    nome VARCHAR(255) NOT NULL,
    orcamento_horas DECIMAL(10, 2) NULL,
    status VARCHAR(50) DEFAULT 'em_andamento',
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE
    SET
        NULL
);

CREATE TABLE tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(128) NOT NULL,
    project_id INT NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    status VARCHAR(50) DEFAULT 'todo',
    estimativa_horas DECIMAL(10, 2) NULL,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);

CREATE TABLE time_entries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(128) NOT NULL,
    project_id INT NULL,
    descricao VARCHAR(255) NULL,
    tags JSON NULL,
    inicio DATETIME NOT NULL,
    fim DATETIME NULL,
    duracao_segundos INT NULL,
    faturavel BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE
    SET
        NULL
);

CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id VARCHAR(128) NOT NULL,
    client_id INT NOT NULL,
    mes_referencia VARCHAR(7) NOT NULL,
    total_horas DECIMAL(10, 2) NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pendente',
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    pago_em DATETIME NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE
);

INSERT INTO users (id, nome, email, plano) VALUES
('usr_001', 'João Cerri', 'joao.cerri@email.com', 'pro'),
('usr_002', 'Maria Silva', 'maria.silva@email.com', 'freemium'),
('usr_003', 'Carlos Souza', 'carlos.souza@email.com', 'pro');

INSERT INTO user_settings (user_id, taxa_horaria_padrao, moeda, tema_interface, pomodoro_trabalho_min, pomodoro_pausa_min) VALUES
('usr_001', 120.00, 'BRL', 'dark', 25, 5),
('usr_002', 80.00, 'BRL', 'light', 30, 5),
('usr_003', 150.00, 'USD', 'dark', 50, 10);

INSERT INTO clients (user_id, nome, contato, ativo) VALUES
('usr_001', 'Tech Solutions', 'contato@techsolutions.com', TRUE),
('usr_001', 'Loja Digital', 'suporte@lojadigital.com', TRUE),
('usr_002', 'Startup Alpha', 'alpha@startup.com', TRUE),
('usr_003', 'Empresa Beta', 'contato@empresabeta.com', TRUE);

INSERT INTO projects (user_id, client_id, nome, orcamento_horas, status) VALUES
('usr_001', 1, 'Sistema de Gestão', 120, 'em_andamento'),
('usr_001', 2, 'Landing Page E-commerce', 40, 'em_andamento'),
('usr_002', 3, 'App Mobile MVP', 200, 'planejado'),
('usr_003', 4, 'Dashboard Analytics', 80, 'em_andamento');

-- TASKS
INSERT INTO tasks (user_id, project_id, titulo, status, estimativa_horas) VALUES
('usr_001', 1, 'Modelagem do Banco de Dados', 'done', 8),
('usr_001', 1, 'API REST - Autenticação', 'em_progresso', 12),
('usr_001', 2, 'Layout da Landing Page', 'todo', 6),
('usr_002', 3, 'Configuração do Projeto Flutter', 'todo', 5),
('usr_003', 4, 'Criação de gráficos no dashboard', 'em_progresso', 10);

INSERT INTO time_entries (user_id, project_id, descricao, tags, inicio, fim, duracao_segundos, faturavel) VALUES
('usr_001', 1, 'Modelagem inicial do banco', '["backend","database"]', '2026-05-01 09:00:00', '2026-05-01 11:00:00', 7200, TRUE),
('usr_001', 1, 'Implementação login JWT', '["backend","auth"]', '2026-05-02 14:00:00', '2026-05-02 16:30:00', 9000, TRUE),
('usr_001', 2, 'Estrutura HTML da landing', '["frontend","ui"]', '2026-05-03 10:00:00', '2026-05-03 12:00:00', 7200, TRUE),
('usr_002', 3, 'Setup inicial Flutter', '["mobile","setup"]', '2026-05-02 09:30:00', '2026-05-02 11:00:00', 5400, FALSE),
('usr_003', 4, 'Integração API analytics', '["backend","api"]', '2026-05-03 15:00:00', '2026-05-03 17:00:00', 7200, TRUE);

INSERT INTO invoices (user_id, client_id, mes_referencia, total_horas, valor_total, status, pago_em) VALUES
('usr_001', 1, '2026-04', 20.5, 2460.00, 'pago', '2026-05-01 10:00:00'),
('usr_001', 2, '2026-04', 10.0, 1200.00, 'pendente', NULL),
('usr_002', 3, '2026-04', 15.0, 1200.00, 'pendente', NULL),
('usr_003', 4, '2026-04', 18.0, 2700.00, 'pago', '2026-05-02 09:00:00');
DROP DATABASE IF EXISTS TRACKFLOW;

CREATE DATABASE TRACKFLOW;

USE TRACKFLOW;

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
('usr_001','João Cerri','joao1@email.com','pro'),
('usr_002','Maria Silva','maria@email.com','freemium'),
('usr_003','Carlos Souza','carlos@email.com','pro'),
('usr_004','Ana Lima','ana@email.com','freemium'),
('usr_005','Pedro Santos','pedro@email.com','pro'),
('usr_006','Juliana Alves','juliana@email.com','freemium'),
('usr_007','Rafael Costa','rafael@email.com','pro'),
('usr_008','Fernanda Rocha','fernanda@email.com','freemium'),
('usr_009','Lucas Martins','lucas@email.com','pro'),
('usr_010','Beatriz Gomes','bia@email.com','freemium');

INSERT INTO user_settings (user_id, taxa_horaria_padrao, moeda, tema_interface) VALUES
('usr_001',120,'BRL','dark'),
('usr_002',80,'BRL','light'),
('usr_003',150,'USD','dark'),
('usr_004',90,'BRL','dark'),
('usr_005',110,'BRL','light'),
('usr_006',70,'BRL','dark'),
('usr_007',200,'USD','dark'),
('usr_008',95,'BRL','light'),
('usr_009',130,'BRL','dark'),
('usr_010',85,'BRL','light');

INSERT INTO clients (user_id,nome,contato) VALUES
('usr_001','Tech Solutions','tech@email.com'),
('usr_001','Loja Digital','loja@email.com'),
('usr_002','Startup Alpha','alpha@email.com'),
('usr_002','Startup Beta','beta@email.com'),
('usr_003','Empresa Gamma','gamma@email.com'),
('usr_003','Empresa Delta','delta@email.com'),
('usr_004','Agência Pixel','pixel@email.com'),
('usr_004','Mercado Online','mercado@email.com'),
('usr_005','Clínica Vida','vida@email.com'),
('usr_005','Clínica Saúde','saude@email.com'),
('usr_006','Restaurante Sabor','sabor@email.com'),
('usr_006','Café Central','cafe@email.com'),
('usr_007','Indústria Forte','forte@email.com'),
('usr_007','Metalúrgica Aço','aco@email.com'),
('usr_008','Escola Saber','saber@email.com'),
('usr_008','Colégio Futuro','futuro@email.com'),
('usr_009','Consultoria Pro','consult@email.com'),
('usr_009','Consultoria Prime','prime@email.com'),
('usr_010','Construtora Alfa','alfa@email.com'),
('usr_010','Construtora Beta','beta2@email.com');

INSERT INTO projects (user_id,client_id,nome,orcamento_horas,status) VALUES
('usr_001',1,'Sistema ERP',120,'em_andamento'),
('usr_001',2,'Landing Page Loja',40,'em_andamento'),
('usr_002',3,'Aplicativo Delivery',200,'planejado'),
('usr_002',4,'Sistema Financeiro',80,'em_andamento'),
('usr_003',5,'Dashboard BI',90,'em_andamento'),
('usr_003',6,'Integração API',60,'planejado'),
('usr_004',7,'Site Institucional',50,'em_andamento'),
('usr_004',8,'Portal Notícias',100,'em_andamento'),
('usr_005',9,'Sistema Clínica',120,'em_andamento'),
('usr_005',10,'Agenda Médica',70,'planejado'),
('usr_006',11,'App Restaurante',60,'em_andamento'),
('usr_006',12,'Sistema Pedidos',80,'em_andamento'),
('usr_007',13,'Controle Produção',200,'em_andamento'),
('usr_007',14,'Gestão Estoque',110,'planejado'),
('usr_008',15,'Sistema Escolar',140,'em_andamento'),
('usr_008',16,'Portal Alunos',70,'em_andamento'),
('usr_009',17,'Sistema CRM',90,'em_andamento'),
('usr_009',18,'Dashboard Vendas',60,'planejado'),
('usr_010',19,'Controle Obras',180,'em_andamento'),
('usr_010',20,'Portal Clientes',90,'em_andamento');

INSERT INTO tasks (user_id,project_id,titulo,status,estimativa_horas) VALUES
('usr_001',1,'Modelagem banco','done',8),
('usr_001',2,'Layout landing','todo',6),
('usr_002',3,'Configuração Flutter','todo',5),
('usr_002',4,'API pagamentos','em_progresso',10),
('usr_003',5,'Gráficos dashboard','em_progresso',12),
('usr_003',6,'Integração externa','todo',8),
('usr_004',7,'Design homepage','done',6),
('usr_004',8,'CMS notícias','em_progresso',10),
('usr_005',9,'Cadastro pacientes','todo',7),
('usr_005',10,'Agenda médica','todo',5),
('usr_006',11,'Tela pedidos','em_progresso',6),
('usr_006',12,'Sistema cozinha','todo',7),
('usr_007',13,'Controle produção','em_progresso',12),
('usr_007',14,'Relatório estoque','todo',6),
('usr_008',15,'Cadastro alunos','done',8),
('usr_008',16,'Portal aluno','todo',7),
('usr_009',17,'Cadastro clientes','todo',5),
('usr_009',18,'Dashboard vendas','em_progresso',9),
('usr_010',19,'Cadastro obras','todo',10),
('usr_010',20,'Portal clientes','em_progresso',8);

INSERT INTO time_entries (user_id,project_id,descricao,tags,inicio,fim,duracao_segundos) VALUES
('usr_001',1,'Modelagem inicial','["backend"]','2026-04-01 09:00','2026-04-01 11:00',7200),
('usr_001',2,'HTML landing','["frontend"]','2026-04-02 10:00','2026-04-02 12:00',7200),
('usr_002',3,'Setup Flutter','["mobile"]','2026-04-03 09:00','2026-04-03 10:30',5400),
('usr_002',4,'API pagamentos','["backend"]','2026-04-03 14:00','2026-04-03 16:00',7200),
('usr_003',5,'Dashboard','["analytics"]','2026-04-04 10:00','2026-04-04 12:00',7200),
('usr_003',6,'Integração API','["backend"]','2026-04-04 13:00','2026-04-04 15:00',7200),
('usr_004',7,'Design UI','["design"]','2026-04-05 09:00','2026-04-05 10:30',5400),
('usr_004',8,'CMS','["backend"]','2026-04-05 11:00','2026-04-05 13:00',7200),
('usr_005',9,'Cadastro pacientes','["backend"]','2026-04-06 09:00','2026-04-06 11:00',7200),
('usr_005',10,'Agenda médica','["backend"]','2026-04-06 11:00','2026-04-06 12:30',5400),
('usr_006',11,'Tela pedidos','["frontend"]','2026-04-07 09:00','2026-04-07 10:30',5400),
('usr_006',12,'Sistema cozinha','["backend"]','2026-04-07 11:00','2026-04-07 13:00',7200),
('usr_007',13,'Controle produção','["backend"]','2026-04-08 09:00','2026-04-08 12:00',10800),
('usr_007',14,'Relatório estoque','["backend"]','2026-04-08 13:00','2026-04-08 15:00',7200),
('usr_008',15,'Cadastro alunos','["backend"]','2026-04-09 09:00','2026-04-09 11:00',7200),
('usr_008',16,'Portal aluno','["frontend"]','2026-04-09 11:00','2026-04-09 12:30',5400),
('usr_009',17,'CRM clientes','["backend"]','2026-04-10 09:00','2026-04-10 11:00',7200),
('usr_009',18,'Dashboard vendas','["analytics"]','2026-04-10 13:00','2026-04-10 15:00',7200),
('usr_010',19,'Cadastro obras','["backend"]','2026-04-11 09:00','2026-04-11 11:30',9000),
('usr_010',20,'Portal clientes','["frontend"]','2026-04-11 12:00','2026-04-11 14:00',7200);

INSERT INTO invoices (user_id,client_id,mes_referencia,total_horas,valor_total,status) VALUES
('usr_001',1,'2026-04',20,2400,'pago'),
('usr_001',2,'2026-04',10,1200,'pendente'),
('usr_002',3,'2026-04',15,1200,'pendente'),
('usr_002',4,'2026-04',12,960,'pago'),
('usr_003',5,'2026-04',18,2700,'pago'),
('usr_003',6,'2026-04',9,1350,'pendente'),
('usr_004',7,'2026-04',10,900,'pago'),
('usr_005',9,'2026-04',16,1760,'pendente'),
('usr_006',11,'2026-04',14,980,'pago'),
('usr_007',13,'2026-04',25,5000,'pendente');

SELECT c.nome AS cliente, p.nome AS projeto,
SUM(te.duracao_segundos)/3600 AS horas_trabalhadas
FROM clients c
    JOIN projects p ON c.id = p.client_id
    JOIN time_entries te ON p.id = te.project_id
GROUP BY c.nome, p.nome
ORDER BY horas_trabalhadas DESC;

SELECT p.nome AS projeto, p.orcamento_horas,
SUM(te.duracao_segundos)/3600 AS horas_trabalhadas
FROM projects p
    JOIN time_entries te ON p.id = te.project_id
GROUP BY p.id, p.nome, p.orcamento_horas
HAVING horas_trabalhadas > p.orcamento_horas;

SELECT c.nome AS cliente,
SUM(i.valor_total) AS faturamento_total
FROM clients c
    JOIN invoices i ON c.id = i.client_id
GROUP BY c.id, c.nome
ORDER BY faturamento_total DESC;

SELECT u.nome AS usuario,
COUNT(te.id) AS registros_tempo,
SUM(te.duracao_segundos)/3600 AS horas_totais
FROM users u
    JOIN time_entries te ON u.id = te.user_id
    JOIN projects p ON te.project_id = p.id
GROUP BY u.id, u.nome
ORDER BY horas_totais DESC;

SELECT c.nome, c.contato
FROM clients c
WHERE EXISTS ( SELECT 1 FROM projects p WHERE p.client_id = c.id )
AND NOT EXISTS ( SELECT 1 FROM invoices i WHERE i.client_id = c.id );

SELECT u.nome AS usuario, p.nome AS projeto,
te.descricao, te.inicio, te.fim,
te.duracao_segundos/3600 AS horas
FROM time_entries te
    JOIN users u ON te.user_id = u.id
    JOIN projects p ON te.project_id = p.id
WHERE te.inicio BETWEEN '2026-04-01' AND '2026-04-30'
ORDER BY te.inicio;

WITH horas_projeto AS (
SELECT p.id, p.nome AS projeto, p.orcamento_horas,
SUM(te.duracao_segundos)/3600 AS horas_trabalhadas
FROM projects p
    JOIN time_entries te ON p.id = te.project_id
GROUP BY p.id, p.nome, p.orcamento_horas
)

SELECT projeto, orcamento_horas, horas_trabalhadas, (horas_trabalhadas - orcamento_horas) AS horas_excedidas
FROM horas_projeto
WHERE horas_trabalhadas > orcamento_horas;

SELECT c.nome AS cliente, p.nome AS projeto,
SUM(te.duracao_segundos)/3600 AS horas_trabalhadas,
RANK() OVER ( PARTITION BY c.id ORDER BY SUM(te.duracao_segundos) DESC) AS ranking_projeto
FROM clients c
    JOIN projects p ON c.id = p.client_id
    JOIN time_entries te ON p.id = te.project_id
GROUP BY c.id, c.nome, p.id, p.nome;
CREATE VIEW v_user_profiles AS
SELECT id, nome, email FROM users;

CREATE VIEW v_master_time_logs AS
SELECT te.id, te.descricao, te.inicio, te.fim, te.duracao_segundos, p.nome AS nome_projeto, c.nome AS nome_cliente FROM time_entries te
JOIN projects p ON p.id = te.project_id
JOIN clients c ON c.id = p.client_id; 

CREATE VIEW v_project_dashboard AS 
SELECT  p.id AS id_projeto, p.nome AS nome_projeto, c.nome AS nome_cliente, p.user_id, p.orcamento_horas, p.status FROM projects p 
LEFT JOIN clients c ON c.id = p.client_id

CREATE VIEW v_client_billing_summary AS
SELECT c.id, c.nome, SUM(i.total_horas) AS horas_trabalhadas, SUM(i.valor_total) AS valor_total FROM clients c
JOIN invoices i ON c.id = i.client_id
WHERE i.status = 'pago'
GROUP BY c.id, c.nome

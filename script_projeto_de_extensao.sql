CREATE TABLE
    users (
        id VARCHAR(128) PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        email VARCHAR(255) UNIQUE NOT NULL,
        plano VARCHAR(50) DEFAULT 'freemium',
        criado_em DATETIME DEFAULT CURRENT_TIMESTAMP
    );

CREATE TABLE
    clients (
        id INT AUTO_INCREMENT PRIMARY KEY,
        user_id VARCHAR(128) NOT NULL,
        nome VARCHAR(255) NOT NULL,
        contato VARCHAR(255),
        ativo BOOLEAN DEFAULT TRUE,
        FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    );

CREATE TABLE
    projects (
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

CREATE TABLE
    time_entries (
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
# SQL Fundamentals: MySQL Employees Database

Este repositório centraliza meus estudos e resoluções de problemas utilizando o banco de dados de teste `employees` do MySQL. O foco é demonstrar habilidades em manipulação de dados (DML), automação com Procedures/Functions e análises avançadas.

## 🗄️ Estrutura do Repositório

O projeto está dividido em scripts temáticos para facilitar a consulta e o aprendizado:

### 1. Procedures and Functions
* **Arquivo:** `exercises_employees_db.sql`
* **Descrição:** Automação de lógica de negócio, parâmetros de entrada/saída (IN/OUT) e estruturas de decisão (`IF/CASE`).

### 2. Advanced Queries & Analytics
* **Arquivo:** `advanced_queries_employees.sql`
* **Descrição:** Consultas complexas envolvendo:
    * **Joins Multi-tabelas:** Relacionamento entre funcionários, salários e departamentos.
    * **Subqueries:** Uso de subconsultas escalares e correlacionadas.
    * **CTEs (Common Table Expressions):** Organização de consultas temporárias para melhor legibilidade.
    * **Window Functions:** Uso de `RANK()` para criação de rankings salariais por departamento.

## 🚀 Como Executar

### Pré-requisitos
1. Ter o **MySQL Server** instalado.
2. Possuir a base de dados `employees` carregada ([Download aqui](https://github.com/datacharmer/test_db)).

### Execução
Cada script é independente. Para executar as consultas avançadas:
```bash
mysql -u seu_usuario -p employees < advanced_queries_employees.sql
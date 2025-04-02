-- Tabela enderecos
CREATE TABLE enderecos (
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(255),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    uf CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL
);

CREATE TABLE contatos (
    id SERIAL PRIMARY KEY,
    ddd VARCHAR(5),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255)
);

CREATE TABLE representantes (
    id SERIAL PRIMARY KEY,
    representante VARCHAR(255) NOT NULL,
    cargo_representante VARCHAR(100) NOT NULL
);

-- Tabela operadoras
CREATE TABLE operadoras (
    id SERIAL PRIMARY KEY,
    registro_ans VARCHAR(20) NOT NULL UNIQUE,
    cnpj VARCHAR(20) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100) NOT NULL,
    endereco_id INT NOT NULL, -- Chave estrangeira para a tabela enderecos
    contato_id INT NOT NULL, -- Chave estrangeira para a tabela contatos
    representante_id INT NOT NULL, -- Chave estrangeira para a tabela representantes
    regiao_de_comercializacao INT,
    data_registro_ans DATE NOT NULL,
    FOREIGN KEY (endereco_id) REFERENCES enderecos(id),
    FOREIGN KEY (contato_id) REFERENCES contatos(id),
    FOREIGN KEY (representante_id) REFERENCES representantes(id)
);

-- Tabela despesas
CREATE TABLE despesas (
    id SERIAL PRIMARY KEY,
    data_despesa DATE NOT NULL,
    registro_ans VARCHAR(20),
    cd_conta_contabil VARCHAR(20) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    vl_saldo_inicial NUMERIC(15, 2) NOT NULL,
    vl_saldo_final NUMERIC(15, 2) NOT NULL
    -- FOREIGN KEY (registro_ans) REFERENCES operadoras(registro_ans)
);
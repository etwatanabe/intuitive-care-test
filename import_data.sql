-- Criação de tabela temporária
CREATE TEMP TABLE temp_dados (
    registro_ans VARCHAR(20),
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(5),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao INT,
    data_registro_ans DATE
);

-- Importação dos dados do CSV para a tabela temporária
\copy temp_dados FROM 'anexos/Relatorio_cadop.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

-- Inserção dos dados nas tabelas correspondentes
-- Tabela enderecos
INSERT INTO enderecos (logradouro, numero, complemento, bairro, cidade, uf, cep)
SELECT DISTINCT logradouro, numero, complemento, bairro, cidade, uf, cep
FROM temp_dados;

-- Tabela contatos
INSERT INTO contatos (ddd, telefone, fax, endereco_eletronico)
SELECT DISTINCT ddd, telefone, fax, endereco_eletronico
FROM temp_dados;

-- Tabela representantes
INSERT INTO representantes (representante, cargo_representante)
SELECT DISTINCT representante, cargo_representante
FROM temp_dados;

-- Tabela operadoras
INSERT INTO operadoras (
    registro_ans, cnpj, razao_social, nome_fantasia, modalidade,
    endereco_id, contato_id, representante_id, regiao_de_comercializacao, data_registro_ans
)
SELECT
    t.registro_ans,
    t.cnpj,
    t.razao_social,
    t.nome_fantasia,
    t.modalidade,
    e.id AS endereco_id,
    c.id AS contato_id,
    r.id AS representante_id,
    t.regiao_de_comercializacao,
    t.data_registro_ans
FROM temp_dados t
LEFT JOIN enderecos e
    ON COALESCE(e.logradouro, '') = COALESCE(t.logradouro, '')
    AND COALESCE(e.numero, '') = COALESCE(t.numero, '')
    AND COALESCE(e.complemento, '') = COALESCE(t.complemento, '')
    AND COALESCE(e.bairro, '') = COALESCE(t.bairro, '')
    AND COALESCE(e.cidade, '') = COALESCE(t.cidade, '')
    AND COALESCE(e.uf, '') = COALESCE(t.uf, '')
    AND COALESCE(e.cep, '') = COALESCE(t.cep, '')
LEFT JOIN contatos c
    ON COALESCE(c.ddd, '') = COALESCE(t.ddd, '')
    AND COALESCE(c.telefone, '') = COALESCE(t.telefone, '')
    AND COALESCE(c.fax, '') = COALESCE(t.fax, '')
    AND COALESCE(c.endereco_eletronico, '') = COALESCE(t.endereco_eletronico, '')
LEFT JOIN representantes r
    ON COALESCE(r.representante, '') = COALESCE(t.representante, '')
    AND COALESCE(r.cargo_representante, '') = COALESCE(t.cargo_representante, '');

DROP TABLE temp_dados;

-- -- Tabela despesas
DO $$DECLARE 
    PATH TEXT := 'E:/IntuitiveCare/anexos/';  -- Defina o caminho absoluto aqui
    file_name TEXT;
BEGIN
	CREATE TEMP TABLE temp_despesas (
		data_despesa TEXT,
		registro_ans TEXT,
		cd_conta_contabil TEXT,
		descricao TEXT,
		vl_saldo_inicial TEXT,
		vl_saldo_final TEXT
	);
	
    -- Itera sobre os arquivos no diretório que seguem o padrão
    FOR file_name IN
        SELECT *
        FROM pg_ls_dir(PATH) -- Lista os arquivos no diretório
    LOOP
        IF file_name ~ '^[1-4][Tt]202[34]\.csv$' THEN
			RAISE NOTICE 'Processando arquivo: %', file_name;

            -- Importação dos dados do CSV para a tabela temporária
			EXECUTE format(
	            'COPY temp_despesas (data_despesa, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
                FROM %L
                DELIMITER %L
                CSV HEADER
                ENCODING %L',
	            PATH || file_name, ';', 'UTF8'
        	);
		END IF;
    END LOOP;
    -- Insere os dados na tabela despesas
    RAISE NOTICE 'Inserindo dados na tabela despesas';
	INSERT INTO despesas (data_despesa, registro_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
		SELECT
			data_despesa::DATE, -- Converte a string para data
			registro_ans,
			cd_conta_contabil,
			descricao,
			REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC, -- Substitui vírgula por ponto para conversão numérica
			REPLACE(vl_saldo_final, ',', '.')::NUMERIC -- Substitui vírgula por ponto para conversão numérica
		FROM temp_despesas;
        -- Existem registros de registro_ans que não constam na tabela de operadoras.
        -- Foi desconsiderada a necessidade de existência de chave estrangeira para registro_ans na tabela despesas.
        -- Para manter a integridade referencial, pode-se descomentar a parte abaixo para excluir os registros que não possuem correspondência na tabela operadoras.
		-- WHERE registro_ans IN (
		-- 	SELECT registro_ans
		-- 	FROM operadoras
		-- );
    RAISE NOTICE 'Dados inseridos com sucesso na tabela despesas';
	DROP TABLE temp_despesas;
END $$;
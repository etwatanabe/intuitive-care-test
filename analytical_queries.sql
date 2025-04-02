-- Top 10 Operadoras com Maiores Despesas no Último Trimestre
WITH ultima_data AS (
    SELECT MAX(data_despesa) AS ultima_data
    FROM despesas
),
ultimo_trimestre AS (
    SELECT 
        DATE_TRUNC('quarter', ultima_data) + INTERVAL '2 months' AS fim_trimestre,
        DATE_TRUNC('quarter', ultima_data) AS inicio_trimestre
    FROM ultima_data
)
SELECT 
    o.razao_social AS operadora,
    SUM(d.vl_saldo_inicial) - SUM(d.vl_saldo_final) AS total_despesas,
FROM despesas d
JOIN operadoras o
    ON d.registro_ans = o.registro_ans
JOIN ultimo_trimestre ut
    ON d.data_despesa BETWEEN ut.inicio_trimestre AND ut.fim_trimestre
WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY o.razao_social
ORDER BY total_despesas ASC
LIMIT 10;

-- Top 10 Operadoras com Maiores Despesas no Último Ano
WITH ultima_data AS (
    SELECT MAX(data_despesa) AS ultima_data
    FROM despesas
),
ultimo_ano AS (
    SELECT 
        DATE_TRUNC('year', ultima_data) AS inicio_ano,
        ultima_data AS fim_ano
    FROM ultima_data
)
SELECT 
    o.registro_ans AS operadora,
    SUM(d.vl_saldo_inicial) - SUM(d.vl_saldo_final) AS total_despesas
FROM despesas d
JOIN operadoras o
    ON d.registro_ans = o.registro_ans
JOIN ultimo_ano ua
    ON d.data_despesa BETWEEN ua.inicio_ano AND ua.fim_ano
WHERE d.descricao = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY o.registro_ans
ORDER BY total_despesas ASC
LIMIT 10;
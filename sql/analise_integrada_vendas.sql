
-- ==================================================
-- PROJETO: ANALISE INTEGRADA DE VENDAS
-- Objetivo: analisar 500 registros de vendas
-- Banco: analise_vendas
-- Tabela de origem: vendas_excel
-- ==================================================

USE analise_vendas;

-- 1. Validacao geral da base
SELECT
    COUNT(*) AS total_registros,
    ROUND(SUM(Valor_Total), 2) AS faturamento_total,
    ROUND(SUM(Valor_Desconto), 2) AS descontos_totais,
    SUM(Quantidade) AS unidades_vendidas
FROM vendas_excel;

-- 2. Faturamento por categoria
SELECT
    Categoria,
    COUNT(*) AS quantidade_registros,
    SUM(Quantidade) AS unidades_vendidas,
    ROUND(SUM(Valor_Total), 2) AS faturamento_total
FROM vendas_excel
GROUP BY Categoria
ORDER BY faturamento_total DESC;

-- 3. Faturamento mensal
SELECT
    DATE_FORMAT(Data, '%Y-%m') AS mes,
    COUNT(*) AS quantidade_registros,
    ROUND(SUM(Valor_Total), 2) AS faturamento_total
FROM vendas_excel
GROUP BY DATE_FORMAT(Data, '%Y-%m')
ORDER BY mes;

-- 17. Participação percentual dos produtos no faturamento

SELECT
    Produto,
    ROUND(SUM(Valor_Total), 2) AS faturamento_total,
    ROUND(
        100.0 * SUM(Valor_Total) /
        (SELECT SUM(Valor_Total) FROM vendas_excel),
        2
    ) AS percentual_faturamento
FROM vendas_excel
GROUP BY Produto
ORDER BY faturamento_total DESC;


-- 16. Ranking de produtos por faturamento
USE analise_vendas;

SELECT
    Produto,
    SUM(Quantidade) AS unidades_vendidas,
    COUNT(*) AS quantidade_vendas,
    ROUND(SUM(Valor_Total), 2) AS faturamento_total,
    RANK() OVER (
        ORDER BY SUM(Valor_Total) DESC
    ) AS ranking_faturamento
FROM vendas_excel
GROUP BY Produto
ORDER BY faturamento_total DESC;


-- 18. Evolução mensal e variacao do faturamento

USE analise_vendas;

WITH faturamento_mensal AS (
    SELECT
        DATE_FORMAT(Data, '%Y-%m') AS mes,
        SUM(Valor_Total) AS faturamento
    FROM vendas_excel
    GROUP BY DATE_FORMAT(Data, '%Y-%m')
),
comparacao AS (
    SELECT
        mes,
        faturamento,
        LAG(faturamento) OVER (ORDER BY mes) AS faturamento_mes_anterior
    FROM faturamento_mensal
)
SELECT
    mes,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(faturamento_mes_anterior, 2) AS faturamento_mes_anterior,
    ROUND(faturamento - faturamento_mes_anterior, 2) AS variacao_valor,
    ROUND(
        100.0 * (faturamento - faturamento_mes_anterior)
        / NULLIF(faturamento_mes_anterior, 0),
        2
    ) AS variacao_percentual
FROM comparacao
ORDER BY mes;


-- 19. Analise de Pareto: participacao acumulada por produto

USE analise_vendas;

WITH faturamento_produto AS (
    SELECT
        Produto,
        SUM(Valor_Total) AS faturamento
    FROM vendas_excel
    GROUP BY Produto
),
pareto AS (
    SELECT
        Produto,
        faturamento,
        SUM(faturamento) OVER (
            ORDER BY faturamento DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS faturamento_acumulado,
        SUM(faturamento) OVER () AS faturamento_total
    FROM faturamento_produto
)
SELECT
    Produto,
    ROUND(faturamento, 2) AS faturamento,
    ROUND(
        100.0 * faturamento / faturamento_total, 2
    ) AS percentual_individual,
    ROUND(
        100.0 * faturamento_acumulado / faturamento_total, 2
    ) AS percentual_acumulado,
    CASE
        WHEN faturamento_acumulado / faturamento_total <= 0.80
            THEN 'Dentro dos 80%'
        ELSE 'Após os 80%'
    END AS faixa_pareto
FROM pareto
ORDER BY faturamento DESC;
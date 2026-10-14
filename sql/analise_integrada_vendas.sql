
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
# 📊 Análise Integrada de Vendas

## Sobre o projeto

Projeto de análise de dados que utiliza Python, MySQL e SQL para explorar uma base de 500 registros de vendas, validar informações e gerar indicadores de negócio.

O objetivo é demonstrar um fluxo de trabalho que começa com a leitura dos dados, passa pela validação e análise e utiliza consultas SQL para investigar o desempenho das vendas.

## Tecnologias utilizadas

- Python
- Pandas
- MySQL
- SQL
- Visual Studio Code
- Git e GitHub

## Indicadores analisados

- Faturamento total
- Descontos totais
- Quantidade de unidades vendidas
- Faturamento por categoria
- Evolução mensal do faturamento
- Validação da consistência dos resultados

## Resultados validados

- **Registros analisados:** 500
- **Faturamento total:** R$ 817.609,69
- **Descontos totais:** R$ 32.178,31
- **Unidades vendidas:** 1.034
- **IDs de venda duplicados:** 0

Os resultados financeiros foram conferidos entre Python e MySQL.

## Estrutura do projeto

```text
analise-integrada-vendas/
├── data/
├── docs/
├── python/
│   └── analise_integrada_vendas.py
├── sql/
│   └── analise_integrada_vendas.sql
└── README.md
```

## Como executar

1. Instale Python e as dependências necessárias.
2. Disponibilize a planilha de vendas no caminho esperado pelo script Python.
3. Execute o script Python para calcular os indicadores e validar os dados.
4. Configure o MySQL e carregue a base na tabela `vendas_excel`.
5. Execute as consultas do arquivo SQL para reproduzir as análises.

## Autor

**Bruno Cunha**

Estudante de Ciência da Computação, com foco em Análise de Dados, Business Intelligence e Engenharia de Dados.
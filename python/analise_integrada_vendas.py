
import pandas as pd
from pathlib import Path

# Caminho da planilha original
arquivo = Path.home() / "Documents" / "analise-vendas-python" / "base_vendas_portfolio_python.xlsx"

# Carregar a aba de vendas
df = pd.read_excel(arquivo, sheet_name="Vendas")

# Indicadores gerais
faturamento_total = df["Valor_Total"].sum()
descontos_totais = df["Valor_Desconto"].sum()
unidades_vendidas = df["Quantidade"].sum()

print("=== VALIDACAO DA BASE DE VENDAS ===")
print(f"Quantidade de registros: {len(df)}")
print(f"Faturamento total: R$ {faturamento_total:,.2f}")
print(f"Descontos totais: R$ {descontos_totais:,.2f}")
print(f"Unidades vendidas: {unidades_vendidas}")

# Validar possíveis IDs duplicados
ids_duplicados = df["ID_Venda"].duplicated().sum()
print(f"IDs de venda duplicados: {ids_duplicados}")

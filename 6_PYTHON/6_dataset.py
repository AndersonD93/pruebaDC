import os
import pandas as pd

# Ruta actual del script
directorio_actual = os.path.dirname(os.path.abspath(__file__))


ruta_csv = os.path.join(directorio_actual, 'vgchartz-2024.csv')
dataset = pd.read_csv(ruta_csv)

# Se elimina valores nulos de las columnas pal_sales y pal_sales
dataset = dataset.dropna(subset=['pal_sales', 'jp_sales'])

dataset['avg_pal_jp_sales'] = (dataset['pal_sales'] + dataset['jp_sales']) / 2

# Guardar el DataFrame en formato Parquet
ruta_parquet = os.path.join(directorio_actual, 'dataset_resultado.parquet')
dataset.to_parquet(ruta_parquet, engine='fastparquet', index=False)

print(dataset.head())

# Confirmación de guardado exitoso
print(f"Dataset guardado en formato Parquet en: {ruta_parquet}")


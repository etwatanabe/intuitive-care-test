import pandas as pd

def load_csv(csv_path):
    """
    Carrega o arquivo CSV em um DataFrame.
    """
    df = pd.read_csv(csv_path, delimiter=';', dtype=str)
    return df

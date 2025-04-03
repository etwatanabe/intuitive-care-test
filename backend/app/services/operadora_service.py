from app.utils.csv_utils import load_csv

def search_operadoras(query, csv_path):
    """
    Busca operadoras no CSV com base no termo de consulta.
    """
    df = load_csv(csv_path)
    df.fillna('', inplace=True)
    query = query.lower()
    results = df[df.apply(lambda row: row.astype(str).str.lower().str.contains(query).any(), axis=1)]
    return results.to_dict(orient='records')
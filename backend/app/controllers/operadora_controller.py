from flask import request, jsonify
from app.services.operadora_service import search_operadoras
from app.config import Config

def search_operadoras_controller():
    """
    Controlador para a rota de busca de operadoras.
    """
    query = request.args.get('query', '').lower()
    if not query:
        return jsonify({'error': 'O parâmetro de busca "query" é obrigatório.'}), 400

    results = search_operadoras(query, Config.CSV_PATH)
    return jsonify(results)
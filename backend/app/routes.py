from flask import Blueprint
from app.controllers.operadora_controller import search_operadoras_controller

def register_routes(app):
    bp = Blueprint('routes', __name__)

    # Rota de busca
    bp.route('/search', methods=['GET'])(search_operadoras_controller)

    app.register_blueprint(bp)
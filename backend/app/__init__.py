from flask import Flask
from flask_cors import CORS
from app.routes import register_routes
from app.extensions import init_extensions

def create_app():
    app = Flask(__name__)
    CORS(app)
    
    app.config.from_object('app.config.Config')

    # Inicializar extensões
    init_extensions(app)

    # Registrar rotas
    register_routes(app)

    return app
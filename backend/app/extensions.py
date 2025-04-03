from flask_marshmallow import Marshmallow

ma = Marshmallow()

def init_extensions(app):
    ma.init_app(app)
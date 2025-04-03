import os

class Config:
    SECRET_KEY = os.getenv('SECRET_KEY', 'default_secret_key')
    CSV_PATH = os.getenv('CSV_PATH', 'app/data/Relatorio_cadop.csv')
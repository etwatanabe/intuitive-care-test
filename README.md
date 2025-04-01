# Teste de Web Scraping

Este script realiza o **web scraping** no site da [ANS](https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos) (Agência Nacional de Saúde Suplementar) para baixar os arquivos PDF dos anexos I e II relacionados ao Rol de Procedimentos e Eventos em Saúde. Após o download, os arquivos são compactados em um único arquivo ZIP.

---

## Como Usar

### 1. Requisitos
Certifique-se de ter o Python instalado em sua máquina. As bibliotecas necessárias estão listadas no arquivo `requirements.txt`:
- `requests`
- `beautifulsoup4`

### 2. Configurar o Ambiente Virtual (Opcional)
É altamente recomendado utilizar um ambiente virtual para isolar as dependências do projeto. Siga os passos abaixo:

1. Crie o ambiente virtual:
   ```bash
   python -m venv .venv
   ```
2. Ative o ambiente virtual:
    - Windows:
        ```bash
        .venv\Scripts\activate
        ```
    - Linux/Mac:
        ```bash
        source .venv/bin/activate
        ```

### 3. Instalar as dependências
```bash
pip install -r requirements.txt
```

### 4. Executar o Script
```bash
python web_scraping.py
```
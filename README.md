# Teste de Transformação de Dados

Este script realiza a extração de tabelas do [Anexo I](https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf) do site da [ANS](https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos) (Agência Nacional de Saúde Suplementar), transforma os dados (limpando e ajustando as colunas) e os salva em um arquivo CSV. Após isso, o arquivo CSV é compactado em um arquivo ZIP.

---

## Como Usar

### 1. Requisitos
Certifique-se de ter o Python instalado em sua máquina. As bibliotecas necessárias estão listadas no arquivo `requirements.txt`:
- `pandas`
- `pdfplumber`

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
python transformacao_de_dados.py
```
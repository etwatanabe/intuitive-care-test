# Sistema de Busca de Operadoras
## Descrição do Projeto
O projeto constitui uma aplicação web Single Page desenvolvida para realizar buscas e exibir informações sobre operadoras de saúde. Ele utiliza um backend em Python (Flask) para processar os dados e um frontend em Vue.js para exibir os resultados.

--- 

## Tecnologias Utilizadas
#### Frontend
- **Vue.js**: Framework JavaScript para construção de interfaces de usuário.
- **Axios**: Biblioteca para realizar requisições HTTP.
- **HTML/CSS**: Estrutura e estilização da interface.
#### Backend
- **Python**: Linguagem de programação principal.
- **Flask**: Framework web para criação de APIs.
- **Pandas**: Biblioteca para manipulação e análise de dados.
- **Flask-CORS**: Para permitir requisições entre diferentes origens.
#### Outras Ferramentas
- **Postman**: Para testar e documentar as APIs.
- **Git**: Controle de versão.
- **VS Code**: Ambiente de desenvolvimento.

--- 

## Instalação e Configuração
### Pré-requisitos
- Python 3.9+
- Node.js 16+
- npm ou yarn
- Postman (opcional, para testar a API)

### Passos para Configuração
#### 1. Clonar o Repositório
```bash
git clone https://github.com/seu-usuario/intuitivecare.git
cd intuitivecare
```
#### 2. Configurar o Backend
##### 1. Navegue até o diretório do backend:
```bash
cd backend
```
##### 2. Crie um ambiente virtual:
```bash
python -m venv .venv
```
```bash
source .venv/bin/activate # para Linux/Mac
# ou 
.venv\Scripts\activate # para Windows
```
##### 3. Instale as dependências:
```bash
pip install -r requirements.txt
```
##### 4. Execute o servidor:
```bash
flask run
```

#### 3. Configurar o Frontend
##### 1. Navegue até o diretório do backend:
```bash
cd frontend
```
##### 2. Instale as dependências:
```bash
npm install
```
##### 3. Execute o servidor de desenvolvimento:
```bash
npm run dev
```

--- 

## Como usar
1. Acesse o frontend no navegador:
```bash
http://localhost:5173
```
2. Insira um termo de busca no campo de pesquisa e clique em "Buscar".
3. Veja os resultados exibidos na tabela.

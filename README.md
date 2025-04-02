# Teste de Banco de Dados
Este projeto contém três scripts SQL que realizam a criação de tabelas, importação de dados e execução de consultas analíticas em um banco de dados PostgreSQL. O objetivo é processar e analisar dados relacionados a despesas e operadoras de saúde.

---

## Scripts
#### 1. create_tables.sql
Este script é responsável por criar as tabelas necessárias no banco de dados, incluindo suas chaves primárias e estrangeiras.

#### 2. import_data.sql
Este script realiza a importação de dados a partir de arquivos CSV para as tabelas criadas. Ele também processa os dados para garantir a consistência e integridade.

#### 3. analytical_queries.sql
Este script contém consultas analíticas para responder a perguntas específicas sobre os dados, como identificar as operadoras com maiores despesas em categorias específicas.

--- 

## Como Usar

### 1. Requisitos
Certifique-se de ter o PostgreSQL instalado e configurado em sua máquina. Além disso, é necessário ter os arquivos CSV no diretório configurado no script import_data.sql.

PS: Considera-se que um usuário, senha e um banco de dados já tenham sido criados antes de executar os scripts. 

### 2. Executar os Scripts
#### Passo 1: Criar as Tabelas
Execute o script ```create_tables.sql``` para criar as tabelas no banco de dados:
```bash
psql -U <usuario> -d <banco_de_dados> -f create_tables.sql
```

#### Passo 2: Configurar o PATH
No script ```import_data.sql``` (linha 82), configure manualmente a variável PATH para apontar para o diretório onde os arquivos CSV estão localizados. Por exemplo:
```bash
PATH TEXT := 'E:/IntuitiveCare/anexos'; -- Substitua pelo caminho do seu diretório
```

#### Passo 3: Importar os Dados
Após configurar o caminho, execute o script ```import_data.sql``` para importar os dados dos arquivos CSV para as tabelas:
```bash
psql -U <usuario> -d <banco_de_dados> -f import_data.sql
```

#### Passo 4: Executar Consultas Analíticas
```bash
psql -U <usuario> -d <banco_de_dados> -f analytical_queries.sql
```
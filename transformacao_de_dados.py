import os
import pandas as pd
import zipfile
import pdfplumber

# Configurações
FILES_PATH = os.path.join("anexos", "Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf")
OUTPUT_CSV = "Rol_de_Procedimentos.csv"
ZIP_FILENAME = "Teste_Eduardo_Takeshi_Watanabe.zip"

# Substituições para as colunas OD e AMB
SUBSTITUICOES = {
    "OD": "ODONTOLOGIA",
    "AMB": "AMBULATORIAL"
}

def extract_tables_from_pdf(pdf_path):
    """
    Extrai todas as tabelas do PDF e retorna um DataFrame combinado.
    """
    print("Extraindo tabelas do PDF...")
    all_tables = []

    with pdfplumber.open(pdf_path) as pdf:
        for page in pdf.pages:
            tables = page.extract_tables()
            if tables:
                for table in tables:
                    # Converte a tabela extraída em um DataFrame
                    df = pd.DataFrame(table[1:], columns=table[0])

                    # Remove os caracteres '\n' das colunas e das células
                    df.columns = [col.replace('\n', ' ') if isinstance(col, str) else col for col in df.columns]
                    df = df.map(lambda x: x.replace('\n', ' ') if isinstance(x, str) else x)

                    all_tables.append(df)

    if all_tables:
        return pd.concat(all_tables, ignore_index=True)
    else:
        raise ValueError("Nenhuma tabela válida foi encontrada no PDF.")

def save_to_csv(df, output_csv):
    """
    Salva o DataFrame em um arquivo CSV.
    """
    print(f"Salvando os dados no arquivo CSV: {output_csv}")
    df.to_csv(output_csv, index=False, sep=";", encoding="utf-8-sig")

def compact_csv_into_zip(csv_file, zip_filename):
    """
    Compacta um arquivo CSV em um arquivo ZIP.
    """
    print(f"Compactando o arquivo CSV em: {zip_filename}")
    with zipfile.ZipFile(zip_filename, "w") as zipf:
        zipf.write(csv_file, os.path.basename(csv_file))
    print("Compactação concluída.")

def main():
    """
    Função principal que coordena a extração, transformação e compactação dos dados.
    """
    try:
        if not os.path.exists(FILES_PATH):
            print(f"Arquivo PDF não encontrado: {FILES_PATH}")
            return

        # Extrai os dados do PDF
        df = extract_tables_from_pdf(FILES_PATH)

        # Substitui as abreviações nas colunas OD e AMB
        df = df.rename(columns=SUBSTITUICOES)

        # Salva os dados no CSV
        save_to_csv(df, OUTPUT_CSV)

        # Compacta o CSV em um arquivo ZIP
        compact_csv_into_zip(OUTPUT_CSV, ZIP_FILENAME)

        print("Processo concluído com sucesso.")
    except Exception as e:
        print(f"Erro durante o processamento: {e}")

if __name__ == "__main__":
    main()
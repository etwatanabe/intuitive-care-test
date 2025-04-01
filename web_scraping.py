import os
import requests
from bs4 import BeautifulSoup
from zipfile import ZipFile

# Configurações
URL = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"
OUTPUT_FOLDER = "anexos"
ZIP_FILENAME = "anexos_compactados.zip"
KEYWORDS = ["anexo i", "anexo ii"]

def create_output_folder(folder):
    """
    Cria o diretório de saída se não existir.
    """
    os.makedirs(folder, exist_ok=True)

def download_file(url, folder, filename):
    """
    Faz o download de um arquivo e o salva no diretório especificado.
    """
    response = requests.get(url)
    if response.status_code == 200:
        filepath = os.path.join(folder, filename)
        with open(filepath, "wb") as file:
            file.write(response.content)
        print(f"Arquivo salvo: {filepath}")
        return filepath
    else:
        print(f"Falha ao baixar o arquivo: {url}")
        return None

def scrape_and_download_pdfs(url, folder, keywords):
    """
    Faz o scraping do site e baixa os PDFs que correspondem às palavras-chave.
    """
    response = requests.get(url)
    if response.status_code != 200:
        raise Exception(f"Falha ao acessar o site: {url}")

    soup = BeautifulSoup(response.content, "html.parser")
    links = soup.find_all("a", href=True)

    pdf_files = []
    for link in links:
        href = link["href"]
        text = link.get_text().lower()

        # Verifica se o texto do link contém as palavras-chave e se o link termina com .pdf
        if any(keyword in text for keyword in keywords) and href.endswith(".pdf"):
            pdf_url = href if href.startswith("http") else f"https://www.gov.br{href}"
            filename = pdf_url.split("/")[-1]
            filepath = download_file(pdf_url, folder, filename)
            if filepath:
                pdf_files.append(filepath)

    return pdf_files

def compress_files(file_list, zip_filename):
    """
    Compacta uma lista de arquivos em um único arquivo ZIP.
    """
    if not file_list:
        print("Nenhum arquivo para compactar.")
        return

    with ZipFile(zip_filename, "w") as zipf:
        for file in file_list:
            zipf.write(file, os.path.basename(file))
    print(f"Arquivos compactados em: {zip_filename}")

def main():
    """
    Função principal que coordena o scraping e download dos PDFs, e a compactação dos arquivos.
    """
    try:
        # Cria a pasta de saída
        create_output_folder(OUTPUT_FOLDER)

        # Faz o scraping e baixa os PDFs
        print("Iniciando o scraping e download dos PDFs...")
        pdf_files = scrape_and_download_pdfs(URL, OUTPUT_FOLDER, KEYWORDS)

        # Compacta os PDFs baixados
        print("Compactando os arquivos baixados...")
        compress_files(pdf_files, ZIP_FILENAME)

        print("Processo concluído com sucesso.")
    except Exception as e:
        print(f"Erro durante o processo: {e}")

if __name__ == "__main__":
    main()
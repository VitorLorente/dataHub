# Usa a imagem oficial do Python
FROM python:3.11

# Instala pacotes necessários
RUN pip install --no-cache-dir psycopg2-binary pymongo pandas jupyter python-dotenv

# Cria um diretório de trabalho
WORKDIR /app

# Copia os arquivos para o container
COPY mainTeste.ipynb /app/

# Exposição da porta do Jupyter
EXPOSE 8888

# Comando para rodar o Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

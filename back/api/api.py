#venv\Scripts\activate
#set FLASK_APP=api.py
#flask run
from flask import Flask, request, jsonify
from flask_cors import CORS

import pyodbc as pyodbc

app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

connection = pyodbc.connect(
    Driver = 'ODBC Driver 17 for SQL Server',
    Server = 'LAPTOP-G9E3JV69',
    Database = 'Spotper',
    Trusted_Connection = 'yes'
)

cursor = connection.cursor()

@app.route('/createplaylist', methods=['GET', 'POST'])
def create_playlist():
    if request.method == 'POST':
        data = request.get_json()
        cursor.execute("INSERT INTO tb_playlists (nome, data_criacao, tempo_exec) VALUES (?, GETDATE(), NULL)", data.get('name'))
        connection.commit()

@app.route('/showalbums', methods=['GET'])
def show_albums():
        cursor.execute("SELECT descricao FROM tb_albuns")
        connection.commit()
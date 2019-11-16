#venv\Scripts\activate
#set FLASK_APP=api.py
#flask run
from flask import Flask, request, jsonify
from flask_cors import CORS

import pyodbc as pyodbc

app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})
Debug = True

connection = pyodbc.connect(
    Driver = 'ODBC Driver 17 for SQL Server',
    Server = 'LAPTOP-G9E3JV69',
    Database = 'Spotper',
    Trusted_Connection = 'yes'
)

cursor = connection.cursor()

#Criação de uma playlist
@app.route('/createplaylist', methods=['GET', 'POST'])
def create_playlist():
    if request.method == 'POST':
        data = request.get_json()
        cursor.execute("INSERT INTO tb_playlists (nome, data_criacao, tempo_exec) VALUES (?, GETDATE(), NULL)", data.get('name'))
        connection.commit()

#Mostra todos os álbuns disponíveis
@app.route('/showalbums', methods=['GET'])
def show_albums():
        album_names = []
        cursor.execute("SELECT descricao FROM tb_albuns")
        for (row) in cursor:
            album_names.append(row.descricao)
        return jsonify(album_names)

#Mostra todas as playlists disponíveis
@app.route('/showplaylists', methods=['GET'])
def show_playlists():
    playlist_names = []
    cursor.execute("SELECT nome FROM tb_playlists")
    for (row) in cursor:
        playlist_names.append(row.nome)
    return jsonify(playlist_names)

#Mostra as informações de um determinado álbum
@app.route('/showalbuminfo/<album>', methods=['GET'])
def album_page(album):
    cursor.execute("SELECT * FROM tb_albuns a, tb_gravadoras g WHERE a.cod_gravadora = g.cod_gravadora AND a.descricao=?", album)
    album_info = {
        "cod_album": "",
        "nome_album": "",
        "tipo_de_compra": "",
        "data_de_compra": "",
        "preco_de_compra": "",
        "data_de_gravacao": "",
        "nome_gravadora": ""
    }
    for (row) in cursor:
        album_info["cod_album"] = row.cod_album
        album_info["nome_album"] = row.descricao
        album_info["tipo_de_compra"] = row.tipo_de_compra
        album_info["data_de_compra"] = row.data_de_compra
        album_info["preco_de_compra"] = str(row.preco_de_compra)
        album_info["data_de_gravacao"] = row.data_de_gravacao
        album_info["nome_gravadora"] = row.nome
        break
    return jsonify(album_info)

#Mostra as informações de uma determinada playlist
@app.route('/showplaylistinfo/<playlist>', methods=['GET'])
def playlist_page(playlist):
    cursor.execute("SELECT * FROM tb_playlists WHERE nome=?", playlist)
    playlist_info = {
        "cod_playlist": "",
        "nome": "",
        "data_criacao": "",
        "tempo_exec": ""
    }
    for (row) in cursor:
        playlist_info["cod_playlist"] = row.cod_playlist
        playlist_info["nome"] = row.nome
        playlist_info["data_criacao"] = row.data_criacao
        playlist_info["tempo_exec"] = row.tempo_exec
        break
    if playlist_info["tempo_exec"] == None:
        playlist_info["tempo_exec"] = 0
    return jsonify(playlist_info)
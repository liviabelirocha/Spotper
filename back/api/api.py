# venv\Scripts\activate
# set FLASK_APP=api.py
# flask run
from flask import Flask, request, jsonify
from flask_cors import CORS

import pyodbc as pyodbc

app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})
Debug = True

connection = pyodbc.connect(
    Driver='ODBC Driver 17 for SQL Server',
    Server='LAPTOP-G9E3JV69',
    Database='Spotper',
    Trusted_Connection='yes'
)

cursor = connection.cursor()

# Criação de uma playlist
@app.route('/createplaylist', methods=['GET', 'POST'])
def create_playlist():
    if request.method == 'POST':
        data = request.get_json()
        cursor.execute(
            "INSERT INTO tb_playlists (nome, data_criacao, tempo_exec) VALUES (?, GETDATE(), NULL)", data.get('name'))
        connection.commit()

# Mostra todos os álbuns disponíveis
@app.route('/showalbums', methods=['GET'])
def show_albums():
    album_names = []
    cursor.execute("SELECT descricao, cod_album FROM tb_albuns")
    columns = [column[0] for column in cursor.description]
    for row in cursor:
        album_names.append(dict(zip(columns, row)))
    return jsonify(album_names)

# Mostra todas as playlists disponíveis
@app.route('/showplaylists', methods=['GET'])
def show_playlists():
    playlist_names = []
    cursor.execute("SELECT nome, cod_playlist FROM tb_playlists")
    columns = [column[0] for column in cursor.description]
    for row in cursor:
        playlist_names.append(dict(zip(columns, row)))
    return jsonify(playlist_names)

# Mostra as informações de um determinado álbum
@app.route('/showalbuminfo/<album>', methods=['GET'])
def album_page(album):
    cursor.execute("""SELECT * FROM tb_albuns a, tb_gravadoras g 
                    WHERE a.cod_gravadora = g.cod_gravadora AND a.cod_album=?""", album)
    album_info = {}
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

# Mostra as informações de uma determinada playlist
@app.route('/showplaylistinfo/<playlist>', methods=['GET'])
def playlist_page(playlist):
    cursor.execute("SELECT * FROM tb_playlists WHERE cod_playlist=?", playlist)
    playlist_info = {}
    for (row) in cursor:
        playlist_info["cod_playlist"] = row.cod_playlist
        playlist_info["nome"] = row.nome
        playlist_info["data_criacao"] = row.data_criacao
        playlist_info["tempo_exec"] = row.tempo_exec
        break
    if playlist_info["tempo_exec"] == None:
        playlist_info["tempo_exec"] = 0
    return jsonify(playlist_info)

# Mostra as músicas de um determinado álbum
@app.route('/showmusicsalbum/<album>', methods=['GET'])
def show_musics_album(album):
    cursor.execute("""select num_faixa, fa.descricao, c.nome as 'compositor', tempo_execucao, ti.nome as 'interprete', tcomp.descricao as 'tipo_composicao', tipo_gravacao, fb.cod_faixa
                      from tb_faixa_album fb, tb_albuns al, tb_faixas fa, tb_intepretada_por tip, tb_interpretes ti, tb_composta_por cp,tb_compositores c, tb_composicoes tcomp
                      where fa.cod_faixa = fb.cod_faixa and fb.cod_album = al.cod_album and fa.cod_faixa = tip.cod_faixa and tip.cod_interprete = ti.cod_interprete
	                  and cp.cod_faixa = fa.cod_faixa and cp.cod_compositor = c.cod_compositor and tcomp.cod_composicao = fa.cod_composicao and al.cod_album = ?""", album)
    musics = []
    columns = [column[0] for column in cursor.description]
    for row in cursor:
        musics.append(dict(zip(columns, row)))
    return jsonify(musics)

#Mostra as músicas de uma determinada playlist
@app.route('/showmusicsplaylist/<playlist>', methods=['GET'])
def show_musics_playlist(playlist):
    cursor.execute("""select f.descricao, f.tempo_execucao, a.descricao as 'album'
                      from tb_faixas_playlists fp, tb_faixas f, tb_albuns a, tb_faixa_album fa
                      where f.cod_faixa = fp.cod_faixa and f.cod_faixa = fa.cod_faixa and fp.cod_playlist = ?""", playlist)
    musics = []
    columns = [column[0] for column in cursor.description]
    for row in cursor:
        musics.append(dict(zip(columns, row)))
    return jsonify(musics)
    
# incomplete cos im lazy
@app.route('/addtoplaylist', methods=['GET', 'POST'])
def add_to_playlist():
    if request.method == 'POST':
        data = request.json()
        print(data)
        cursor.execute('INSERT INTO tb_faixas_playlists VALUES (?, ?, GETDATE(), 1)', data.get('faixa'), data.get('playlist'))
        connection.commit()

#venv\Scripts\activate
#set FLASK_APP=api.py
#flask run
from flask import Flask
from flask import request

import pyodbc
app = Flask(__name__)

connection = pyodbc.connect(
    Driver = 'ODBC Driver 17 for SQL Server',
    Server = '',
    Database = '',
    Trusted_Connection = 'yes'
)

cursor = connection.cursor()

@app.route('/createplaylist', methods=['POST'])
def create_playlist():
    name = request.form['playlistName']
    cursor.execute("INSERT INTO tb_playlists VALUES (?, GETDATE())", name)
    connection.commit()

@app.route('/showalbums', methods=['GET'])
def show_albums():
        cursor.execute("SELECT descricao FROM tb_albuns")
        connection.commit()
#venv\Scripts\activate
#set FLASK_APP=hello.py
#flask run
from flask import Flask
import pyodbc
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!'


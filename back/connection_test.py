import pyodbc

#Conexão com db de vendas
connection = pyodbc.connect(
    Driver = 'ODBC Driver 17 for SQL Server', #necessário ter instalado
    Server = '', #olhar quando iniciar o sql server
    Database = '', #nome do db
    Trusted_Connection = 'yes'
)

cursor = connection.cursor()
cursor.execute('SELECT * FROM tbClientes')

#nome das colunas
print ([column[0] for column in cursor.description])

#print dos dados
for row in cursor:
    print(row)

'''
RESULTADO
['cdCliente', 'nmCliente', 'dtNascimento', 'inSexo', 'nmEndereco', 'nmCidade', 'nmEstado', 'nmTelefone1', 'nmTelefone2']
(1, 'emo', datetime.date(2012, 3, 22), 'F', 'emo st', 'emo town', 'emo estate', '1010', '2')
(5, 'gay', datetime.date(2012, 3, 22), 'M', 'gay st', 'gay town', 'gay estate', '69696969', '420420')
'''
--Tabela backup
SELECT * INTO tbClientesBackup FROM tbClientes;

--Novas tabelas de endereco
CREATE TABLE tbEnderecos (
	cdEndereco INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nmEndereco VARCHAR(50) NOT NULL,
	nmCEP VARCHAR(9) 
)

CREATE TABLE tbCidades (
	cdCidade INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nmCidade VARCHAR(50) NOT NULL
)

CREATE TABLE tbEstados (
	cdEstado INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	nmEstado VARCHAR(30) NOT NULL,
	nmSigla VARCHAR(2) NOT NULL
)

--Constraints das tabelas
ALTER TABLE tbEnderecos
ADD CONSTRAINT fkEnderecosCidades
FOREIGN KEY (cdCidade)
REFERENCES tbCidades (cdCidade);

ALTER TABLE tbCidades
ADD CONSTRAINT fkCidadesEstados
FOREIGN KEY (cdEstado)
REFERENCES tbEstados (cdEstado);

--Tabela temporaria
CREATE TABLE #tmpEstados (
	nmEstado VARCHAR(30),
	nmSigla VARCHAR(2)
);

--Inserindo na tabela temporaria
INSERT INTO #tmpEstados (nmEstado)
SELECT DISTINCT nmEstado from tbClientesBackup;

--Update da sigla
UPDATE #tmpEstados SET nmSigla = 'ee' WHERE nmEstado = 'emo estate';
UPDATE #tmpEstados SET nmSigla = 'ge' WHERE nmEstado = 'gay estate';

select * from #tmpEstados

DROP TABLE #tmpEstados;
CREATE DATABASE db_Consultoria;

CREATE TABLE tb_Departamento(
	cod_dep BIGINT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(50) NOT NULL
);

CREATE TABLE tb_Divisao(
	cod_div BIGINT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	endereco VARCHAR(50) NOT NULL,
	departamento BIGINT NOT NULL

	CONSTRAINT fk_dep FOREIGN KEY (departamento)
		REFERENCES tb_Departamento (cod_dep)
			ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE tb_Empregados(
	matr BIGINT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	dt_lotacao DATE NOT NULL,
	dt_remocao DATE,
	lotacao BIGINT NOT NULL,
	cpf VARCHAR(20) NOT NULL,
	rg VARCHAR(20) NOT NULL,
	salario FLOAT,
	endereco VARCHAR(50) NOT NULL,
	chefe_div BIGINT,
	chefe_dep BIGINT,

	CONSTRAINT emp_unique_cpf UNIQUE NONCLUSTERED (cpf),
	CONSTRAINT emp_unique_rg UNIQUE NONCLUSTERED (rg),
	CONSTRAINT fk_emp_lotacao FOREIGN KEY(lotacao)
		REFERENCES tb_Divisao (cod_div)
			ON UPDATE CASCADE ON DELETE NO ACTION,
	CONSTRAINT fk_chefe_div FOREIGN KEY (chefe_div)
		REFERENCES tb_Divisao (cod_div)
			ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT fk_chefe_dep FOREIGN KEY (chefe_dep)
		REFERENCES tb_Departamento (cod_dep)
			ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE tb_Dependentes (
	nome VARCHAR(50) PRIMARY KEY,
	mat_resp BIGINT NOT NULL,
	mat_emp BIGINT NOT NULL,
	cpf VARCHAR(20) NOT NULL,
	rg VARCHAR(20) NOT NULL,
	dt_nasc DATE NOT NULL,

	CONSTRAINT fk_dependent FOREIGN KEY (mat_emp)
		REFERENCES tb_Empregados (matr)
			ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tb_Fone_Dep (
	departamento BIGINT NOT NULL,
	tel_um VARCHAR(20) NOT NULL,
	tel_dois VARCHAR(20),

	CONSTRAINT fk_tel_dep FOREIGN KEY (departamento)
		REFERENCES tb_Departamento (cod_dep)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT tel_dep_unique UNIQUE NONCLUSTERED (departamento)
);

CREATE TABLE tb_Fone_Div (
	divisao BIGINT NOT NULL,
	tel_um VARCHAR(20) NOT NULL,
	tel_dois VARCHAR(20),

	CONSTRAINT fk_tel_div FOREIGN KEY (divisao)
		REFERENCES tb_divisao (cod_div)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT tel_div_unique UNIQUE NONCLUSTERED (divisao)
);

CREATE TABLE tb_Vencimento (
	cod_venc BIGINT PRIMARY KEY,
	valor float NOT NULL,
	descricao VARCHAR(100) NOT NULL
);

CREATE TABLE tb_Desconto (
	cod_desc BIGINT PRIMARY KEY,
	valor float NOT NULL,
	descricao VARCHAR(100) NOT NULL
);

CREATE TABLE tb_Emp_Venc (
	empregado BIGINT NOT NULL,
	vencimento BIGINT NOT NULL,

	CONSTRAINT fk_emp_venc FOREIGN KEY (empregado)
		REFERENCES tb_Empregados (matr)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_venc_venc FOREIGN KEY (vencimento)
		REFERENCES tb_Vencimento (cod_venc)
			ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tb_Emp_Desc (
	empregado BIGINT NOT NULL,
	desconto BIGINT NOT NULL,

	CONSTRAINT fk_emp_desc FOREIGN KEY (empregado)
		REFERENCES tb_Empregados (matr)
			ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_desc_desc FOREIGN KEY (desconto)
		REFERENCES tb_Desconto (cod_desc)
			ON UPDATE CASCADE ON DELETE CASCADE
);
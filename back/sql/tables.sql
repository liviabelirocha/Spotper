CREATE TABLE tb_gravadoras (
	cod_gravadora BIGINT PRIMARY KEY IDENTITY(1,1),
	homepage VARCHAR(50) NOT NULL,
	rua VARCHAR(50) NOT NULL,
	numero VARCHAR(20) NOT NULL,
	CEP VARCHAR(20) NOT NULL,
);

/*
CREATE TABLE tb_Tel_Gravadoras(
	
); */

CREATE TABLE tb_albuns (
	cod_album BIGINT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(100) NOT NULL,
	tipo_de_compra VARCHAR(20) NOT NULL,
	data_de_compra DATE NOT NULL,
	preco_de_compra FLOAT NOT NULL,
	data_de_gravacao DATE NOT NULL,
	cod_gravadora BIGINT,

	CONSTRAINT fk_cod_gravadora FOREIGN KEY (cod_gravadora)
		REFERENCES tb_gravadoras (cod_gravadora)
			--ON UPDATE ...
);

CREATE TABLE tb_composicao (
	cod_composicao BIGINT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(100) NOT NULL
);

CREATE TABLE tb_faixas (
	cod_faixa BIGINT PRIMARY KEY NOT NULL,
	tempo_execucao FLOAT NOT NULL,
	tipo_de_gravacao VARCHAR(50),
	tipo_de_composicao BIGINT,

	CONSTRAINT fk_tipo_de_composicao FOREIGN KEY (tipo_de_composicao)
		REFERENCES tb_composicao (cod_composicao) 
);

CREATE TABLE tb_playlists (
	cod_playlist BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(100) NOT NULL,
	data_criacao DATE NOT NULL,
	tempo_exec FLOAT
);



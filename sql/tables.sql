USE Spotper;

/*
TABELAS NO SPOTPER SECUNDARIO
	-Gravadoras
	-Telefones
	-Albuns
	-Composicoes
	-Interpretes
	-Periodos
	-Compositores
*/

CREATE TABLE tb_gravadoras (
	cod_gravadora BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL,
	homepage VARCHAR(50) NOT NULL,
	rua VARCHAR(50) NOT NULL,
	numero VARCHAR(20) NOT NULL,
	CEP VARCHAR(20) NOT NULL,
) ON SpotPer_Sec;


CREATE TABLE tb_tel_gravadoras(
	telefone BIGINT PRIMARY KEY,
	cod_gravadora BIGINT,
	
	CONSTRAINT fk_cod_gravadora FOREIGN KEY (cod_gravadora) 
		REFERENCES tb_gravadoras (cod_gravadora)
) ON SpotPer_Sec;

CREATE TABLE tb_albuns (
	cod_album BIGINT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(100) NOT NULL,
	tipo_de_compra VARCHAR(8) NOT NULL,
	data_de_compra DATE NOT NULL,
	preco_de_compra DECIMAL(10,2) NOT NULL,
	data_de_gravacao DATE NOT NULL,
	cod_gravadora BIGINT NOT NULL,

	CONSTRAINT fk_cod_gravadora FOREIGN KEY (cod_gravadora)
		REFERENCES tb_gravadoras (cod_gravadora)
			ON DELETE NO ACTION
				ON UPDATE CASCADE
) ON SpotPer_Sec;

CREATE TABLE tb_composicoes (
	cod_composicao BIGINT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(100) NOT NULL
) ON SpotPer_Sec;

CREATE TABLE tb_interpretes (
	cod_interprete BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL,
	tipo VARCHAR(80) NOT NULL,
) ON SpotPer_Sec;

CREATE TABLE tb_periodos (
	cod_periodo BIGINT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(80) NOT NULL,
	intervalo_tempo BIGINT NOT NULL,
) ON SpotPer_Sec;

CREATE TABLE tb_compositores (
	cod_compositor BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50) NOT NULL,
	cidade_nascimento VARCHAR(30) NOT NULL,
	pais_nascimento VARCHAR(30) NOT NULL,
	data_nascimento DATE NOT NULL,
	data_morte DATE,
	cod_periodo BIGINT NOT NULL,

	CONSTRAINT fk_cod_periodo FOREIGN KEY (cod_periodo)
		REFERENCES tb_periodos (cod_periodo)
			ON DELETE NO ACTION
				ON UPDATE CASCADE
) ON SpotPer_Sec;

/* TABELAS DE RELACIONAMENTO - SPOTPER SECUNDARIO
	-FaixasCompositores
	-FaixasInterpretes
*/



/*
TABELAS NO SPOTPER TERCIARIO
	-Playlists
	-Faixas
*/

CREATE TABLE tb_playlists (
	cod_playlist BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(100) NOT NULL,
	data_criacao DATE NOT NULL,
	tempo_exec FLOAT NOT NULL
);

CREATE TABLE tb_faixas (
	cod_faixa BIGINT PRIMARY KEY NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	tempo_execucao FLOAT NOT NULL,
	tipo_gravacao VARCHAR(50),
	cod_composicao BIGINT NOT NULL,

	CONSTRAINT fk_cod_composicao FOREIGN KEY (cod_composicao)
		REFERENCES tb_composicoes (cod_composicao)
			ON DELETE NO ACTION
				ON UPDATE CASCADE
);

/* TABELAS DE RELACIONAMENTO - SPOTPER TERCIARIO
	-FaixasPlaylists
*/
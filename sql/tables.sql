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
				ON UPDATE CASCADE,
	CHECK(data_de_compra > '2000-01-01')
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
	-FaixasAlbum
*/

CREATE TABLE tb_composta_por(
	CONSTRAINT fk_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES tb_faixas (cod_faixa)
			ON DELETE NO ACTION
			ON UPDATE CASCADE,
	CONSTRAINT fk_cod_compositor FOREIGN KEY (cod_compositor)
		REFERENCES tb_compositores (cod_compositor)
			ON DELETE NO ACTION
			ON UPDATE CASCADE,
	PRIMARY KEY (cod_faixa, cod_compositor)
) on SpotPer_Sec;

CREATE TABLE tb_intepretada_por(
	CONSTRAINT fk_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES tb_faixas (cod_faixa)
			ON DELETE NO ACTION
			ON UPDATE CASCADE,
	CONSTRAINT fk_cod_interprete FOREIGN KEY (cod_interprete)
		REFERENCES tb_interpretes (cod_interprete)
			ON DELETE NO ACTION
			ON UPDATE CASCADE,
	PRIMARY KEY (cod_faixa, cod_interprete)
) on SpotPer_Sec;

CREATE TABLE tb_faixa_album(
	num_faixa INTEGER NOT NULL,
	CONSTRAINT fk_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES tb_faixas (cod_faixa)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	CONSTRAINT fk_cod_album FOREIGN KEY (cod_album)
		REFERENCES tb_albuns (cod_album)
			ON DELETE CASCADE
			ON UPDATE CASCADE,
	PRIMARY KEY (cod_faixa, cod_album)	
) on SpotPer_Sec;

/*
TABELAS NO SPOTPER TERCIARIO
	-Playlists
	-Faixas
*/

CREATE TABLE tb_playlists (
	cod_playlist BIGINT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(100) NOT NULL,
	data_criacao DATE NOT NULL,
	tempo_exec FLOAT
) on SpotPer_Terc;

CREATE TABLE tb_faixas (
	cod_faixa BIGINT PRIMARY KEY NOT NULL,
	descricao VARCHAR(50) NOT NULL,
	tempo_execucao FLOAT NOT NULL,
	tipo_gravacao VARCHAR(50) NOT NULL,
	cod_composicao BIGINT NOT NULL,

	CONSTRAINT fk_cod_composicao FOREIGN KEY (cod_composicao)
		REFERENCES tb_composicoes (cod_composicao)
			ON DELETE NO ACTION
				ON UPDATE CASCADE
) on SpotPer_Terc;

/* TABELAS DE RELACIONAMENTO - SPOTPER TERCIARIO
	-FaixasPlaylists
*/

CREATE TABLE tb_faixas_playlists(
	ultima_vez_tocada DATE NOT NULL,
	quantidade BIGINT NOT NULL,
	CONSTRAINT fk_cod_faixa FOREIGN KEY (cod_faixa)
		REFERENCES tb_faixas (cod_faixa)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_cod_playlist FOREIGN KEY (cod_playlist)
		REFERENCES tb_playlists (cod_playlist)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	PRIMARY KEY (cod_faixa, cod_playlist)
) on SpotPer_Terc;

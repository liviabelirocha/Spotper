CREATE NONCLUSTERED INDEX composicao_index ON tb_faixas(cod_composicao) WITH (PAD_INDEX = ON, FILLFACTOR = 100)

CREATE CLUSTERED INDEX cod_album_index ON tb_faixa_album(cod_album, cod_faixa) WITH (PAD_INDEX = ON, FILLFACTOR = 100)
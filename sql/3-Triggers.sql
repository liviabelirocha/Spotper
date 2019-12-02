CREATE TRIGGER qtdFaixas ON tb_faixa_album
FOR INSERT, UPDATE
AS
IF ( SELECT COUNT(i.cod_faixa)
FROM inserted i INNER JOIN tb_faixa_album tfb ON i.cod_album = tfb.cod_album
GROUP BY i.cod_album) > 64
BEGIN
    RAISERROR('Quantidade de Maxima de Musicas Excedida',16,1)
    ROLLBACK TRANSACTION
END
/*
CREATE TRIGGER Barroc_DDD ON tb_composta_por
FOR INSERT, UPDATE
AS
IF (SELECT f.tipo_gravacao
    FROM tb_faixas f INNER JOIN inserted i ON i.cod_faixa = f.cod_faixa
    INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = f.cod_faixa
    INNER JOIN tb_compositores tc ON tc.cod_compositor = tbcp.cod_compositor
    INNER JOIN tb_periodos tp ON tp.cod_periodo = tc.cod_periodo
    WHERE tp.descricao LIKE '%Barroco%') NOT LIKE '%DDD%'
BEGIN
    RAISERROR('Tipo de Gravação Incopativeis com Periodo', 16, 1)
    ROLLBACK TRANSACTION
END

CREATE TRIGGER Update_faixa_DDD ON tb_faixas
FOR UPDATE
AS
IF (SELECT i.tipo_gravacao
    FROM inserted i INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = i.cod_faixa
    INNER JOIN tb_compositores tc ON tc.cod_compositor = tbcp.cod_compositor
    INNER JOIN tb_periodos tp ON tp.cod_periodo = tc.cod_periodo
    WHERE tp.descricao LIKE '%Barroco%') NOT LIKE '%DDD%'
BEGIN
    RAISERROR('Tipo de Gravação Incopativeis com Periodo', 16, 1)
    ROLLBACK TRANSACTION
END
*/

/*
Trigger Valor Maximo de Album
CREATE VIEW albuns_DDD(cod_album, preco)
AS 
    SELECT DISTINCT ta.cod_album, preco_de_compra 
    FROM tb_faixas tf INNER JOIN tb_faixa_album tfa ON tf.cod_faixa = tfa.cod_faixa
        INNER JOIN tb_albuns ta ON ta.cod_album = tfa.cod_album
    WHERE NOT EXISTS (SELECT tipo_gravacao 
                        FROM tb_faixas tf2 INNER JOIN tb_faixa_album tfa ON tf2.cod_faixa = tfa.cod_faixa AND tf2.tipo_gravacao NOT LIKE '%DDD%'
                        INNER JOIN tb_albuns ta2 ON ta2.cod_album = tfa.cod_album
                        WHERE ta.cod_album = ta2.cod_album)
                        
CREATE TRIGGER album_preco_max ON tb_albuns
FOR INSERT, UPDATE
AS
IF (SELECT 3*AVG(ad.preco) FROM albuns_DDD ad) < ANY (SELECT ab.preco_de_compra FROM tb_albuns ab)  
BEGIN   
    RAISERROR('Preço do album excedeu o valor máximo', 16, 1)
    ROLLBACK TRANSACTION
END
*/
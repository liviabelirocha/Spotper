CREATE TRIGGER qtdFaixas ON tb_faixa_album
FOR INSERT, UPDATE
AS
IF ( SELECT COUNT(i.cod_faixa) FROM inserted i INNER JOIN tb_faixa_album tfb ON i.cod_album = tfb.cod_album GROUP BY i.cod_album) > 64
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
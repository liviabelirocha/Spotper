CREATE TRIGGER qtdFaixas ON tb_faixa_album
FOR INSERT, UPDATE
AS
IF ( SELECT COUNT(i.cod_faixa) FROM inserted i INNER JOIN tb_faixa_album tfb ON i.cod_album = tfb.cod_album GROUP BY i.cod_album) > 64
BEGIN
    RAISERROR('Quantidade de Maxima de Musicas Excedida',16,1)
    ROLLBACK TRANSACTION
END
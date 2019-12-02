CREATE VIEW albuns_playlist(cod_play,playlist, num_albuns)
AS
    SELECT p.cod_playlist cod, p.nome playlist, COUNT_BIG(distinct ab.cod_album) AS 'Numero de Faixas'
    FROM dbo.tb_faixas_playlists fp INNER JOIN dbo.tb_playlists p ON p.cod_playlist = fp.cod_playlist
        INNER JOIN dbo.tb_faixa_album tfa ON tfa.cod_faixa = fp.cod_faixa
        INNER JOIN dbo.tb_albuns ab ON ab.cod_album = tfa.cod_album 
    GROUP BY p.nome, p.cod_playlist
/*
CREATE VIEW v_num_albuns_playlist(cod_play,playlist, num_albuns) WITH SCHEMABINDING
AS
    SELECT p.cod_playlist cod, p.nome playlist, COUNT_BIG(*) num_albuns
    FROM dbo.tb_faixas_playlists fp INNER JOIN dbo.tb_playlists p
        ON p.cod_playlist = fp.cod_playlist
    GROUP BY p.nome, p.cod_playlist

CREATE UNIQUE CLUSTERED INDEX playlistAlbuns_index ON v_num_albuns_playlist(cod_play)
*/
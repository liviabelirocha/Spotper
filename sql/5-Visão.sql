CREATE VIEW v_num_albuns_playlist
AS
    SELECT p.nome playlist, count(*) num_albuns
    FROM tb_faixas_playlists fp INNER JOIN tb_playlists p
        ON p.cod_playlist = fp.cod_playlist
    GROUP BY p.nome

/*
CREATE VIEW v_num_albuns_playlist(cod_play,playlist, num_albuns) WITH SCHEMABINDING
AS
    SELECT p.cod_playlist cod, p.nome playlist, COUNT_BIG(*) num_albuns
    FROM dbo.tb_faixas_playlists fp INNER JOIN dbo.tb_playlists p
        ON p.cod_playlist = fp.cod_playlist
    GROUP BY p.nome, p.cod_playlist

CREATE UNIQUE CLUSTERED INDEX playlistAlbuns_index ON v_num_albuns_playlist(cod_play)
*/
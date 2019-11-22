CREATE VIEW v_num_albuns_playlist
AS
    SELECT p.nome playlist, count(*) num_albuns
    FROM tb_faixas_playlists fp INNER JOIN tb_playlists p
        ON p.cod_playlist = fp.cod_playlist
    GROUP BY p.nome
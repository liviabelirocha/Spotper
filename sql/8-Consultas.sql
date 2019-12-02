-- Item A
SELECT *
FROM tb_albuns
SELECT descricao
FROM tb_albuns
WHERE preco_de_compra > (SELECT AVG(preco_de_compra)
FROM tb_albuns)

-- item C
SELECT tc.nome, COUNT(*)
FROM tb_playlists tp LEFT OUTER JOIN tb_faixas_playlists tfp ON tp.cod_playlist = tfp.cod_playlist
    INNER JOIN tb_faixas tf ON tf.cod_faixa = tfp.cod_playlist
    INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = tf.cod_faixa
    INNER JOIN tb_compositores tc ON tc.cod_compositor = tbcp.cod_compositor
GROUP BY tc.nome
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
FROM tb_playlists tp LEFT OUTER JOIN tb_faixas_playlists tfp ON tp.cod_playlist = tfp.cod_playlist
    INNER JOIN tb_faixas tf ON tf.cod_faixa = tfp.cod_playlist
    INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = tf.cod_faixa
    INNER JOIN tb_compositores tc ON tc.cod_compositor = tbcp.cod_compositor
GROUP BY tc.nome)

-- Item B
/*
CREATE VIEW qtd_grav_play
(
    id,
    nome,
    qtd
)
AS
    SELECT tg.cod_gravadora, tg.nome, COUNT(DISTINCT tp.cod_playlist) AS 'Quantidade de Playlists'
    FROM tb_playlists tp INNER JOIN tb_faixas_playlists tfp ON tp.cod_playlist = tfp.cod_playlist
        INNER JOIN tb_faixas tf ON tf.cod_faixa = tfp.cod_faixa
        INNER JOIN tb_faixa_album tfa ON tf.cod_faixa = tfa.cod_faixa
        INNER JOIN tb_albuns ta ON ta.cod_album = tfa.cod_album
        INNER JOIN tb_gravadoras tg ON tg.cod_gravadora = ta.cod_gravadora
        INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = tf.cod_faixa
        INNER JOIN tb_compositores tc ON tc.cod_compositor = tbcp.cod_compositor
    WHERE tc.nome LIKE '%Dvorack%'
    GROUP BY tg.cod_gravadora, tg.nome

SELECT gp.nome
FROM qtd_grav_play gp
GROUP BY gp.nome, gp.qtd
HAVING gp.qtd >= ALL (SELECT MAX(gp.qtd)
FROM qtd_grav_play gp
GROUP BY gp.nome, gp.qtd)
*/

-- Item D
SELECT tp.nome, tf.descricao, tc.descricao, tps.descricao
FROM tb_playlists tp INNER JOIN tb_faixas_playlists tfp ON tp.cod_playlist = tfp.cod_playlist
    INNER JOIN tb_faixas tf ON tf.cod_faixa = tfp.cod_faixa
    INNER JOIN tb_composicoes tc ON tc.cod_composicao = tf.cod_composicao
    INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = tf.cod_faixa
    INNER JOIN tb_compositores tcps ON tcps.cod_compositor = tbcp.cod_compositor
    INNER JOIN tb_periodos tps ON tps.cod_periodo = tcps.cod_periodo
WHERE NOT EXISTS (SELECT *
FROM tb_playlists tp2 INNER JOIN tb_faixas_playlists tfp ON tp2.cod_playlist = tfp.cod_playlist
    INNER JOIN tb_faixas tf ON tf.cod_faixa = tfp.cod_faixa
    INNER JOIN tb_composicoes tc ON tc.cod_composicao = tf.cod_composicao AND tc.descricao NOT LIKE '%Concerto%'
    INNER JOIN tb_composta_por tbcp ON tbcp.cod_faixa = tf.cod_faixa
    INNER JOIN tb_compositores tcps ON tcps.cod_compositor = tbcp.cod_compositor
    INNER JOIN tb_periodos tps ON tps.cod_periodo = tcps.cod_periodo AND tps.descricao NOT LIKE '%Barroco%'
WHERE tp.cod_playlist = tp2.cod_playlist)
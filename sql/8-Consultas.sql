SELECT t_play.nome, t_f.descricao, t_c.nome, t_i.nome, t_a.descricao
FROM tb_faixas_playlists t_fplay INNER JOIN tb_playlists t_play INNER JOIN tb_faixas t_f INNER JOIN
    tb_faixa_albuns t_fa INNER JOIN tb_albuns t_a INNER JOIN tb_intepretada_por t_ip INNER JOIN
    tb_interpretes t_i INNER JOIN tb_composta_por t_cp INNER JOIN tb_compositores t_c INNER JOIN
    tb_periodos t_p INNER JOIN tb_composicoes t_c ON t_fplay.cod_playlist = t_play.cod_playlist
    ON t_fplay.cod_faixa = t_f.cod_faixa ON t_fa.cod_faixa = t_f.cod_faixa ON t_fa.cod_album = t_a.cod_album
    ON t_ip.cod_faixa = t_f.cod_faixa ON t_ip.cod_interprete = t_i.cod_interprete ON t_cp.cod_faixa = t_f.cod_faixa
    ON t_cp.cod_compositor = t_c.cod_compositor ON t_c.cod_periodo = t_p.cod_periodo ON t_c.cod_faixa = t_f.cod_faixa
GROUP BY t_play.nome, t_f.descricao,  t_c.nome,  t_i.nome,  t_a.descricao;

select num_faixa, fa.descricao, c.nome as 'compositor', tempo_execucao, ti.nome as 'interprete', tcomp.descricao as 'tipo_composicao', tipo_gravacao
from tb_faixa_album fb, tb_albuns al, tb_faixas fa, tb_intepretada_por tip, tb_interpretes ti, tb_composta_por cp, tb_compositores c, tb_composicoes tcomp
where fa.cod_faixa = fb.cod_faixa and fb.cod_album = al.cod_album and fa.cod_faixa = tip.cod_faixa and tip.cod_interprete = ti.cod_interprete
    and cp.cod_faixa = fa.cod_faixa and cp.cod_compositor = c.cod_compositor and tcomp.cod_composicao = fa.cod_composicao and al.cod_album = ?

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
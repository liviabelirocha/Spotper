SELECT t_play.nome, t_f.descricao, t_c.nome, t_i.nome, t_a.descricao
FROM tb_faixas_playlists t_fplay INNER JOIN tb_playlists t_play INNER JOIN tb_faixas t_f INNER JOIN
    tb_faixa_albuns t_fa INNER JOIN tb_albuns t_a INNER JOIN tb_intepretada_por t_ip INNER JOIN
    tb_interpretes t_i INNER JOIN tb_composta_por t_cp INNER JOIN tb_compositores t_c INNER JOIN
    tb_periodos t_p INNER JOIN tb_composicoes t_c ON t_fplay.cod_playlist = t_play.cod_playlist
    ON t_fplay.cod_faixa = t_f.cod_faixa ON t_fa.cod_faixa = t_f.cod_faixa ON t_fa.cod_album = t_a.cod_album
    ON t_ip.cod_faixa = t_f.cod_faixa ON t_ip.cod_interprete = t_i.cod_interprete ON t_cp.cod_faixa = t_f.cod_faixa
    ON t_cp.cod_compositor = t_c.cod_compositor ON t_c.cod_periodo = t_p.cod_periodo ON t_c.cod_faixa = t_f.cod_faixa
GROUP BY t_play.nome, t_f.descricao,  t_c.nome,  t_i.nome,  t_a.descricao
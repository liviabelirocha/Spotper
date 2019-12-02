CREATE FUNCTION fc_compositor_obras (@nome VARCHAR(50)) 
RETURNS TABLE AS
RETURN( SELECT DISTINCT a.cod_album, c.nome, a.descricao
FROM tb_albuns a, tb_compositores c, tb_composta_por cp, tb_faixa_album fa
WHERE nome LIKE '%'+@nome+'%'AND
    nome = c.nome AND
    c.cod_compositor = cp.cod_compositor AND
    cp.cod_faixa = fa.cod_faixa AND
    fa.cod_album = a.cod_album)
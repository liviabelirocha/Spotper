--sp para stored procedure
CREATE PROCEDURE spTotalVendasCliente( 
	@cdCliente INT --@ para variavel
) AS 

SELECT v.cdVenda, c.nmCliente, p.cdProduto, p.nmProduto, pv.qtProduto, p.vlProduto, qtProduto * vlProduto AS vlTotal, tv.qtTotalProdutos, tv.qtValorTotalVenda
FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
INNER JOIN tbClientes c ON c.cdCliente = v.cdCliente
INNER JOIN (
	SELECT v.cdVenda, SUM(pv.qtProduto) qtTotalProdutos, SUM(p.vlProduto * pv.qtProduto) qtValorTotalVenda
	FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
	INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
	GROUP BY v.cdVenda
) tv on v.cdVenda = tv.cdVenda
WHERE v.cdCliente = @cdCliente;

--chamada do procedimento
spTotalVendasCliente 5
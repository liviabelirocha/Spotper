use dbLojaEstudos;
--Soma dos valores dos produtos
SELECT * FROM tbProdutoVenda;
SELECT * FROM tbProdutos;

--Intersecao entre tbProdutos e tbProdutoVenda
SELECT p.cdProduto, pv.qtProduto, p.vlProduto
FROM tbProdutos p INNER JOIN tbProdutoVenda pv
ON p.cdProduto = pv.cdProduto;

--Intersecao entre todas as tabelas
SELECT v.cdVenda, c.nmCliente, p.cdProduto, p.nmProduto, pv.qtProduto, p.vlProduto, qtProduto * vlProduto AS vlTotal
FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
INNER JOIN tbClientes c ON c.cdCliente = v.cdCliente;

--Soma dos produtos por cliente
SELECT v.cdVenda, SUM(pv.qtProduto) qtTotalProdutos, SUM(p.vlProduto * pv.qtProduto) qtValorTotalVenda
FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
GROUP BY v.cdVenda;

--SELECT aninhado
SELECT v.cdVenda, c.nmCliente, p.cdProduto, p.nmProduto, pv.qtProduto, p.vlProduto, qtProduto * vlProduto AS vlTotal, tv.qtTotalProdutos, tv.qtValorTotalVenda
FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
INNER JOIN tbClientes c ON c.cdCliente = v.cdCliente
INNER JOIN (
	SELECT v.cdVenda, SUM(pv.qtProduto) qtTotalProdutos, SUM(p.vlProduto * pv.qtProduto) qtValorTotalVenda
	FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
	INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
	GROUP BY v.cdVenda
) tv on v.cdVenda = tv.cdVenda;
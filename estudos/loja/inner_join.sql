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
SELECT c.nmCliente, SUM(pv.qtProduto) qtTotalProdutos, SUM(p.vlProduto * pv.qtProduto) qtValorTotalVenda
FROM tbProdutos p INNER JOIN tbProdutoVenda pv ON p.cdProduto = pv.cdProduto
INNER JOIN tbVendas v ON v.cdVenda = pv.cdVenda
INNER JOIN tbClientes c ON c.cdCliente = v.cdCliente
GROUP BY c.nmCliente
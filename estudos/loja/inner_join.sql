--Soma dos valores dos produtos

SELECT * FROM tbProdutoVenda;
SELECT * FROM tbProdutos;

--Selecao dos dados com valores
SELECT p.cdProduto, pv.qtProduto, p.vlProduto
FROM tbProdutos p INNER JOIN tbProdutoVenda pv
ON p.cdProduto = pv.cdProduto;
SELECT * FROM tbClientes;
SELECT * FROM tbProdutos;
SELECT * FROM tbVendas;
SELECT * FROM tbProdutoVenda;

--Produtos
INSERT INTO tbProdutos VALUES ('dead cells', 24);
INSERT INTO tbProdutos VALUES ('darkest dungeon', 16);

--Clientes
INSERT INTO tbClientes VALUES ('emo', '2012-03-22', 'F', 'emo st', 'emo town', 'emo estate', 1010, 2);

--Vendas
INSERT INTO tbVendas VALUES (1, GETDATE());
INSERT INTO tbVendas VALUES (1, GETDATE());

--Produto <-> Venda
INSERT INTO tbProdutoVenda VALUES (5, 1, 1);
INSERT INTO tbProdutoVenda VALUES (7, 2, 1);
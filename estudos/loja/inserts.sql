SELECT * FROM tbClientes;
SELECT * FROM tbProdutos;
SELECT * FROM tbVendas;
SELECT * FROM tbProdutoVenda;

--Produtos
INSERT INTO tbProdutos VALUES ('dead cells', 24);
INSERT INTO tbProdutos VALUES ('darkest dungeon', 16);

--Clientes
INSERT INTO tbClientes VALUES ('emo', '2012-03-22', 'F', 'emo st', 'emo town', 'emo estate', 1010, 2);
INSERT INTO tbClientes VALUES ('gay', '2012-03-22', 'M', 'gay st', 'gay town', 'gay estate', 69696969, 420420);

--Vendas
INSERT INTO tbVendas VALUES (1, GETDATE());
INSERT INTO tbVendas VALUES (1, GETDATE());
INSERT INTO tbVendas VALUES (1, GETDATE());
INSERT INTO tbVendas VALUES (5, GETDATE());
INSERT INTO tbVendas VALUES (5, GETDATE());

--Produto <-> Venda
INSERT INTO tbProdutoVenda VALUES (5, 1, 1);
INSERT INTO tbProdutoVenda VALUES (7, 2, 1);
INSERT INTO tbProdutoVenda VALUES (9, 1, 3);
INSERT INTO tbProdutoVenda VALUES (10, 2, 4);

INSERT INTO tbProdutoVenda VALUES (11, 2, 4);
INSERT INTO tbProdutoVenda VALUES (11, 1, 3);
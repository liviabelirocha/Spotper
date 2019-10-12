--Criando as tabelas

--Produtos
CREATE TABLE tbProdutos(
	cdProduto INT PRIMARY KEY IDENTITY(1,1), --Comeca com 1 e aumenta de 1 em 1
	nmProduto VARCHAR(50) NOT NULL, --Obrigatorio
	vlProduto DECIMAL(6,2) NOT NULL --6 digitos antes da virgula, 2 digitos depois da virgula, no maximo
);

--Clientes
CREATE TABLE tbClientes(
	cdCliente INT PRIMARY KEY IDENTITY(1,1),
	nmCliente VARCHAR(50) NOT NULL,
	dtNascimento DATE,
	inSexo VARCHAR(1) NOT NULL,
	nmEndereco VARCHAR(50),
	nmCidade VARCHAR(50),
	nmEstado VARCHAR(30),
	nmTelefone1 VARCHAR(15),
	nmTelefone2 VARCHAR(15)
);

--Vendas
--Codigo 1
CREATE TABLE tbVendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdProduto INT NOT NULL,
	vlProduto DECIMAL (6,2) NOT NULL
);

--Codigo refatorado
CREATE TABLE tbVendas(
	cdVenda INT PRIMARY KEY IDENTITY(1,1),
	cdCliente INT NOT NULL FOREIGN KEY REFERENCES tbClientes (cdCliente),
	dtVenda DATETIME NOT NULL
);

--Tabela de relacionamento Produto<->Venda
CREATE TABLE tbProdutoVenda(
	cdProdutoVenda INT PRIMARY KEY IDENTITY(1,1),
	cdVenda INT FOREIGN KEY REFERENCES tbVendas (cdVenda) NOT NULL,
	cdProduto INT FOREIGN KEY REFERENCES tbProdutos (cdProduto) NOT NULL,
	qtProduto INT NOT NULL
);

--Constraint
--Referente ao codigo de vendas 1
ALTER TABLE tbVendas
ADD CONSTRAINT fkProdutoVendas 
FOREIGN KEY(cdProduto)
REFERENCES tbProdutos (cdProduto);

--Remover tabela
DROP TABLE tbVendas;
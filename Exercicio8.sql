 -- Construção básica do Script
CREATE DATABASE BomGosto;

CREATE TABLE Comanda(
	id_comanda SERIAL PRIMARY KEY,
	data DATE NOT NULL,
	numero_mesa INT NOT NULL,
	nome_cliente VARCHAR(100) NOT NULL
);

CREATE TABLE Cardapio(
	id_cardapio SERIAL PRIMARY KEY,
	nome_item VARCHAR(100) UNIQUE NOT NULL,
	descricao TEXT,
	preco_unitario DECIMAL (10, 2) NOT NULL
);

CREATE TABLE Item_Comanda (
	id_item_comanda SERIAL PRIMARY KEY,
	quantidade INT NOT NULL,
	id_comanda INT NOT NULL,
	id_cardapio INT NOT NULL,
	FOREIGN KEY(id_comanda) REFERENCES Comanda(id_comanda) ON DELETE CASCADE,
	FOREIGN KEY(id_cardapio) REFERENCES Cardapio(id_cardapio) ON DELETE CASCADE
);

INSERT INTO Comanda (data, numero_mesa, nome_cliente) VALUES
('2025-10-16', 1, 'Antonio Bruno'),
('2025-10-15', 2, 'Raiana'),
('2025-10-16', 3, 'Jackeline'),
('2025-10-17', 4, 'Felipe'),
('2025-10-17', 5, 'Jaques');

INSERT INTO Cardapio (nome_item, descricao, preco_unitario) VALUES
('Latte', 'Café espresso com bastante leite vaporizado e uma fina camada de espuma', 8.50),
('Pão de Queijo', 'Porção com 5 unidades de pão de queijo', 7.00),
('Cappuccino Tradicional', 'Mistura equilibrada de café, leite vaporizado e espuma de leite', 9.00),
('Mocha', 'Café com leite, calda de chocolate e chantilly', 10.00),
('Café Expresso', 'Café curto e encorpado feito sob pressão', 6.50);



INSERT INTO Item_Comanda (quantidade, id_comanda, id_cardapio) VALUES
(2, 1, 1),
(1, 1, 4),
(1, 2, 2),
(2, 3, 3),
(1, 3, 5),
(1, 4, 1),
(1, 4, 3),
(1, 5, 2),
(1, 5, 4),
(2, 5, 5);

SELECT * FROM Comanda;
SELECT * FROM Cardapio;
SELECT * FROM Item_Comanda;

 -- Inicio dos deveres:
 -- Execicio 1
SELECT * from Cardapio ORDER BY nome_item;

 -- Execicio 2
SELECT c.data, c.id_comanda, c.numero_mesa, c.nome_cliente, ca.nome_item, ca.descricao, ic.quantidade, ca.preco_unitario, (ic.quantidade * ca.preco_unitario) as preco_total FROM Comanda c JOIN Item_Comanda ic ON c.id_comanda = ic.id_comanda JOIN Cardapio ca ON ic.id_cardapio = ca.id_cardapio ORDER BY c.data, c.id_comanda, ca.nome_item;

 -- Execicio 3
SELECT c.id_comanda, c.data, c.numero_mesa, c.nome_cliente, SUM(ic.quantidade * ca.preco_unitario) as preco_total_comanda FROM Comanda c JOIN Item_Comanda ic ON c.id_comanda = ic.id_comanda JOIN Cardapio ca ON ic.id_cardapio = ca.id_cardapio GROUP BY c.id_comanda ORDER BY c.data;

 -- Execicio 4
SELECT c.id_comanda, c.data, c.numero_mesa, c.nome_cliente, SUM(ic.quantidade * ca.preco_unitario) as preco_total_comanda FROM Comanda c JOIN Item_Comanda ic ON c.id_comanda = ic.id_comanda JOIN Cardapio ca ON ic.id_cardapio = ca.id_cardapio GROUP BY c.id_comanda HAVING count(DISTINCT ca.id_cardapio) > 1 ORDER BY c.data;

 -- Execicio 5
SELECT c.data, SUM(ic.quantidade * ca.preco_unitario) as preco_total_comanda FROM Comanda c JOIN Item_Comanda ic ON c.id_comanda = ic.id_comanda JOIN Cardapio ca ON ic.id_cardapio = ca.id_cardapio GROUP BY c.data ORDER BY c.data;

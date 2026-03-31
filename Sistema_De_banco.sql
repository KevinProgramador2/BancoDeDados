create table categoria(
id_categoria serial primary key,
nome varchar(100) not null,
descricao text 

);

insert into categoria (nome, descricao)
VALUES('Laticínios', 'Produtos derivados do leite'),
	  ('Bebidas', 'Produtos liquídos para consumo'),
	  ('Hortifruti', 'Hortalícias, frutas e vegetais'),
	  ('Limpeza', 'Produtos de higiene pessoal e domicílios');


create table produto (
id_produto serial primary key,
nome varchar(100) unique not null,
descricao text,
unidade varchar(5),
id_categoria INT not null,

constraint fk_produto_categoria
	foreign key (id_categoria)
	references categoria(id_categoria)
	on delete restrict 
	on update cascade
	);


insert into produto (nome, descricao, unidade, id_categoria)
values 	

		--Laticínios
		('Queijo Minas', 'Queijo tradicional', 'Kg', 1 ),
		('Iogurte', 'Iogurte desnatado', 'L', 1 ),
		('Manteiga', 'Manteiga com sal', 'Kg', 1 ),
		('Requeijão', 'Requeijão tradicional', 'Kg', 1 ),
		
		--BEBIDAS
		('Vodka', 'Bebida alcoólica', 'L', 2 ),
		('Refrigerante', 'Bebida gaseificada', 'L', 2 ),
		('Suco de caixa', 'Suco de uva natural', 'Cx', 2 ),
		('Energético', 'Bebida com taurina e cafeina', 'L', 2 ),
	
		--Hortifruti
		('Pera', 'Pera Williams', 'Kg', 3 ),
		('Alface', 'Alface americano ', 'Un', 3 ),
		('Brócolis', 'Brócolis americano', 'Un', 3 ),
		('Batata', 'Batata lavada', 'Kg', 3 ),
		
		--Limpeza
		('Papel higiênico', 'Folha tripla', 'Pct', 4 ),
		('Detergente', 'Detergente neutro' , 'Un', 4 ),
		('Saco de lixo', 'Saco de lixo 30 litros', 'Un', 4 ),
		('Cloro', '99,9% bactericida', 'L', 4 );
		
		select * from produto;
		
		
create table estoque (
id_estoque serial primary key,
id_produto INT not null,
quantidade INT check (quantidade >= 0 ) not null,
estoque_minimo INT not null,
ultima_atualizacao timestamp not null default current_timestamp,

constraint fk_estoque_produto
	foreign key (id_produto)
	references produto(id_produto)
	on delete restrict
	on update cascade
);


--Inserção miníma de quantidade 
insert into estoque (quantidade, estoque_minimo,id_produto)
	 values (9, 10, 1),
			(10, 10, 2),
			(23, 10, 3),
			(26, 10, 4),
			(65, 10, 5),
			(43, 10, 6),
			(52, 10, 7),
			(31, 10, 8),
			(23, 10, 9),
			(15, 10, 10),
			(46, 10, 11),
			(10, 10, 12),
			(94, 10, 13),
			(66, 10, 14),
			(6, 10, 15),
			(3, 10, 16);

update estoque
set estoque_minimo = 10
where id_produto = 1;

select * from estoque;

create table historico_preco(
id_historico serial primary key,
id_produto int not null,
preco decimal(10,2),
data_inicio timestamp not null default current_timestamp,
motivo text,


constraint fk_historico_preco_produto
	foreign key (id_produto)
	references produto(id_produto)
	on delete restrict
	on update cascade

);


insert into historico_preco (preco, data_inicio, id_produto)
	values	

			-- LATICÍNIOS
	-- Produto 1: Queijo Minas (Kg)
	(45.90, '2026-02-27', 1), -- Preço antigo (Fevereiro)
	(48.50, '2026-03-27', 1), -- Preço atual (Março)
    
    -- Produto 2: Iogurte (L)
	(12.50, '2026-02-27', 2),
	(14.00, '2026-03-27', 2),
    
    -- Produto 3: Manteiga (Kg)
	(55.00, '2026-02-27', 3),
	(58.90, '2026-03-27', 3),
    
	-- Produto 4: Requeijão (Kg)
	(42.00, '2026-02-27', 4),
	(45.50, '2026-03-27', 4),

	-- BEBIDAS
	-- Produto 5: Vodka (L)
	(39.90, '2026-02-27', 5),
	(42.90, '2026-03-27', 5),
    
	-- Produto 6: Refrigerante (L)
	(8.50, '2026-02-27', 6),
	(9.00, '2026-03-27', 6),
    
	-- Produto 7: Suco de caixa (Cx)
	(6.50, '2026-02-27', 7),
	(7.20, '2026-03-27', 7),
    
	-- Produto 8: Energético (L)
	(15.90, '2026-02-27', 8),
	(17.50, '2026-03-27', 8),

	-- HORTIFRUTI
	-- Produto 9: Pera (Kg)
	(11.90, '2026-02-27', 9),
	(13.50, '2026-03-27', 9),
    
	-- Produto 10: Alface (Un)
	(3.50, '2026-02-27', 10),
	(4.50, '2026-03-27', 10),
    
	-- Produto 11: Brócolis (Un)
	(6.90, '2026-02-27', 11),
	(8.00, '2026-03-27', 11),
    
	-- Produto 12: Batata (Kg)
	(5.50, '2026-02-27', 12),
	(7.90, '2026-03-27', 12),

	-- LIMPEZA
	-- Produto 13: Papel higiênico (Pct)
	(18.90, '2026-02-27', 13),
	(21.50, '2026-03-27', 13),
    
	-- Produto 14: Detergente (Un)
	(2.50, '2026-02-27', 14),
	(2.80, '2026-03-27', 14),
    
	-- Produto 15: Saco de lixo (Un/Pct)
	(12.00, '2026-02-27', 15),
	(14.50, '2026-03-27', 15),
    
	-- Produto 16: Cloro (L)
	(4.50, '2026-02-27', 16),
	(5.20, '2026-03-27', 16);
				
			select * from historico_preco;


create table venda(
id_venda serial primary key,
data_venda timestamp not null default current_timestamp,
cliente varchar(150) default null,
total decimal(10,2)


);


insert into venda (cliente, data_venda, total, id_venda)
values
			('Cliente 1', '2026-03-27', 95.30, 1), -- 2x Iogurte (2 * 14.00 = 28.00) + 1x Manteiga
			('Cliente 2', '2026-03-27', 77.90, 2), -- 1x Vodka (42.90) + 2x Energético
			('Cliente 3', '2026-02-27', 152.00, 3), --1x Queijo Minas (48.50) + 2x Requeijão
			('Cliente 4', '2026-03-27', 106.40, 4), --3x Batata (3 * 7.90 = 23.70) + 2x Pera
			('Cliente 5', '2026-02-27', 85.60, 5), -- 4x Refrigerante (4 * 9.00 = 36.00) + 3x Suco
			('Cliente 6', '2026-03-27', 80.40, 6), -- 1x Manteiga (58.90) + 1x Papel higiênico
			('Cliente 7', '2026-02-27', 135.90, 7), -- 2x Queijo Minas (2 * 48.50 = 97.00) + 5x Detergente
			('Cliente 8', '2026-02-27', 67.70, 8), -- 1x Vodka (42.90) + 1x Refrigerante (9.00) + 2x Batata
			('Cliente 9', '2026-03-27', 103.50, 9), -- 1x Requeijão (45.50) + 1x Iogurte (14.00) + 2x Alface
			('Cliente 10', '2026-03-27', 105.10, 10); -- 2x Energético (2 * 17.50 = 35.00) + 3x Suco
    
    
			select * from venda;
			

create table item_venda(
id_item_venda serial primary key,
id_venda int not null,
id_produto int not null,
quantidade int not null,
preco_unitario decimal (10,2) not null,
subtotal decimal (10,2) not null ,

--Item da venda
constraint fk_item_venda_venda 
	foreign key (id_venda)
	references venda(id_venda)
	on delete restrict
	on update cascade,

--Item do produto	
constraint fk_item_venda_produto
	foreign key (id_produto)
	references produto(id_produto)
	on delete restrict
	on update cascade
);


INSERT INTO item_venda (id_venda, id_produto, quantidade, preco_unitario, subtotal)
values 
				-- VENDA 1 (Total na tabela venda: 86.90)
	(1, 2, 2, 14.00, 28.00),	-- 2x Iogurte (id 2)
	(1, 3, 1, 58.90, 58.90),	-- 1x Manteiga (id 3)
								-- Prova: 28.00 + 58.90 = 86.90
    
	-- VENDA 2 (Total na tabela venda: 77.90)
	(2, 5, 1, 42.90, 42.90),	-- 1x Vodka (id 5)
	(2, 8, 2, 17.50, 35.00),	-- 2x Energético (id 8)
								-- Prova: 42.90 + 35.00 = 77.90

	-- VENDA 3 (Total na tabela venda: 139.50)
	(3, 1, 1, 48.50, 48.50),	-- 1x Queijo Minas (id 1)
	(3, 4, 2, 45.50, 91.00),	-- 2x Requeijão (id 4)
								-- Prova: 48.50 + 91.00 = 139.50

	-- VENDA 4 (Total na tabela venda: 50.70)
	(4, 12, 3, 7.90, 23.70),	-- 3x Batata (id 12)
	(4, 9, 2, 13.50, 27.00),	-- 2x Pera (id 9)
								-- Prova: 23.70 + 27.00 = 50.70

	-- VENDA 5 (Total na tabela venda: 57.60)
	(5, 6, 4, 9.00, 36.00),	-- 4x Refrigerante (id 6)
	(5, 7, 3, 7.20, 21.60),	-- 3x Suco (id 7)
							-- Prova: 36.00 + 21.60 = 57.60

	-- VENDA 6 (Total na tabela venda: 80.40)
	(6, 3, 1, 58.90, 58.90),	-- 1x Manteiga (id 3)
	(6, 13, 1, 21.50, 21.50),	-- 1x Papel higiênico (id 13)
								-- Prova: 58.90 + 21.50 = 80.40

	-- VENDA 7 (Total na tabela venda: 111.00)
	(7, 1, 2, 48.50, 97.00), 	-- 2x Queijo Minas (id 1)
	(7, 14, 5, 2.80, 14.00), 	-- 5x Detergente (id 14)
								-- Prova: 97.00 + 14.00 = 111.00

	-- VENDA 8 (Total na tabela venda: 67.70)
	(8, 5, 1, 42.90, 42.90),	-- 1x Vodka (id 5)
	(8, 6, 1, 9.00, 9.00),		-- 1x Refrigerante (id 6)
	(8, 12, 2, 7.90, 15.80),	-- 2x Batata (id 12)
								-- Prova: 42.90 + 9.00 + 15.80 = 67.70

	-- VENDA 9 (Total na tabela venda: 68.50)
	(9, 4, 1, 45.50, 45.50),	-- 1x Requeijão (id 4)
	(9, 2, 1, 14.00, 14.00),	-- 1x Iogurte (id 2)
	(9, 10, 2, 4.50, 9.00),		-- 2x Alface (id 10)
								-- Prova: 45.50 + 14.00 + 9.00 = 68.50

	-- VENDA 10 (Total na tabela venda: 56.60)
	(10, 8, 2, 17.50, 35.00),	-- 2x Energético (id 8)
	(10, 7, 3, 7.20, 21.60);	-- 3x Suco (id 7)
                           		-- Prova: 35.00 + 21.60 = 56.60
    
	select * from item_venda;
    
    
    
	
	-- Aqui vamos pegar da coluna produto e vai mostrar todos os produtos mesmo não tendo a categoria.
	
    select 
    c.nome as "Categoria do produto", p.nome as "Nome do produto"
    from produto p
    left join categoria  c on c.id_categoria = p.id_categoria
    order by c.nome asc,
    p.nome asc;
    
    
    --Vai mostrar todos os produtos mesmos aqueles que não estão em estoque.
    
    select
    p.nome as nome_produto,
    e.quantidade as quantidade_estoque,
    e.estoque_minimo as estoque_minimo
	from produto p
	left join estoque e on e.id_produto = p.id_produto
	order by e.quantidade asc;
    
    
-- Lista todo o histórico de preços com nome do produto, ordenando por produto e pela data mais recente primeiro

select p.nome as "Nome de produto",
				hp.preco as "Preço",
				hp.data_inicio as "Data Início",
				hp.motivo as "Motivo"
from historico_preco hp
join produto p on hp.id_produto = p.id_produto
order by p.nome asc, hp.data_inicio desc;


-- Mostra o preço atual de cada produto (registro mais recente do histórico)

select p.nome as "Nome do produto",
	hp.preco as "Preço atual",
	hp.data_inicio as "Data vigencia"
from produto p
join historico_preco hp on hp.id_produto = p.id_produto
where hp.data_inicio = (
	select max(hp2.data_inicio)
	from historico_preco hp2
	where hp2.id_produto = p.id_produto)
order by p.nome asc;


-- Mostra o total de cada venda com data, cliente e quantidade de itens diferentes

select v.data_venda as "Data venda",
		v.id_venda as "Código de venda",
		v.cliente as "Cliente",
	sum(iv.subtotal) as "total_venda",
	count(distinct iv.id_produto) as "Quantidade de itens"
from venda v
join item_venda iv
    on iv.id_venda = v.id_venda
group by
	v.id_venda,
	v.data_venda,
	v.cliente
order by
	v.data_venda desc;





--C6 Produto Mais Vendido

 
select 	p.nome as "Nome do produto",
		c.nome as "Categoria",
		sum(iv.quantidade) as "Total de quantidade vendidas"
from item_venda iv
join produto p
	on p.id_produto = iv.id_item_venda
join categoria c
	on c.id_categoria = p.id_categoria 
	group by 
	p.nome, 
	c.nome
	order by "Total de quantidade vendidas" desc 
	limit 5;




 --C7 Produtos com Estoque Crítico



--Nome do produto definido pelo quantidade o estoque minímo com o preço atual.

select p.nome as "Nome do produto",
e.quantidade as "Quantidade atual",
e.estoque_minimo as "Estoque minímo",
hp.preco as "Preco atual"
from produto p
join estoque e on e.id_produto = p.id_produto
join historico_preco hp on hp.id_produto = p.id_produto
where e.quantidade < e.estoque_minimo and hp.data_inicio = (
	select max (hp2.data_inicio)
	from historico_preco hp2
	where hp2.id_produto = hp.id_produto
	
)
order by e.quantidade asc;



 --Faturamento Total por Categoria

select 
c.nome as "categoria",
sum(iv.subtotal) as "Faturamento_total",
sum(iv.quantidade) as "total_itens_vendidos"
from categoria c 
join produto p on p.id_categoria = c.id_categoria 
join item_venda iv on iv.id_produto =  p.id_produto
group by 
c.nome 
order by "Faturamento_total" desc;



--1  Consulta SELECT que identifica os produtos com estoque < 10

select
	p.nome as "Nome do Produto",
	e.quantidade as "Quantidade em estoque",
	hp.preco as "Preço atual"
from produto p
join estoque e
	on e.id_produto = p.id_produto
join historico_preco hp
	on hp.id_produto = p.id_produto
where 
	e.quantidade < 10
	and hp.data_inicio = (
		select max(hp2.data_inicio)
		from historico_preco hp2
		where hp2.id_produto = hp.id_produto
    )
order by
    e.quantidade asc;

--2. Consulta SELECT mostrando o novo preço calculado (antes de inserir)

select
	p.nome as "Nome produto",
	e.quantidade as "Quantidade em estoque",
	hp.preco as "Preco atual",
	hp.preco * 1.15 as "Novo preco"
from produto p
join estoque e
	on e.id_produto = p.id_produto
join historico_preco hp
	on hp.id_produto = p.id_produto
where 
	e.quantidade < 10
	and hp.data_inicio = (
		select max(hp2.data_inicio)
		from historico_preco hp2
		where hp2.id_produto = hp.id_produto
	)
order by
	e.quantidade asc;

--3. Comandos INSERT no HISTORICO_PRECO para os produtos afetados

insert into historico_preco (id_produto, preco, data_inicio, motivo)
select
	e.id_produto,
	hp.preco * 1.15 as novo_preco,
	current_timestamp as data_inicio,
	 'Ajuste automático: estoque crítico (< 10 unidades)' 
from estoque e
join historico_preco hp
	on hp.id_produto = e.id_produto
where 
	e.quantidade < 10
	and hp.data_inicio = (
		select max(hp2.data_inicio)
		from historico_preco hp2
		where hp2.id_produto = hp.id_produto
    );


select * from historico_preco;


--4. Consultas de validação C4 e C7 executadas após as inserções
 


select p.nome as "Nome do produto",
	hp.preco as "Preço atual",
	hp.data_inicio as "Data vigencia"
from produto p
join historico_preco hp on hp.id_produto = p.id_produto
where hp.data_inicio = (
	select max(hp2.data_inicio)
	from historico_preco hp2
	where hp2.id_produto = p.id_produto)
order by p.nome asc;


select p.nome as "Nome do produto",
e.quantidade as "Quantidade atual",
e.estoque_minimo as "Estoque minímo",
hp.preco as "Preco atual"
from produto p
join estoque e on e.id_produto = p.id_produto
join historico_preco hp on hp.id_produto = p.id_produto
where e.quantidade < e.estoque_minimo and hp.data_inicio = (
	select max (hp2.data_inicio)
	from historico_preco hp2
	where hp2.id_produto = hp.id_produto
	
)
order by e.quantidade asc;



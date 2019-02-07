


-- Criação de Bnco de dado 
create database  db_DesafioPartnerGroup;

-- Criação de tableas 
create table Marca(
	Nome varchar(20) not null,
	MarcaId int identity(1,1) primary key not null);

create table Patrimonio(
	Nome varchar(20) not null,
	MarcaId int,
	Descricao varchar(50),
	N_Tombo int identity(1,1) primary key(N_Tombo) not null ,
	foreign key (MarcaId) references Marca(MarcaId));

--- ****  do Desafio 

  -- GET patrimonios 
select * from Patrimonio;
 
 -- GET patrimonios (id)
select Nome from  Patrimonio
	where N_Tombo = 1;

-- POST patrimonios
insert into Patrimonio (Nome,MarcaId,Descricao) values('Liquido',1,'Proprietario do 40% da açoes');
insert into Patrimonio (Nome,MarcaId,Descricao) values('Fisico',2,'Proprietario do escritorio');

-- PUT patrimonios/{id}
update Patrimonio
	set Nome = 'Intelectual'
	where N_Tombo = 2;

-- DELETE patrimonios/{id}
delete from Patrimonio
	where N_Tombo = 1;

-- GET marcas
select * from Marca;

-- GET marcas (id)
select Nome from  Marca
	where MarcaId = 2;

-- POST patrimonios
insert into Marca (Nome) values('TecM-Soluction');
insert into Marca (Nome) values('PartenGroup');

-- PUT marcas/{id}
update Marca 
	set Nome = 'Apple'
	where MarcaID = 1;

-- DELETE marcas/{id}
delete from Marca
	where MarcaId = 2;

-- Consulta geral inner join
select * from Patrimonio p
	inner join  Marca c
	on p.MarcaId = c.MarcaId;



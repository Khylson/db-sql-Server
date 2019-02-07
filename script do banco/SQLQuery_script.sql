-- Ezequiel Manuel Muxito --
-- este script é uma prova 

-- script do banco de dados 
create database db_Gerencia;

use db_Gerencia;

-- criação de tabelas 

-- tabela Banco 
create table tb_Banco(
	Id_banco int identity (1,1) primary key not null,
	Nome varchar(20) not null
);

create table tb_Agencia(
	Id_agencia int identity (1,1) primary key not null,
	Numero_agencia varchar (20) not null,
	Nome_agencia varchar(20) not null,
	Id_banco int foreign key (Id_banco) references tb_Banco(Id_banco)
);

create table tb_Cliente(
	Id_cliente int identity (1,1) primary key not null,
	Nome_cliente varchar (20) not null
);

create table tb_tipo_Conta(
	tipo_conta int identity (1,1) primary key not null,
	Nome_conta varchar(20) not null
);

create table tb_Conta(
	Id_conta int identity (1,1) primary key not null,
	Numero_conta varchar(20) not null,
	Id_cliente int foreign key (Id_cliente) references tb_Cliente (Id_cliente),
	Id_agencia int foreign key (Id_agencia) references tb_Agencia (Id_agencia),
	Saldo_conta float not null,
	tipo_conta int foreign key (tipo_conta) references tb_tipo_Conta (tipo_conta)
);

-- Inserir dados nas tabelas
 
 -- tabela tb_Banco 
 insert into tb_Banco (Nome) values ('Santander');
 insert into tb_Banco (Nome) values ('Bradesco');

-- consultas - select 
 select * from tb_Banco;

 -- tabela tb_Agencia
insert into tb_Agencia (Numero_agencia, Nome_agencia, Id_banco) values ('23454-5','Otavio Machado',1);
insert into tb_Agencia (Numero_agencia, Nome_agencia, Id_banco) values ('43267-6','Americo',1);
insert into tb_Agencia (Numero_agencia, Nome_agencia, Id_banco) values ('54365-7','Santo Amaro',3);
insert into tb_Agencia (Numero_agencia, Nome_agencia, Id_banco) values ('98745-4','Alexandre Dumas',3);
insert into tb_Agencia (Numero_agencia, Nome_agencia, Id_banco) values ('65473-9','Adolfo',3);

-- consultas - select 
 select * from tb_Agencia;

 -- tabela tb_Cliente 

insert into tb_Cliente (Nome_cliente) values ('Ezequiel Muxito');
insert into tb_Cliente (Nome_cliente) values ('Americo dos Santos');
insert into tb_Cliente (Nome_cliente) values ('Bruno Pedro');
insert into tb_Cliente (Nome_cliente) values ('Constancia Manuel');
insert into tb_Cliente (Nome_cliente) values ('Helder Pedro');
insert into tb_Cliente (Nome_cliente) values ('Elzia Ezequiel');

-- consultas - select 
select * from tb_Cliente;

 -- tabela tb_tipo_Conta 
insert into tb_tipo_Conta (Nome_conta) values ('Conta Corrente');
insert into tb_tipo_Conta (Nome_conta) values ('Conta Poupança');

-- consultas - select 
select * from tb_tipo_Conta;

 -- tabela tb_Conta 
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('2345423-23',1,2,500,1);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('1122344-33',2,1,90000,2);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('1122344-33',2,1,752.23,1);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('8798484-45',3,5,8423.45,1);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('4235344-56',4,4,6522.45,1);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('4587451-22',5,2,2874.56,2);
insert into tb_Conta (Numero_conta,Id_cliente,Id_agencia,Saldo_conta,tipo_conta) values ('2346523-11',6,2,887.99,1);

-- consultas - select 
select * from tb_Conta;


-- ======= Exercicios   ========= 

-- 1 - Mostre todos os clientes do banco Bradesco
select * from tb_Conta c
	inner join tb_Agencia a 
	on a.Id_agencia =  a.Id_agencia 
	inner join tb_Banco b
	on a.Id_banco = b.Id_banco;

-- 2 - O cliente Carlos deseja transferir 500,00 de sua conta corrente para a sua poupança
-- Obs: Necessário a criação de 2 updates

update tb_Conta
	set Saldo_conta = Saldo_conta - 500.00
	where Numero_conta = '1122344-33'
	and tipo_conta = 1;

update tb_Conta
	set Saldo_conta = Saldo_conta + 500.00
	where Numero_conta = '1122344-33'
	and tipo_conta = 2;

-- 3 – Mostre a soma do saldo das contas correntes dos clientes agrupadas por banco
-- Ex: Nome_banco , valor
-- Santander , 1252,23
-- Bradesco , 14945,90

select b.nome Nome, SUM(c.Saldo_conta) Valor from tb_Conta c
	inner join tb_Agencia a
	on c.Id_agencia = a.Id_agencia
	inner join tb_Banco b
	on a.Id_banco = b.Id_banco
	group by (b.nome);

-- 4 - Mostre qual é a única agência que não possui contas abertas

select a.Nome_agencia Nome_agencia, sum(c.Id_cliente) Quantidade from tb_Conta c
	right join tb_Agencia a on c.Id_agencia = a.Id_agencia
	where c.Id_agencia is null
	group by (a.Nome_agencia);

-- 5 - Mostre a quantidade de clientes (somente conta corrente) por agência
-- Ex: Nome_Agencia, quantidade

select a.Nome_agencia Nome_Agência, sum(c.Id_cliente) Quantidade from tb_Conta c
	inner join tb_Agencia a
	on c.Id_agencia = a.Id_agencia
	inner join tb_Banco b
	on a.Id_banco = b.Id_banco
	group by (a.Nome_agencia);

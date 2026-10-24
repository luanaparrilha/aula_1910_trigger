create database empresa5;
use empresa5;

create table cliente(
	id_cliente integer primary key auto_increment not null,
    nome_cliente varchar(100) not null,
    idade_cliente integer not null,
    sexo_cliente char(1) not null,
    data_exclusao timestamp not null
);

create table cliente_audit(
	id_audit integer primary key auto_increment not null,
    nome_cliente varchar(100) not null,
    idade_cliente integer not null,
    sexo_cliente char(1) not null, 
    data_exclusao timestamp null
);

insert into cliente(nome_cliente, idade_cliente, sexo_cliente, data_exclusao) values 
('Katniss Everdeen', 18, 'F', '2026-10-19'),
('Peeta Mellark', 18, 'M', '2026-10-21'),
('Gale Hawthorne', 18, 'M', '2026-10-23');

select * from cliente;

-- Exercício 1: Trigger depois da exclusão

delimiter $$

create trigger trg_cliente_delete
after delete on cliente
for each row
begin
	insert into cliente_audit(nome_cliente, idade_cliente, sexo_cliente)
    values(old.nome_cliente, old.idade_cliente, old.sexo_cliente);
end $$

delimiter ;

delete from cliente where id_cliente = 3;

select * from cliente_audit;

-- Exercício 2: Trigger antes da inserção

delimiter $$ 

create trigger trg_padroniza_sexo 
before insert on cliente
for each row
begin
	set new.sexo_cliente = upper(new.sexo_cliente);
end $$

delimiter ;

insert into cliente(nome_cliente, idade_cliente, sexo_cliente, data_exclusao)
values ('Primrose Everdeen', 13, 'f', '2026-10-23'); 

select * from cliente;
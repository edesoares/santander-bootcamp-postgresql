-- Retorna numero, nome e status (ativo/inativo) da tabela banco
select numero, nome, ativo from banco;

-- Cria uma view com os registros numero, nome e status da tabela banco
create or replace view vw_bancos as (
	select numero, nome, ativo
	from banco
);

-- Retorna os registros da minha view
select numero, nome, ativo
from vw_bancos;

-- Cria outra view criando aliases para os elementos da tabela base
create or replace view vw_bancos_2 (banco_numero, banco_nome, banco_ativo) as (
	select numero, nome, ativo
	from banco
);

-- Retorna os registros da minha 2 view
select banco_numero, banco_nome, banco_ativo
from vw_bancos_2;

-- Fazendo insert na minha view
insert into vw_bancos_2 (banco_numero, banco_nome, banco_ativo)
values (51, 'Banco Maroto', TRUE);

-- Retorna, da view, o registro que eu acabei de inserir
select banco_numero, banco_nome, banco_ativo
from vw_bancos_2 where banco_numero = 51;

-- Retorna, da tabela base, o registro que eu acabei de inserir
select numero, nome, ativo from banco where numero = 51;

-- Modifica valor através da minha view
update vw_bancos_2 set banco_ativo = FALSE where banco_numero = 51;

-- Remove, através da view, o registro que eu criei
delete from vw_bancos_2 where banco_numero = 51;

-- Cria uma view temporária
create or replace temporary view vw_agencia as (
	select nome from agencia
);

-- Retorna os nomes da view temporário
select nome from vw_agencia;

-- Cria uma view conforme parâmetro (só bancos ativos)
create or replace view vw_bancos_ativos as (
	select numero, nome, ativo
	from banco
	where ativo is true
) with local check option;

-- Tenta inserir um novo registro com o ativo = false
insert into vw_bancos_ativos (numero, nome, ativo) values (51,'Banco Maneiro', false); -- assim da erro

-- Cria uma view somente com os bancos ativos que começam com 'a'
create or replace view vw_bancos_com_a as (
	select numero, nome, ativo
	from vw_bancos_ativos
	where nome ilike 'a%'
) with local check option;

-- Faz uma busca na view (n vai retornar nada pq não tem nenhum banco que começa com 'a')
select numero, nome, ativo from vw_bancos_com_a;

-- Insere um banco que começa com 'a'
insert into vw_bancos_com_a (numero, nome, ativo) values (51,'Amerika Express', true);

insert into vw_bancos_com_a (numero, nome, ativo) values (381,'Amerika Prime', false); -- assim não funciona, tem que ser true
insert into vw_bancos_com_a (numero, nome, ativo) values (51,'Prime Express', true); -- assim tbm não, tem que começar com 'a'

-- Se eu der replace na view removendo o 'with local check option' ele deixa inserir registros com 'false'
create or replace view vw_bancos_ativos as (
	select numero, nome, ativo
	from banco
	where ativo is true
);

-- Por outro lado se eu recriar a vw_bancos_com_a trocando 'local' por 'cascaded', ele volta a validar a regra da outra view tbm
create or replace view vw_bancos_com_a as (
	select numero, nome, ativo
	from vw_bancos_ativos
	where nome ilike 'a%'
) with cascaded check option;

-- View recursiva

-- Cria uma tabela
create table if not exists funcionarios (
	id serial, 
	nome varchar(50), 
	gerente integer, 
	primary key (id), 
	foreign key (gerente) 
	references funcionarios (id)
);

-- Insere dados na tabela
insert into funcionarios (nome, gerente) values ('Ancelmo', null);
insert into funcionarios (nome, gerente) values ('Beatriz',1);
insert into funcionarios (nome, gerente) values ('Magno',1);
insert into funcionarios (nome, gerente) values ('Cremilda',2);
insert into funcionarios (nome, gerente) values ('Wagner',4);

-- Retorna os dados
select id, nome, gerente from funcionarios;

-- Retorna só onde gerente é null
select id, nome, gerente from funcionarios where gerente is null;

-- Isso aqui só retorna o ancelmo
select id, nome, gerente from funcionarios where gerente is null
union all
select id, nome, gerente from funcionarios where id = 999; -- Pra fins de exemplo

-- Criando a view recursiva
create or replace recursive view vw_func(id, gerente, funcionario) as (
	select id, gerente, nome
	from funcionarios
	where gerente is null
	union all 
	select funcionarios.id, funcionarios.gerente, funcionarios.nome
	from funcionarios join vw_func on vw_func.id = funcionarios.gerente
);

-- Retorna os dados da view recursiva
select id, gerente, funcionario from vw_func;
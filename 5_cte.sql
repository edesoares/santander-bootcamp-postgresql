-- Retorna numero e nome da tabela bancos
select numero, nome from banco;

-- Retorna num do banco, da agencia e nome da agencia da tabela agencia
select banco_numero, numero, nome from agencia;

-- Cria uma tabela temporária a partir dos campos numero e nome da tabela banco
with tbl_tmp_banco as (
	select numero, nome
	from banco
)
select numero, nome
from tbl_tmp_banco;

-- Retorna conforme parâmetro
with params as (
	select 213 as banco_numero
), tbl_tmp_banco as (
	select numero, nome
	from banco
	join params on params.banco_numero = banco.numero
)
select numero, nome 
from tbl_tmp_banco;

-- Subselect 
select banco.numero, banco.nome
from banco
join (
	select 213 as banco_numero
) params on params.banco_numero = banco.numero;

-- Retorna uma tabela temporá com todos os clientes, transações e valores
with clientes_e_transacoes as (
	select 	cliente.nome as cliente_nome,
			tipo_transacao.nome as tipo_transacao_nome,
			cliente_transacoes.valor as tipo_transacao_valor
	from 	cliente_transacoes
	join 	cliente on cliente.numero = cliente_transacoes.cliente_numero
	join	tipo_transacao on tipo_transacao.id = cliente_transacoes.tipo_transacao_id
)
select cliente_nome, tipo_transacao_nome, tipo_transacao_valor
from clientes_e_transacoes;

-- Mesma coisa retornando só transações feitas pelo itaú
with clientes_e_transacoes as (
	select 	cliente.nome as cliente_nome,
			tipo_transacao.nome as tipo_transacao_nome,
			cliente_transacoes.valor as tipo_transacao_valor
	from 	cliente_transacoes
	join 	cliente on cliente.numero = cliente_transacoes.cliente_numero
	join	tipo_transacao on tipo_transacao.id = cliente_transacoes.tipo_transacao_id
	join banco on banco.numero = cliente_transacoes.banco_numero
	and banco.nome ilike '%itaú%'
)
select cliente_nome, tipo_transacao_nome, tipo_transacao_valor
from clientes_e_transacoes;
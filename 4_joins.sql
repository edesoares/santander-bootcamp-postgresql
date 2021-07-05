-- Retorna numero e nome da tabela banco
select numero, nome 
from banco;

-- Retorna numero do banco, numero da agencia e nome da agencia da tabela agencia
select banco_numero, numero, nome 
from agencia;

-- Retorna numero e nome da tabela cliente
select numero, nome 
from cliente;

-- Retorna num do banco, num da agencia, num da conta, digito e num do cliente da tabela conta_corrente
select banco_numero, agencia_numero, numero, digito, cliente_numero 
from conta_corrente;

-- Retorna id e nome da tabela tipo_transacao
select id, nome 
from tipo_transacao;

-- Retorna num do banco, da agencia, da cc, do cliente, digito da cc e valor da transação da tabela cliente_transacoes
select banco_numero, agencia_numero, conta_corrente_numero, conta_corrente_digito, cliente_numero, valor 
from cliente_transacoes;

-- Retorna contagem de todos os registros da tabela banco
select count(1) from banco;

-- Retorna contagem de todos os registros da tabela agencia
select count(1) from agencia;

-- Retorna todos os bancos e agencias que possuem relação
select banco.numero, banco.nome, agencia.numero, agencia.nome
from banco
join agencia on agencia.banco_numero = banco.numero;

-- Retorna a qtde de bancos registrados 
select count (banco.numero)
from banco
join agencia on agencia.banco_numero = banco.numero;

-- Retorna uma lista de bancos distintos com a qtde de agencia que cada um possui
select banco.numero
from banco
join agencia on agencia.banco_numero = banco.numero
group by banco.numero;

-- Retorna o numero de bancos distintos
select count (distinct banco.numero)
from banco
join agencia on agencia.banco_numero = banco.numero;

-- Left Join
select banco.numero, banco.nome, agencia.numero, agencia.nome
from banco
left join agencia on agencia.banco_numero = banco.numero;

-- Right join
select agencia.numero, agencia.nome, banco.numero, banco.nome
from agencia
right join banco on banco.numero = agencia.banco_numero;

-- Full join
select banco.numero, banco.nome, agencia.numero, agencia.nome
from banco
full join agencia on agencia.banco_numero = banco.numero;

-- Join com todas as tabelas
select banco.nome, agencia.nome, conta_corrente.numero, cliente.nome
from banco
join agencia on agencia.banco_numero = banco.numero
join conta_corrente on conta_corrente.banco_numero = banco.numero
and conta_corrente.agencia_numero = agencia.numero
join cliente on cliente.numero = conta_corrente.cliente_numero;

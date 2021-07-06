-- Retorna numero e nome da tabela banco.
select numero, nome from banco;

-- Retorna numero e nome da tabela banco ordenado.
select numero, nome, ativo from banco order by numero;

-- Faz um update
update banco set ativo = false where numero = 0;

-- Fazendo rollback
begin;
update banco set ativo = true where numero = 0;

-- Aqui ele aparece como true
select numero, nome, ativo from banco where numero = 0;

rollback;

-- Aqui aparece com falso
select numero, nome, ativo from banco where numero = 0;

-- Fazendo um commit
begin;
update banco set ativo = true where numero = 0;
commit;

-- Aqui aparece com true
select numero, nome, ativo from banco where numero = 0;

-- Utilizando savepoints
-- Retorna os dados de funcionarios
select id, gerente, nome from funcionarios;

-- Inicia a transação
begin;
-- Faz um update
update funcionarios set gerente = 2 where id = 3;
-- Cria um savepoint
savepoint sp_func;
-- Faz outro update
update funcionarios set gerente = null;
-- Retorna pro savepoint desfazendo o ultimo update
rollback to sp_func;
-- Faz outro update, só este e o primeiro vão persistir
update funcionarios set gerente = 3 where id = 5; 
-- Commit
commit;
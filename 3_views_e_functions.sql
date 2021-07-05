SELECT numero, nome FROM banco;
SELECT banco_numero, numero, nome FROM agencia;
SELECT numero, nome, email FROM cliente;
SELECT banco_numero, agencia_numero, cliente_numero FROM cliente_transacoes;

-- Não recomendado
SELECT * FROM conta_corrente;

-- information_schema é uma view que mostra todas as colunas de todas as tabelas
SELECT * FROM information_schema.columns WHERE table_name = 'banco';
SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'banco';

-- AVG (média de todos os valores)
SELECT AVG(valor) FROM cliente_transacoes;

-- COUNT (having) faz agrupamento de valores
SELECT COUNT (numero) FROM cliente;
SELECT COUNT (numero), email FROM cliente WHERE email ILIKE '%gmail.com' GROUP BY email;
SELECT COUNT (id), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id
HAVING COUNT (id) > 150;

-- MAX seleciona o maior valor
SELECT MAX (numero) FROM cliente;
SELECT MAX (valor) FROM cliente_transacoes;
SELECT MAX (valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id;

-- MIN seleciona o menor valor
SELECT MIN (numero) FROM cliente;
SELECT MIN (valor) FROM cliente_transacoes;
SELECT MIN (valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id;

-- SUM retorna a soma dos valores
SELECT SUM (valor) FROM cliente_transacoes;
SELECT SUM (valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id;
SELECT SUM (valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id ASC;
SELECT SUM (valor), tipo_transacao_id FROM cliente_transacoes GROUP BY tipo_transacao_id
ORDER BY tipo_transacao_id DESC;
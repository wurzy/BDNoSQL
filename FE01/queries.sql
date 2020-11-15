--[a] Quantos t�tulos possui a cole��o?
select count(*) as total from titulo;

--[b] Quantas m�sicas no total possui toda a cole��o?
select count(*) as total from musica;

--[c] Quantos autores existem na cole��o?
select count(*) as total from autor;

--[d] Quantas editoras distintas existem na cole��o?
select count(*) as total from editora;

--[e] O autor "Max Changmin" � o principal autor de quantos t�tulo?
select count(*) as total from titulo t inner join autor a on a.id_autor=t.id_autor where a.nome='Max Changmin';

--[f] No ano de 1970, quais foram os t�tulos comprados pelo utilizador?
select titulo from titulo where to_char(dta_compra,'yyyy')='1970';

--[g] Qual o autor do t�tulo que foi adquirido em "01-02-2010", cujo pre�o foi de 12�?
select a.nome as autor from titulo t, autor a where t.dta_compra=to_date('01-02-2010') and t.preco=12 and t.id_autor=a.id_autor;

--[h] Na al�nea anterior indique qual a editora desse t�tulo?
select e.nome as editora from titulo t, editora e where t.dta_compra=to_date('01-02-2010') and t.preco=12 and e.id_editora=t.id_editora;

--[i] Quais as reviews (data e classifica��o) existentes para o t�tulo "oh whoa oh" ?
select r.dta_review as data, r.conteudo as classifica��o from review r inner join titulo t on r.id_titulo=t.id_titulo where t.titulo='oh whoa oh';

--[j] Quais as reviews (data e classifica��o) existentes para o t�tulo "pump", ordenadas por data da mais antiga para a mais recente?
select r.dta_review as data, r.conteudo as classifica��o from review r inner join titulo t on r.id_titulo=t.id_titulo where t.titulo='pump' order by r.dta_review;

--[k] Quais os diversos autores das m�sicas do t�tulo lan�ado a "04-04-1970" com o pre�o de 20�?
select distinct(a.nome) as autor from titulo t inner join musica m on m.id_titulo=t.id_titulo inner join autor a on a.id_autor=m.id_autor where t.dta_compra=to_date('04-04-1970') and t.preco=20;

--[l] Qual foi o total de dinheiro investido em compras de t�tulo da editora "EMI"?
select sum(t.preco) as total from titulo t inner join editora e on e.id_editora=t.id_editora and e.nome='EMI';

--[m] Qual o t�tulo mais antigo cujo pre�o foi de 20�?
select titulo from titulo where preco=20 order by dta_compra fetch first 1 rows only;

--[n] Quantos "MP3" tem a cole��o?
select count(*) as total from titulo t inner join suporte s on s.id_suporte=t.id_suporte and s.nome='MP3';

--[o] Destes mp3 quais s�o os t�tulos cujo g�nero �: Pop Rock?
select t.titulo as titulo from titulo t inner join suporte s on s.id_suporte=t.id_suporte inner join genero g on g.id_genero=t.id_genero and s.nome='MP3' and g.nome='Pop Rock';

--[p] Qual o custo total com "Blue-Ray"?
select sum(preco) as total from titulo t inner join suporte s on s.id_suporte=t.id_suporte and s.nome='Blue-Ray';

--[q] Qual o custo total com "Blue-Ray" cuja editora � a EMI?
select sum(preco) as total from titulo t inner join suporte s on s.id_suporte=t.id_suporte inner join editora e on e.id_editora=t.id_editora where s.nome='Blue-Ray' and e.nome='EMI';

--[r] Qual o patrim�nio total dos t�tulos da cole��o?
select sum(preco) as total from titulo;

--[s] Qual a editora na qual o colecionador investiu mais dinheiro?
select e.nome as editora, sum(preco) as total from titulo t inner join editora e on e.id_editora=t.id_editora group by e.nome order by total desc fetch first 1 rows only;

--[t] Qual a editora que possui mais t�tulos de "Heavy Metal" na cole��o? Quantos titulos possui essa editora?
select e.nome as editora, count(*) as total from titulo t inner join genero g on g.id_genero=t.id_genero inner join editora e on e.id_editora=t.id_editora where g.nome='Heavy Metal' group by e.nome order by total desc fetch first 1 rows only;


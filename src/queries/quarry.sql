
-- Query 1
-- Get articles linked from "Mental health" page (page_id = 990505)
select * from page p 
where p.page_title in (select pl_title from pagelinks where pl_from = 990505 and pl_namespace = 0)
and p.page_namespace = 0 and p.page_is_redirect = 0 and p.page_is_new = 0;

-- Query 2
-- Get all revisions from articles retrieved from Query 1
select * from revision r 
where rev_page in (select page_id from page p 
where p.page_title in (select pl_title from pagelinks where pl_from = 990505 and pl_namespace = 0)
  and p.page_namespace = 0 and p.page_is_redirect = 0 and p.page_is_new = 0);


-- Query 3
-- The same as Query 2 but with JOINs instead of subqueries
select * from revision r
inner join page p on r.rev_page = p.page_id
inner join pagelinks pl on p.page_title=pl.pl_title
where pl.pl_from = 990505 and pl.pl_namespace = 0
and p.page_namespace = 0 and p.page_is_redirect = 0 and p.page_is_new = 0;

-- Query 4 – top 100k editors
select user_id, user_name, user_editcount from user
order by user_editcount desc
limit 100000;


-- Query 5 - revisions made by some users from Query 4
select ru.rev_id, ru.rev_page, ru.rev_actor, ru.rev_timestamp from revision_userindex ru
join actor a on ru.rev_actor = a.actor_id
join user u on a.actor_user = u.user_id
where u.user_id in ( 5178974,  6817311,  6789185,  6852934,  7520964,  7546495,
             7686850,  7497147,  7463353,  6079682,  5895681,  5826533,
             5835699,  5588672,  5749853,  6356329,  8626533,  8650228,
             8716318,  8805835,  8777637,  8600062,  7936137,  7895918,
             8328105,  8365230,  9644327,  9715543,  9598676,  9173343,
             8954360,  9922691, 10020822,  1942107,  1995198,  1514468,
             1737708,  1710755,  1528104,   264127,    10095,     2308,
               56503,    73861,    67210,   194531,   160327,   359243,
              253935,   236082,   246506,   140241,   156147,   119400,
             2250794,  2491777,  2311832,  2332824,  1432167,  1308243,
             1121601,   709747,   619187,   408232,   410195,   544450,
              632891,   443664,   430842,   985403,   965389,   968351,
             1049652,   739143,   755352,  1087256,   805882,  4096238,
             4114795,  4405164,  4060804,  3020940,  2992827,  2945962,
             3165613,  4013478,  3829126,  4603076,  4497200,  4812644,
             4999774,  4914710,  2936315,  2939951,  2711218, 16994033,
                    17075891, 17682038, 15664369, 15622501);
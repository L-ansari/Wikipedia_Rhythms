
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
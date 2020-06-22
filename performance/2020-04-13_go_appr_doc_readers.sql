
-- 어플리케이션에서 호출하는 쿼리
select
	count(docreader0_.id) as col_0_0_
from
	go_appr_doc_readers docreader0_
inner join go_appr_documents document1_ on
	docreader0_.document_id = document1_.id
inner join go_appr_documents document2_ on
	docreader0_.document_id = document2_.id
where
	docreader0_.user_id = '27677'
	and document2_.doc_status <>'DELETE'
	and document1_.doc_status <> 'DRAFT_WAITING'
	and (docreader0_.read_at is null)
	and (docreader0_.doc_read_type in ('REFERENCE',	'READING'));

  Aggregate  (cost=49494.25..49494.26 rows=1 width=8) (actual time=48.842..48.843 rows=1 loops=1)
    Buffers: shared hit=31849
    ->  Nested Loop  (cost=1.28..49490.86 rows=1358 width=8) (actual time=4.263..48.125 rows=2939 loops=1)
          Join Filter: (docreader0_.document_id = document1_.id)
          Buffers: shared hit=31849
          ->  Nested Loop  (cost=0.85..48562.62 rows=1358 width=24) (actual time=4.259..40.101 rows=2939 loops=1)
                Buffers: shared hit=20077
                ->  Index Scan using idx_1_go_appr_doc_readers on go_appr_doc_readers docreader0_  (cost=0.43..38317.68 rows=1366 width=16) (actual time=4.247..27.525 rows=2939 loops=1)
                      Index Cond: (user_id = 27677::bigint)
                      Filter: ((read_at IS NULL) AND ((doc_read_type)::text = ANY ('{REFERENCE,READING}'::text[])))
                      Rows Removed by Filter: 69
                      Buffers: shared hit=8305
                ->  Index Scan using pk_appr_documents on go_appr_documents document2_  (cost=0.42..7.49 rows=1 width=8) (actual time=0.003..0.003 rows=1 loops=2939)
                      Index Cond: (id = docreader0_.document_id)
                      Filter: ((doc_status)::text <> 'DELETE'::text)
                      Buffers: shared hit=11772
          ->  Index Scan using pk_appr_documents on go_appr_documents document1_  (cost=0.42..0.67 rows=1 width=8) (actual time=0.002..0.002 rows=1 loops=2939)
                Index Cond: (id = document2_.id)
                Filter: ((doc_status)::text <> 'DRAFT_WAITING'::text)
                Buffers: shared hit=11772
  Planning time: 0.563 ms
  Execution time: 48.962 ms


 -- 같은 쿼리인가? 이너조인을 2번이나 할 필요가 있는가? 메모리 사용량이 ...
select
	count(docreader0_.id) as col_0_0_
from
	go_appr_doc_readers docreader0_
inner join go_appr_documents document1_ on
	docreader0_.document_id = document1_.id
where
	docreader0_.user_id = '27677'
	and document1_.doc_status not in ('DELETE', 'DRAFT_WAITING')
	and (docreader0_.read_at is null)
	and (docreader0_.doc_read_type in ('REFERENCE',	'READING'));

  Aggregate  (cost=48566.01..48566.02 rows=1 width=8) (actual time=45.215..45.215 rows=1 loops=1)
    Buffers: shared hit=20077
    ->  Nested Loop  (cost=0.85..48562.62 rows=1357 width=8) (actual time=4.671..44.536 rows=2939 loops=1)
          Buffers: shared hit=20077
          ->  Index Scan using idx_1_go_appr_doc_readers on go_appr_doc_readers docreader0_  (cost=0.43..38317.68 rows=1366 width=16) (actual time=4.656..30.396 rows=2939 loops=1)
                Index Cond: (user_id = 27677::bigint)
                Filter: ((read_at IS NULL) AND ((doc_read_type)::text = ANY ('{REFERENCE,READING}'::text[])))
                Rows Removed by Filter: 69
                Buffers: shared hit=8305
          ->  Index Scan using pk_appr_documents on go_appr_documents document1_  (cost=0.42..7.49 rows=1 width=8) (actual time=0.003..0.004 rows=1 loops=2939)
                Index Cond: (id = docreader0_.document_id)
                Filter: ((doc_status)::text <> ALL ('{DELETE,DRAFT_WAITING}'::text[]))
                Buffers: shared hit=11772
  Planning time: 0.410 ms
  Execution time: 45.285 ms

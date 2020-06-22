select timelineon0_.id as id1_435_, timelineon0_.created_at as created_2_435_, timelineon0_.updated_at as updated_3_435_, timelineon0_.company_id as company15_435_, timelineon0_.department_name as departme4_435_, timelineon0_.early as early5_435_, timelineon0_.extension as extensio6_435_, timelineon0_.has_vacation as has_vaca7_435_, timelineon0_.holi_day as holi_day8_435_, timelineon0_.night as night9_435_, timelineon0_.normal as normal10_435_, timelineon0_.tardy as tardy11_435_, timelineon0_.timeline_group_id as timelin16_435_, timelineon0_.total as total12_435_, timelineon0_.user_id as user_id17_435_, timelineon0_.vacation_hours as vacatio13_435_, timelineon0_.working_day as working14_435_ from go_timeline_one_days timelineon0_ left outer join go_timeline_group timelinegr1_ on timelineon0_.timeline_group_id=timelinegr1_.id where timelinegr1_.id=8482 and timelineon0_.working_day='2020-04-13'
$1=8482, $2='2020-04-13'
Nested Loop  (cost=0.28..203088.91 rows=3 width=114)
  ->  Index Only Scan using pk_timeline_group on go_timeline_group timelinegr1_  (cost=0.28..8.30 rows=1 width=8)
        Index Cond: (id = 8482::bigint)
  ->  Seq Scan on go_timeline_one_days timelineon0_  (cost=0.00..203080.58 rows=3 width=114)
        Filter: ((timeline_group_id = 8482::bigint) AND ((working_day)::text = '2020-04-13'::text))


CREATE INDEX idx4_timeline_one_day ON go_timeline_one_days USING btree (working_day, timeline_group_id);
drop index idx4_timeline_one_day;


인덱스 추가전
Nested Loop  (cost=143656.89..169328.95 rows=3 width=114) (actual time=314.192..314.970 rows=18 loops=1)
  Buffers: shared hit=26504
  ->  Index Only Scan using pk_timeline_group on go_timeline_group timelinegr1_  (cost=0.28..8.30 rows=1 width=8) (actual time=0.009..0.011 rows=1 loops=1)
        Index Cond: (id = 8482)
        Heap Fetches: 1
        Buffers: shared hit=3
  ->  Bitmap Heap Scan on go_timeline_one_days timelineon0_  (cost=143656.61..169320.62 rows=3 width=114) (actual time=314.179..314.948 rows=18 loops=1)
        Recheck Cond: ((working_day)::text = '2020-04-13'::text)
        Filter: (timeline_group_id = 8482)
        Rows Removed by Filter: 16482
        Heap Blocks: exact=440
        Buffers: shared hit=26501
        ->  Bitmap Index Scan on uk1_timeline_one_days  (cost=0.00..143656.61 rows=8177 width=0) (actual time=310.565..310.565 rows=49325 loops=1)
              Index Cond: ((working_day)::text = '2020-04-13'::text)
              Buffers: shared hit=26061
Planning time: 0.280 ms
Execution time: 315.259 ms

인덱스 추가후
Nested Loop  (cost=0.84..20.50 rows=3 width=114) (actual time=0.117..0.147 rows=18 loops=1)
  Buffers: shared hit=5 read=4
  ->  Index Only Scan using pk_timeline_group on go_timeline_group timelinegr1_  (cost=0.28..8.30 rows=1 width=8) (actual time=0.014..0.015 rows=1 loops=1)
        Index Cond: (id = 8482)
        Heap Fetches: 1
        Buffers: shared hit=3
  ->  Index Scan using idx4_timeline_one_day on go_timeline_one_days timelineon0_  (cost=0.56..12.17 rows=3 width=114) (actual time=0.098..0.110 rows=18 loops=1)
        Index Cond: (((working_day)::text = '2020-04-13'::text) AND (timeline_group_id = 8482))
        Buffers: shared hit=2 read=4
Planning time: 0.449 ms
Execution time: 0.212 ms

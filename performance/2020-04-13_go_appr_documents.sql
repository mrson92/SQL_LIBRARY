2020-04-13 09:20:14 KST LOG:  duration: 675.347 ms  execute <unnamed>: select count(document0_.id) as col_0_0_ from go_appr_documents document0_ where (document0_.receiver_id=$1 or document0_.receiver_dept_id in ($2)) and document0_.doc_status=$3
2020-04-13 09:20:14 KST DETAIL:  parameters: $1 = '7278', $2 = '2649', $3 = 'RECV_WAITING'
2020-04-13 09:20:14 KST LOG:  duration: 675.339 ms  plan:
        Query Text: select count(document0_.id) as col_0_0_ from go_appr_documents document0_ where (document0_.receiver_id=$1 or document0_.receiver_dept_id in ($2)) and document0_.doc_status=$3
        Aggregate  (cost=61095.38..61095.39 rows=1 width=8)
          ->  Seq Scan on go_appr_documents document0_  (cost=0.00..61095.33 rows=20 width=8)
                Filter: (((doc_status)::text = 'RECV_WAITING'::text) AND ((receiver_id = 7278::bigint) OR (receiver_dept_id = 2649::bigint)))

인덱스 추가검토
CREATE INDEX idx6_appr_documents ON go_appr_documents USING btree (receiver_dept_id);

인덱스 추가전
Aggregate  (cost=55805.21..55805.22 rows=1 width=8) (actual time=214.135..214.136 rows=1 loops=1)
  Buffers: shared hit=41869
  ->  Seq Scan on go_appr_documents document0_  (cost=0.00..55805.16 rows=18 width=8) (actual time=6.473..214.007 rows=319 loops=1)
        Filter: (((doc_status)::text = 'RECV_WAITING'::text) AND ((receiver_id = 7278::bigint) OR (receiver_dept_id = 2649::bigint)))
        Rows Removed by Filter: 796034
        Buffers: shared hit=41869
Planning time: 0.152 ms
Execution time: 214.283 ms

인덱스 추가후
Aggregate  (cost=1754.86..1754.87 rows=1 width=8) (actual time=4.972..4.973 rows=1 loops=1)
  Buffers: shared hit=954 read=11
  ->  Bitmap Heap Scan on go_appr_documents document0_  (cost=12.41..1754.82 rows=18 width=8) (actual time=3.350..4.889 rows=319 loops=1)
        Recheck Cond: ((receiver_id = 7278::bigint) OR (receiver_dept_id = 2649::bigint))
        Filter: ((doc_status)::text = 'RECV_WAITING'::text)
        Rows Removed by Filter: 848
        Heap Blocks: exact=954
        Buffers: shared hit=954 read=11
        ->  BitmapOr  (cost=12.41..12.41 rows=473 width=0) (actual time=3.206..3.206 rows=0 loops=1)
              Buffers: shared read=11
              ->  Bitmap Index Scan on idx4_appr_documents  (cost=0.00..6.10 rows=223 width=0) (actual time=3.043..3.043 rows=546 loops=1)
                    Index Cond: (receiver_id = 7278::bigint)
                    Buffers: shared read=4
              ->  Bitmap Index Scan on idx6_appr_documents  (cost=0.00..6.30 rows=250 width=0) (actual time=0.161..0.161 rows=1165 loops=1)
                    Index Cond: (receiver_dept_id = 2649::bigint)
                    Buffers: shared read=7
Planning time: 0.262 ms
Execution time: 5.012 ms

Query Text: select count(appractivi0_.id) as col_0_0_ from go_appr_activities appractivi0_ left outer join go_appr_activity_logs appractivi1_ on appractivi0_.id=appractivi1_.appr_activity_id cross join go_appr_activity_groups appractivi2_ cross join go_appr_flows apprflow3_ cross join go_appr_documents document4_ where appractivi0_.activity_group_id=appractivi2_.id and appractivi2_.appr_flow_id=apprflow3_.id and apprflow3_.document_id=document4_.id and appractivi0_.user_id=$1 and document4_.doc_status=$2 and (appractivi1_.id is null or appractivi1_.appr_action=$3)
$1=12969, $2='INPROGRESS', $3='PREVIOUSRETURN'

Aggregate  (cost=74160.08..74160.09 rows=1 width=8)
  ->  Nested Loop Left Join  (cost=42880.73..74160.08 rows=1 width=8)
        Filter: ((appractivi1_.id IS NULL) OR ((appractivi1_.appr_action)::text = 'PREVIOUSRETURN'::text))
        ->  Nested Loop  (cost=42880.30..72997.34 rows=173 width=8)
              ->  Nested Loop  (cost=42879.88..67232.73 rows=8329 width=16)
                    ->  Hash Join  (cost=42879.45..63175.00 rows=8329 width=16)
                          Hash Cond: (appractivi0_.activity_group_id = appractivi2_.id)
                          ->  Bitmap Heap Scan on go_appr_activities appractivi0_  (cost=196.98..20336.36 rows=8329 width=16)
                                Recheck Cond: (user_id = 12969::bigint)
                                ->  Bitmap Index Scan on idx3_appr_activities  (cost=0.00..194.90 rows=8329 width=0)
                                      Index Cond: (user_id = 12969::bigint)
                          ->  Hash  (cost=25616.10..25616.10 rows=1365310 width=16)
                                Buckets: 262144  Batches: 1  Memory Usage: 64017kB
                                ->  Seq Scan on go_appr_activity_groups appractivi2_  (cost=0.00..25616.10 rows=1365310 width=16)
                    ->  Index Scan using pk_appr_flows on go_appr_flows apprflow3_  (cost=0.42..0.48 rows=1 width=16)
                          Index Cond: (id = appractivi2_.appr_flow_id)
              ->  Index Scan using pk_appr_documents on go_appr_documents document4_  (cost=0.42..0.68 rows=1 width=8)
                    Index Cond: (id = apprflow3_.document_id)
                    Filter: ((doc_status)::text = 'INPROGRESS'::text)
        ->  Index Scan using idx2_go_appr_activity_logs on go_appr_activity_logs appractivi1_  (cost=0.43..6.71 rows=1 width=24)
              Index Cond: (appractivi0_.id = appr_activity_id)


select count(docreader0_.id) as col_0_0_ from go_appr_doc_readers docreader0_ inner join go_appr_documents document1_ on docreader0_.document_id=document1_.id inner join go_appr_documents document2_ on docreader0_.document_id=document2_.id where docreader0_.user_id=$1 and document2_.doc_status<>$2 and document1_.doc_status<>$3 and (docreader0_.read_at is null) and (docreader0_.doc_read_type in ($4 , $5))

2020-04-13 14:30:42 KST DETAIL:  parameters: $1 = '27677', $2 = 'DELETE', $3 = 'DRAFT_WAITING', $4 = 'REFERENCE', $5 = 'READING'


select count(appractivi0_.id) as col_0_0_ from go_appr_activities appractivi0_ left outer join go_appr_activity_logs appractivi1_ on appractivi0_.id=appractivi1_.appr_activity_id cross join go_appr_activity_groups appractivi2_ cross join go_appr_flows apprflow3_ cross join go_appr_documents document4_ where appractivi0_.activity_group_id=appractivi2_.id and appractivi2_.appr_flow_id=apprflow3_.id and apprflow3_.document_id=document4_.id and appractivi0_.user_id=12969 and document4_.doc_status='INPROGRESS' and (appractivi1_.id is null or appractivi1_.appr_action='PREVIOUSRETURN')
$1=12969, $2='INPROGRESS', $3='PREVIOUSRETURN'

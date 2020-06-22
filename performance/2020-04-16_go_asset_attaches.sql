select attaches0_.document_id as document1_111_0_, attaches0_.attach_id as attach_i2_92_0_, attach1_.id as id1_180_1_, attach1_.created_at as created_2_180_1_, attach1_.updated_at as updated_3_180_1_, attach1_.status as status4_180_1_, attach1_1_.asset_id as asset_id2_164_1_, attach1_2_.post_id as post_id2_329_1_, attach1_3_.device_version_id as device_v2_269_1_, case when attach1_1_.id is not null then 1 when attach1_2_.id is not null then 2 when attach1_3_.id is not null then 3 when attach1_.id is not null then 0 end as clazz_1_ from go_appr_doc_attaches attaches0_ inner join go_attaches attach1_ on attaches0_.attach_id=attach1_.id left outer join go_asset_attaches attach1_1_ on attach1_.id=attach1_1_.id left outer join go_post_attaches attach1_2_ on attach1_.id=attach1_2_.id left outer join go_device_version_attaches attach1_3_ on attach1_.id=attach1_3_.id where attaches0_.document_id=183166 order by attach1_.id asc

Nested Loop Left Join  (cost=12860.94..12862.06 rows=3 width=92)
  ->  Nested Loop Left Join  (cost=12860.79..12861.52 rows=3 width=76)
        ->  Merge Left Join  (cost=12860.50..12860.55 rows=3 width=60)
              Merge Cond: (attach1_.id = attach1_1_.id)
              ->  Sort  (cost=12859.36..12859.37 rows=3 width=44)
                    Sort Key: attaches0_.attach_id
                    ->  Nested Loop  (cost=0.43..12859.34 rows=3 width=44)
                          ->  Seq Scan on go_appr_doc_attaches attaches0_  (cost=0.00..12833.96 rows=3 width=16)
                                Filter: (document_id = 183166::bigint)
                          ->  Index Scan using pk_attaches on go_attaches attach1_  (cost=0.43..8.45 rows=1 width=28)
                                Index Cond: (id = attaches0_.attach_id)
              ->  Sort  (cost=1.14..1.15 rows=6 width=16)
                    Sort Key: attach1_1_.id
                    ->  Seq Scan on go_asset_attaches attach1_1_  (cost=0.00..1.06 rows=6 width=16)
        ->  Index Scan using pk_post_attaches on go_post_attaches attach1_2_  (cost=0.29..0.31 rows=1 width=16)
              Index Cond: (attach1_.id = id)
  ->  Index Scan using pk_device_version_attaches on go_device_version_attaches attach1_3_  (cost=0.15..0.17 rows=1 width=16)
        Index Cond: (attach1_.id = id)

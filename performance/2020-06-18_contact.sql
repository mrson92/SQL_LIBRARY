2020-06-18 16:00:16 KST LOG:  duration: 698.244 ms  execute <unnamed>:
select
	contact0_.id as id1_250_,
	contact0_.created_at as created_2_250_,
	contact0_.updated_at as updated_3_250_,
	contact0_.alias as alias4_250_,
	contact0_.anniversary as annivers5_250_,
	contact0_.birthday as birthday6_250_,
	contact0_.book_id as book_id25_250_,
	contact0_.code as code7_250_,
	contact0_.company_name as company_8_250_,
	contact0_.creator_id as creator26_250_,
	contact0_.deleted_at as deleted_9_250_,
	contact0_.department_name as departm10_250_,
	contact0_.description as descrip11_250_,
	contact0_.email as email12_250_,
	contact0_.first_name as first_n13_250_,
	contact0_.first_name_hurigana as first_n14_250_,
	contact0_.home_id as home_id27_250_,
	contact0_.last_name as last_na15_250_,
	contact0_.last_name_hurigana as last_na16_250_,
	contact0_.middle_name as middle_17_250_,
	contact0_.middle_name_hurigana as middle_18_250_,
	contact0_.mobile_no as mobile_19_250_,
	contact0_.name as name20_250_,
	contact0_.name_hurigana as name_hu21_250_,
	contact0_.name_initial_consonant as name_in22_250_,
	contact0_.nick_name as nick_na23_250_,
	contact0_.office_id as office_28_250_,
	contact0_.photo_id as photo_i29_250_,
	contact0_.position_name as positio24_250_
from
	go_contacts contact0_
left outer join go_contact_has_contact_group groups1_ on
	contact0_.id = groups1_.contact_id
left outer join go_contact_groups contactgro2_ on
	 contactgro2_.id = groups1_.contact_group_id
where
	(contactgro2_.id in (5672))
	and (contact0_.deleted_at is null)
	and (lower(contact0_.name) like '%박정빈%'
	or lower(contact0_.email) like '%박정빈%')
limit 10

2020-06-18 16:00:16 KST DETAIL:  parameters: $1 = '%박정빈%', $2 = '%박정빈%', $3 = '10'

-- 상기 쿼리가 늦는 것으로 나온다.  그럼 익스플레인을 떠보자 얼마 안쓴다. // 시스템이 부하가 있을때 나타난 현상으로 보여진다. ㅠㅠ

Limit (actual time=16.996..16.996 rows=0 loops=1)
  Buffers: shared hit=846
  ->  Nested Loop (actual time=16.993..16.993 rows=0 loops=1)
        Buffers: shared hit=846
        ->  Nested Loop (actual time=16.993..16.993 rows=0 loops=1)
              Buffers: shared hit=846
              ->  Seq Scan on go_contact_has_contact_group groups1_ (actual time=16.990..16.990 rows=0 loops=1)
                    Filter: (contact_group_id = 5672)
                    Rows Removed by Filter: 141020
                    Buffers: shared hit=846
              ->  Index Scan using pk_contacts on go_contacts contact0_ (never executed)
                    Index Cond: (id = groups1_.contact_id)
                    Filter: ((deleted_at IS NULL) AND ((lower((name)::text) ~~ '%박정빈%'::text) OR (lower((email)::text) ~~ '%박정빈%'::text)))
        ->  Index Only Scan using pk_contact_groups on go_contact_groups contactgro2_ (never executed)
              Index Cond: (id = 5672)
              Heap Fetches: 0
Planning time: 21.594 ms
Execution time: 17.225 ms

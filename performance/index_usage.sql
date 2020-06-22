-- 인덱스 사용 효율을 확인하는 쿼리문
select
	schemaname as schema_name,
	relname as table_name,
	indexrelname as index_name,
	pg_size_pretty(pg_relation_size(indexrelid::regclass)) as index_size,
	idx_scan,
	idx_tup_read,
	idx_tup_fetch
from
	pg_stat_user_indexes
where
	indexrelname = 'idx2_login_histories'
	or indexrelname = 'idx1_login_history_cid'
	or indexrelname = 'idx1_go_companies'
order by
	idx_scan asc;


-- Seq scan을 빈번하게 하는 테이블을 찾는것.. 같이 보는것이 좋은 것이 table의 Size 및 row Count도 같이 보면 좋다.
-- 테이블이 큰데 seq Scan을 빈번히 한다면 인덱스가 걸릴 필요가 있는 테이블이라고 검토해 볼수 있다.
select
	relname,
	seq_scan,
	seq_tup_read,
	idx_tup_fetch,
	n_dead_tup
from
	pg_stat_all_tables
order by
	seq_tup_read desc;


------ 최신 버젼에서 확인할 사항 9.4.1.x에서는 없는 기능으로 보여짐
ELECT relname, cast(heap_blks_hit as numeric) / (heap_blks_hit + heap_blks_read) AS hit_pct, heap_blks_hit, heap_blks_read from pg_stat_user_tables
WHERE (heap_blks_hit + heap_blks_read) > 0 ORDER BY hit_pct;
---

--- 인덱스 참조 및 Seq 참조 비율을 가지고 참조는 많으나 인덱스가 부족한 것이 아닌가를 검토하는 작업을 할 수 있다.
SELECT relname, seq_tup_read, idx_tup_fetch, cast(idx_tup_fetch as numeric) / (idx_tup_fetch + seq_tup_read) AS idx_tup_pct
FROM pg_stat_user_tables WHERE (idx_tup_fetch + seq_tup_read) > 0 ORDER BY idx_tup_pct;


-----------------------
	select
		t.tablename,
		indexname,
		c.relutples::integer as num_rows,
		pg_size_pretty(pg_relation_size(quote_ident(t.tablename)::text)) AS table_size,
		pg_size_pretty(pg_relation_size(quote_ident(indexname)::text)) AS index_size,
		CASE WHEN x.is_unique = 1 THEN 'Y'
			ELSE 'N'
		END AS UNIQUE,
		idx_scan AS number_of_scans,
		idx_tup_read AS tuples_read,
		idx_tup_fetch AS tuples_fetched
	from pg_tables t
	LEFT OUTER JOIN pg_class c on t.tablename=c.relname
	LEFT OUTER JOIN
		(select indrelid,
				max(CAST(indisunique AS integer)) AS is_unique
		 from pg_stat_user_indexes
		 group by indrelid) x
		 ON c.oid = x.indrelid
	LEFT OUTER Join
		(select c.relname AS ctablename, ipg.relname AS indexname, x.indnatts AS number_of_columns, idx_scan, idx_tup_read, idx_tup_fetch, indexrelname FROM pg_index x
				JOIN pg_class c ON c.oid = x.indexrelid
				JOIN pg_class ipg ON ipg.oid = x.indexrelid
				JOIN pg_stat_all_indexes psai ON x.indexrelid = psai.indexrelid)
		AS foo
		ON t.tablename = foo.ctablename
	WHERE t.schemaname='public'
	ORDER BY pg_relation_size(quote_ident(indexrelname)::text) desc;

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

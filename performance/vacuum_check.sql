-- n_dead_tup가 많아지면 성능에 영향을 미칠수 있으므로 Vacuum은 반드시 확인해야 한다.
select
	relname,
	n_live_tup,
	n_dead_tup,
	last_vacuum,
	last_autovacuum
from
	pg_catalog.pg_stat_all_tables
where
	relname = 'go_attnd_daily_stats'
order by
	n_dead_tup desc;

-- relname,               n_live_tup, n_dead_tup,   last_vacuum,            last_autovacuum
-- go_attnd_daily_stats	  0	          0	            2020-03-29 00:15:47	    2020-03-03 19:07:39

-- Vacuum을 수행하면서 Table statistics를 갱신한다.
vacuum analyze verbose "table_name"; 

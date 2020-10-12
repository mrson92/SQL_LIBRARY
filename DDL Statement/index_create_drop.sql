-- 인덱스 생성
create index idx1_dept_members on go_dept_members using btree (department_id);

-- 인덱스 삭제
drop index idx1_dept_members;

-- 인덱스 삭제전에는 반드시 인덱스가 활용되고 있는지 확인하고 지워야 한다.
-- ../performance/index_usage.sql 검토

--7794-9277-1180-9180
--4539-2694-3842-4057
--3862-4136-6336-1854
--0788-6313-7490-9286

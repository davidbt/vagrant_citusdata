select master_create_distributed_table('table1', 'id', 'hash');
-- should be more nodes to make it really distributed
select master_create_worker_shards('table1', 16, 1);

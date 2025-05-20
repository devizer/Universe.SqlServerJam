exec sp_configure 'show advanced options', 1;
exec sp_configure 'affinity mask', 2;
reconfigure with override;

SELECT 
    scheduler_id,
    cpu_id,
    status,
    is_online,
    is_idle,
    current_tasks_count,
    runnable_tasks_count,
    current_workers_count,
    active_workers_count,
    load_factor
FROM 
    sys.dm_os_schedulers
ORDER BY 
    scheduler_id;

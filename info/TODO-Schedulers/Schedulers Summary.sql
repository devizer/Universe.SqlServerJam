-- CTE to classify and summarize schedulers
WITH SchedulerSummary AS (
    SELECT 
        CASE 
            WHEN status LIKE '%DAC%' THEN 'Admin-only emergency access'
            WHEN status LIKE 'VISIBLE%' THEN 'Foreground'
            WHEN status LIKE 'HIDDEN%' THEN 'Background'
            ELSE 'Other'
        END AS SchedulerType,
        COUNT(*) AS SchedulerCount,
        COUNT(CASE WHEN is_online = 1 THEN 1 END) AS OnlineCount,
        SUM(current_tasks_count) AS TotalTasks,
        SUM(runnable_tasks_count) AS RunnableTasks,
        SUM(current_workers_count) AS Workers,
        SUM(active_workers_count) AS ActiveWorkers,
        SUM(load_factor) AS TotalLoad
    FROM 
        sys.dm_os_schedulers
    GROUP BY 
        CASE 
            WHEN status LIKE '%DAC%' THEN 'Admin-only emergency access'
            WHEN status LIKE 'VISIBLE%' THEN 'Foreground'
            WHEN status LIKE 'HIDDEN%' THEN 'Background'
            ELSE 'Other'
        END
)

-- Final result sorted by logical type order
SELECT *
FROM SchedulerSummary
ORDER BY 
    CASE SchedulerType
        WHEN 'Foreground' THEN 1
        WHEN 'Background' THEN 2
        WHEN 'Admin-only emergency access' THEN 3
        ELSE 4
    END;

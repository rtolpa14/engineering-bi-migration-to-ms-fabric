IF OBJECT_ID('tempdb..#tmpthismonth') IS NOT NULL
    DROP TABLE #tmpthismonth;

DECLARE @CurrentYear int = year(GETDATE())
DECLARE @CurrentMonth int = month(GETDATE())

SELECT
YEAR(GETDATE())      AS [Year],
MONTH(GETDATE())     AS [Month],
DATEPART(WEEK, GETDATE()) AS [Week],
CAST(GETDATE() AS DATE)  AS [Run Date],
prjID as [Project ID],
prjEntityDescription as [Department],
prjProjectManagerName as [Project Manager],
e.empSupervisorName as [Supervisor],
prjID + ' ' + prjDescription as [ProjectID & Description],
prjClientName as [Client],
case prjStatus
when 0 then 'Preliminary'
when 1 then 'Active'
when 2 then 'Hold'
when 3 then 'Work Hold'
when 4 then 'Billing Hold'
when 5 then 'Closed'
when 6 then 'Marketing'
end as [Project Status],

prjProjectTypeDescription as [Project Type],
prjBillingTypeDescription as [Billing Type],

(case    
    when p.prjStatus = 5 then p.prjTotalBilled else p.prjTotalContractAmount
END) AS ContractAmount,

(
    CASE
        WHEN p.prjStatus = 5 THEN CAST(0 AS DECIMAL(38,2))
        WHEN (CAST(p.prjTotalBilled AS DECIMAL(38,2)) + CAST(p.prjTotalWIP AS DECIMAL(38,2))) 
             > CAST(p.prjTotalContractAmount AS DECIMAL(38,2))
        THEN
            CASE 
                WHEN (CAST(p.prjTotalContractAmount AS DECIMAL(38,2)) - CAST(p.prjTotalBilled AS DECIMAL(38,2))) < CAST(0 AS DECIMAL(38,2))
                    THEN CAST(0 AS DECIMAL(38,2))
                ELSE (CAST(p.prjTotalContractAmount AS DECIMAL(38,2)) - CAST(p.prjTotalBilled AS DECIMAL(38,2)))
            END
        ELSE CAST(p.prjTotalWIP AS DECIMAL(38,2))
    END
    + CAST(p.prjTotalBilled AS DECIMAL(38,2))
) as Backlog,

p.prjCreatedDate as [Win Date],
DATEADD(
    DAY,
    6,  -- 6 days after start-of-week = Saturday (assuming week starts Sunday)
    DATETRUNC(WEEK, CAST(p.prjCreatedDate AS date))
) AS [End of Week],

EOMONTH(DATEADD(
    DAY,
    6,  -- 6 days after start-of-week = Saturday (assuming week starts Sunday)
    DATETRUNC(WEEK, CAST(p.prjCreatedDate AS date))
)) as [Fiscal Date]

into #tmpthismonth
from Project p
left join Employee e on p.prjProjectManager = e.empKey
where prjIsDetailPhase = 0
and p.prjID not in ('OH-730', 'OH-780')
and p.prjID <> ''
and p.prjID <> 'Test'
and p.prjEntityDescription <> '900 - DDSHOLDCO LLC'

select 
-- [Year],
-- [Month],
-- [Week],
-- [Run Date],
[Project ID],
[Department],
[Project Manager],
[Supervisor],
[ProjectID & Description] as [Project ID & Description],
[Client],
[Project Status],
[Project Type],
[Billing Type],
[ContractAmount] as [Contract Amount],
[Backlog] as [Contract Backlog],
[Win Date],
[End of Week] as [Week Ending],
[Fiscal Date],
case when EOMONTH([End of Week]) = [Fiscal Date] then 'TRUE' else 'FALSE' end as [Won in Month]

from #tmpthismonth
--where [Win Date] <> '1905-01-01'
where month([Win Date]) = @CurrentMonth and year([Win Date]) = @CurrentYear 
order by [Fiscal Date] desc, [ContractAmount] desc
-- IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
--     DROP TABLE #tmp;

select
t.tKey,
t.tProject,
tMainProjectID,
ci.ciInvoiceNumber,
tProjectDescription,
--p.prjEntityDescription,
CASE 
    WHEN p.prjEntityDescription = 'Engineers - Survey' THEN 'Survey'
    WHEN p.prjEntityDescription = 'Engineers - Land Development' THEN 'Land'
    WHEN p.prjEntityDescription = 'Engineers - Gas Design' THEN 'Gas Design'
    WHEN p.prjEntityDescription = 'HOLDCO' then ''
END AS PhaseDepartment,
ci.ciInvoiceDate,
c.cDescription as Client_Name,
t.tBilledAmount,
EOMONTH(ci.ciInvoiceDate) AS FiscalDate,
p.prjProjectManagerName
--isnull(CASE WHEN ((ci.ciInvoiceDate BETWEEN '01-01-1900' AND '12-31-2078') OR (ci.ciBeginningBalanceType <> 0 AND	(t.tDate BETWEEN '01-01-1900' AND '12-31-2078'))) AND (t.tType<=1 OR t.tType=4)  AND (ci.ciStatus IS NOT NULL AND (ci.ciStatus=4 OR ci.ciStatus=5)) THEN 1 ELSE 0 END,0) as IsInvoiced
--into #tmp
from Trans t 
left join Project p on t.tProject = p.prjKey
left join ClientInvoice ci on t.tClientInvoice = ci.ciKey
left join Client c on c.cKey = ci.ciClient
where ci.ciInvoiceDate > '2023-09-30'
and tIsCurrent = 1
and isnull(CASE WHEN ((ci.ciInvoiceDate BETWEEN '01-01-1900' AND '12-31-2078') OR (ci.ciBeginningBalanceType <> 0 AND	(t.tDate BETWEEN '01-01-1900' AND '12-31-2078'))) AND (t.tType<=1 OR t.tType=4)  AND (ci.ciStatus IS NOT NULL AND (ci.ciStatus=4 OR ci.ciStatus=5)) THEN 1 ELSE 0 END,0) = 1

-- select 
-- tMainProjectID,
-- ciInvoiceNumber,
-- tProject,
-- tProjectDescription,
-- PhaseDepartment,
-- ciInvoiceDate,
-- FiscalDate,
-- tBilledAmount,
-- prjProjectManagerName
-- from #tmp
-- where IsInvoiced = 1



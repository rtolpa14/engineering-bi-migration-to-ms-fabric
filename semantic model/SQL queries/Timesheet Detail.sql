IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
    DROP TABLE #tmp;

select
t.tKey,
p.prjClientName,
--t.tKey,
t.tMainProjectID,
t.tProjectManagerName,
t.tMainProjectID + ' ' + t.tMainProjectDescription as ProjectID_and_Desc,
p2.prjEntityDescription as PhaseDepartment,
t.tProjectDescription as PhaseDescription,
--e.empPayrollServiceID,
vec.vecPayrollServiceID as EmployeeID,
--t.tEmployee,
t.tEmployeeName,
--t.tVendor,
v.vDescription,
--t.tActivity,
a.actDescription,
--t.tActivityType,
a.actTypeDescription,
--t.tEmployeeType,
et.etDescription,
t.tInvoiceEmployeeTypeDescription,
t.tDate,
case when t.tActivityType = 2 then 0.00 else t.tUnits end as Hours,
--tBilledUnits,
t.tBilledAmount,
t.tEarnedAmount,
t.tBurdenedCostAmount,
--t.tClientInvoice,
ci.ciInvoiceNumber
into #tmp
from Trans t
left join Timesheet ts on t.tTimesheet = ts.tsKey
left join Employee e on t.tEmployee = e.empKey
left join EmployeeType et on t.tEmployeeType = et.etKey
left join Activity a on t.tActivity = a.actKey
left join ClientInvoice ci on t.tClientInvoice = ci.ciKey
left join Vendor v on t.tVendor = v.vKey
left join Project p on t.tMainProjectID = p.prjID
left join Project p2 on t.tProject = p2.prjKey
left join AxVEC vec on t.tEmployee = vec.vecKey and vec.vecIsEmployee = 1
WHERE
--t.tMainProjectID = '72250344' and
tIsCurrent = 1
and tDate > '2023-09-30'
and t.tActivity <> ''
and t.tMainProjectID <> ''
and t.tMainProjectID is NOT NULL
order by t.tDate DESC

select 
sum(tBurdenedCostAmount) from #tmp where tMainProjectID = '71220391'

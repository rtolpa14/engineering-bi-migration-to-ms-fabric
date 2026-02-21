 IF OBJECT_ID('tempdb..#tmp') IS NOT NULL
     DROP TABLE #tmp;


select
[Transaction Key],
[Phase Key],
[Project ID],
[Project Manager],
[Project ID & Description],
[Phase ID & Description],
vec.vecPayrollServiceID as EmployeeID,
[Employee],
[Activity],
[Activity Type],
[Client Invoice Employee Type],
[Date],
EOMONTH([Date]) as FiscalDate,
Year([Date]) as [Year],
case when [Activity Type] = 'Expense' then 0.00 else [Units/Hours] end as [Hours],
[Billed Amount],
[Spent Amount],
-- [Cost Amount Burdened],
-- case when [Activity Type] = 'Expense' then [Units/Hours] else [Cost Amount Burdened] end as [Burdened Cost Fmla],
[Client Invoice Number],
ci.ciInvoiceDate as InvoiceDate
into #tmp
from TransactionInquiry t
left Join AxVEC vec on t.[Employee Key] = vec.vecKey and vec.vecIsEmployee = 1
left join ClientInvoice ci on t.[Client Invoice Key] = ci.ciKey
where
[Date] > '12/31/2023'
and [Activity] <> ''
and [Project ID] <> ''
--and [Is Invoiced] = 1
--and (ISNULL([Employee],'') NOT IN ('DESIGNER INTELASSIST', 'ENGINEER INTELASSIST'))
--and [Employee] in ('DESIGNER INTELASSIST', 'ENGINEER INTELASSIST')
order by [Date] DESC

select 
[FiscalDate],
sum([Spent Amount]) from #tmp
where [Date] > '1/1/2025' and [Date] < '11/1/2025'
group by [FiscalDate]
order by [FiscalDate] desc

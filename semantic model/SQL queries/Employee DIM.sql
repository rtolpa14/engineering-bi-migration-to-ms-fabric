select e.empKey,
e.empName,
e.empStatus,
e.empTitle,
e.empEntity,
e.empEntityDescription,
e.empUsername,
et.etDescription as [Type],
lower(e.empEmail) as empEmail,
e.empSupervisorName,
lower(e2.empEmail) as SuperVisorEmail
from Employee e
left join Employee e2 on e.empSupervisorName = e2.empName
left join EmployeeType et on e.empEmployeeType = et.etKey


select * from Employee where empName like '%INTELLASSIST%'
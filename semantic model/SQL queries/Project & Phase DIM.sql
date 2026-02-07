select top 100 * from Project

--Project DIM
SELECT
prjKey,
prjID,
prjClientName,
p.prjProjectManager,
e.empName as ProjectManager,
prjEntity,
prjEntityDescription,
case prjEntity
    when 2 then '710'
    when 3 then '700'
    when 4 then '720'
    when 6 then '900'
end as GroupNum,
case prjEntity
    when 2 then 'Gas Design'
    when 3 then 'Survey'
    when 4 then 'Land'
    when 6 then 'HOLDCO'
end as [GroupName],
prjStatus,
prjDescription
from Project p
left join Employee e on e.empKey = p.prjProjectManager
where prjIsDetailPhase = 0
and prjID <> ''



--Phase DIM
SELECT
p.prjKey,
p.prjProject,
p2.prjID,
p.prjClientName,
p.prjProjectManager,
e.empName AS ProjectManager,
p.prjEntity,
case p.prjEntity
    when 2 then '710'
    when 3 then '700'
    when 4 then '720'
    when 6 then '900'
end as GroupNum,
case p.prjEntity
    when 2 then 'Gas Design'
    when 3 then 'Survey'
    when 4 then 'Land'
    when 6 then 'HOLDCO'
end as [GroupName],
p.prjEntityDescription,
p.prjStatus,
p.prjDescription
from Project p
join Project p2 on p.prjProject = p2.prjKey
left join Employee e on e.empKey = p.prjProjectManager
where p.prjIsDetailPhase = 1
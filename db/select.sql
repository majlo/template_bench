select i.id as issue_id, sg.title as group_title, sg.description as group_description, s.name as step_name, s.label as step_label, st.name as step_type, ss.value as step_value
from issue i
left join step_status ss on i.id = ss.issue_id
inner join step s on s.id = ss.step_id
inner join step_group sg on sg.id = s.group_id
inner join step_type st on st.id = s.type_id
where i.id = 100000
order by s.group_id, s.weight;

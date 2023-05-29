<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cuis" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select id,organization,name,wikipedia_url,city,state,country,latitude,longitude,type,count from
				(select grid_id as id,organization,sum(count) as count from extraction.organization natural join extraction.organization_mention group by 1,2) as foo
			natural join
				(select institute.id,name,wikipedia_url,city,state,country,latitude,longitude,type from grid.institute,grid.address,grid.type where institute.id=address.id and institute.id=type.id) as bar
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"id", "label":"GRID ID"},
        {"value":"organization", "label":"Matched String"},
        {"value":"name", "label":"GRID Name"},
        {"value":"wikipedia_url", "label":"Wikipedia URL"},
        {"value":"city", "label":"City"},
        {"value":"state", "label":"State"},
        {"value":"country", "label":"Country"},
        {"value":"latitude", "label":"Latitude"},
        {"value":"longitude", "label":"Longitude"},
        {"value":"type", "label":"Type"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${cuis.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
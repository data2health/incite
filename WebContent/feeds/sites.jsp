<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="sites" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select name,institution,site_type as type,city,state,latitude,longitude,seed from 
				(select name,ror_id,type as site_type,seed from jsoup.crawler_seed) as foo
			natural left outer join
				(select id as ror_id,name as institution,city,state,latitude,longitude from ror.organization natural join ror.address) as bar
		  ) as done;
</sql:query>
{
    "headers": [
       {"value":"name", "label":"Organization"},
       {"value":"institution", "label":"Institution"},
       {"value":"type", "label":"Type"},
       {"value":"city", "label":"City"},
       {"value":"state", "label":"State"},
       {"value":"latitude", "label":"Latitude"},
       {"value":"longitude", "label":"Longitude"},
        {"value":"seed", "label":"Crawling Seed"}
    ],
    "rows" : 
<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
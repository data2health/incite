<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cuis" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select id,geonameid,location,name,latitude,longitude,feature_code,country,count from
				(select id,geonames_id as geonameid,location,sum(count) as count from extraction.location natural join extraction.location_mention group by 1,2,3) as foo
			natural join
				(select geonameid,name,latitude,longitude,feature_code,country from geonames.geoname) as bar
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"id", "label":"id"},
        {"value":"geonameid", "label":"Geoname ID"},
        {"value":"location", "label":"Location"},
        {"value":"name", "label":"Geoname"},
        {"value":"latitude", "label":"Latitude"},
        {"value":"longitude", "label":"Longitude"},
        {"value":"feature_code", "label":"Feature Code"},
        {"value":"country", "label":"Country"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${cuis.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
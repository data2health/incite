<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="concepts" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select id,${param.entity} as concept,sum(count) as count from extraction.${param.entity} natural join extraction.${param.entity}_mention group by 1
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"id", "label":"ID"},
       {"value":"concept", "label":"Concept"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${concepts.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
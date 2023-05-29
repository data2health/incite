<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="concepts" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select id,last_name,first_name,middle_name,title,appendix,sum(count) as count from extraction.person natural join extraction.person_mention group by 1
		  ) as done;
</sql:query>
{
    "headers": [
       {"value":"id", "label":"ID"},
       {"value":"last_name", "label":"Last Name"},
       {"value":"first_name", "label":"First Name"},
       {"value":"middle_name", "label":"Middle Name"},
       {"value":"title", "label":"Title"},
       {"value":"appendix", "label":"Appendix"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${concepts.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
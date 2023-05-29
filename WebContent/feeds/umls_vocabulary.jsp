<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cuis" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select cui,str,ancestor_str,root_str,count from
				(select umls_id as cui,sum(count) as count from extraction.${param.entity}_match natural join extraction.${param.entity}_mention group by 1) as foo
			natural join
				(select distinct cui,str,ancestor_str,root_str from umls_local.hierarchy_filtered5) as bar
			where root_str=? order by 2 desc,3
		  ) as done;
	<sql:param>${param.vocabulary}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"cui", "label":"CUI"},
        {"value":"str", "label":"Label"},
        {"value":"ancestor_str", "label":"Ancestor Label"},
        {"value":"root_str", "label":"Root"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${cuis.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="sites" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select type,count(*) from jsoup.crawler_seed group by 1 order by count desc
		  ) as done;
</sql:query>
<c:forEach items="${sites.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
			
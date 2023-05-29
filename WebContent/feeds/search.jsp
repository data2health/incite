<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="search" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select institution.domain,regexp_replace(sentence,'${util:replaceIgnoreCase(param.term," +","|")}',E'<b>\\&</b>','ig') as sentence,count(*)
           from extraction.sentence,jsoup.document,jsoup.institution
           where sentence.id=document.id and document.did=institution.did and tsv @@ plainto_tsquery(?)
           group by 1,2 order by 1,3 desc
		  ) as done;
	<sql:param>${param.term}</sql:param>
</sql:query>
{
    "headers": [
       {"value":"domain", "label":"Domain Name"},
       {"value":"sentence", "label":"Distinct Sentence"},
       {"value":"count", "label":"# of Occurrences on Site"}
    ],
    "rows" : 
<c:forEach items="${search.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}
			
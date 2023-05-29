<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="sentences" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select distinct sentence.id,${param.entity},regexp_replace(sentence,${util:replaceIgnoreCase(param.entity," +","|")},E'<b>\\&</b>','ig') as sentence,url,title
			from extraction.sentence, extraction.${param.entity}, extraction.${param.entity}_mention, jsoup.document 
			where sentence.id=document.id and sentence.id=pmcid and sentence.seqnum=segnum and setnum=sentnum and ${param.entity}.id=${param.entity}_mention.id
			and ${param.entity}_mention.id=?::int
		  ) as done;
	<sql:param>${param.id}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"id", "label":"Document ID"},
        {"value":"${param.entity}", "label":"${param.entity}"},
        {"value":"sentence", "label":"Sentence"},
        {"value":"title", "label":"Document Title"},
        {"value":"url", "label":"URL"}
    ],
    "rows" : 
<c:forEach items="${sentences.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

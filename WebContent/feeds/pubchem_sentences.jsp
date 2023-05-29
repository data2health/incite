<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="sentences" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select distinct sentence.id,regexp_replace(sentence,substance,E'<b>\\&</b>','ig') as sentence,url,title
			from extraction.sentence, extraction.substance_mention, extraction.substance, jsoup.document 
			where sentence.id=document.id and sentence.id=pmcid and substance_mention.sid=substance.sid and seqnum=segnum and setnum=sentnum and substance.sid=?::int
		  ) as done;
	<sql:param>${param.sid}</sql:param>
</sql:query>
{
    "headers": [
        {"value":"id", "label":"Document ID"},
        {"value":"sentence", "label":"Sentence"},
        {"value":"title", "label":"Document Title"},
        {"value":"url", "label":"URL"}
    ],
    "rows" : 
<c:forEach items="${sentences.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:query var="cuis" dataSource="jdbc/AcknowledgementsTagLib">
	select jsonb_pretty(jsonb_agg(done))
	from ( select sid,substance,mesh,pharm,count from
				(select sid,substance,sum(count) as count from extraction.substance natural join extraction.substance_mention group by 1,2) as foo
			natural join
				(select sid,sid_mesh.mesh,pharm from pubchem_substance.sid_mesh,pubchem_substance.mesh_pharm where sid_mesh.mesh = mesh_pharm.mesh) as bar
		  ) as done;
</sql:query>
{
    "headers": [
        {"value":"sid", "label":"SID"},
        {"value":"substance", "label":"Substance"},
        {"value":"mesh", "label":"MeSH"},
        {"value":"pharm", "label":"Parm"},
        {"value":"count", "label":"Count"}
    ],
    "rows" : 
<c:forEach items="${cuis.rows}" var="row" varStatus="rowCounter">
	${row.jsonb_pretty}
</c:forEach>
}

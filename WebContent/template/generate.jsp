<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
    <jsp:param name="title" value="SciTS API" />
</jsp:include>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
    <jsp:include page="../header.jsp" flush="true" />
 		<div class="row" style="margin-top: 30px;">
			<div class="col col-12 col-md-2">
				<jsp:include page="/menu.jsp" flush="true">
					<jsp:param name="caller" value="research" />
				</jsp:include>
			</div>
			<div class="col col-12 col-md-10">
			<h3>Fragment: ${param.fragment }</h3>
			
           <jsp:include page="syntaxTree.jsp" flush="true">
                <jsp:param name="tgrep" value='${param.fragment }' />
           </jsp:include>
             <div id=others style=" float:right; width:40%">
               <sql:query var="templates" dataSource="jdbc/InCiteTagLib">
                    select mode,tgrep,relation,slot0,slot1
                    from extraction.template
                    where fragment = ?
                    order by 1,2,3;
                    <sql:param value="${param.fragment}"/>
                </sql:query>
                <c:if test="${templates.rowCount > 0}">
                <table>
                    <tr><th>mode</th><th>tgrep</th><th>relation</th><th>slot0</th><th>slot1</th></tr>
                <c:forEach items="${templates.rows}" var="row" varStatus="rowCounter">
                    <tr><td>${row.mode}</td><td>${row.tgrep}</td><td>${row.relation}</td><td>${row.slot0}</td><td>${row.slot1}</td></tr>
                </c:forEach>
                </table>
                </c:if>
            </div>
            <div id=mode style=" float:left; width:100%">
             
            <form method='GET' action='submit.jsp'>
			<a href='suppress.jsp?fragment=${param.fragment}&source=${param.source}&tgrep=${param.pattern}'>Suppress</a>
			| <a href='defer.jsp?fragment=${param.fragment}&source=${param.source}&&tgrep=${param.pattern}'>Defer</a>
            | <a href='complete.jsp?fragment=${param.fragment}&source=${param.source}&&tgrep=${param.pattern}'>Completed</a>
            | <a href='browse_unbound.jsp?source=${param.source}'>Browse</a>
			| <button type="submit" name="action" value="submit">Submit</button>
			| <button type="submit" name="action" value="return">Submit&Return</button>
			| tgrep: <input type="text" id="tgrep" name="tgrep" size="30" value="">
			<input type="hidden" name="pattern" value="${param.pattern}">
            <input type="hidden" name="fragment" value='${param.fragment}'>
            <input type="hidden" name="source" value='${param.source}'>
			</div>
			
			<div id=mode style=" float:left; width:100px">
			<h4>Mode</h4>
               <sql:query var="modes" dataSource="jdbc/InCiteTagLib">
                    select mode,sum(count)
                    from (
                    	select mode,count(*) from extraction.template group by 1
                    union
                    	select name as mode,count(*) from extraction.component where element='mode' group by 1
                    ) as foo
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="mode_${row.mode}" name=mode type="radio" value="${row.mode}" <c:if test="${row.mode == 'instantiate' || row.mode == 'promote'}">onclick="reset_relation();reset_slot0();reset_slot1();"</c:if> > ${row.mode}<br>
                </c:forEach>
			</div>
            <div id=relation style=" float:left; width:150px">
            <h4>Relation</h4>
               <sql:query var="modes" dataSource="jdbc/InCiteTagLib">
                    select relation,sum(count)
                     from (
                    	select relation,count(*) from extraction.template where relation is not null group by 1
                    union
                    	select name as relation,count(*) from extraction.component where element='relation' group by 1
                    ) as foo
                    group by 1
                    order by 2 desc, 1;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <c:if test="${rowCounter.index != 0 && rowCounter.index % 6 == 0}">
                        </div><div id=relation style=" float:left; width:180px"><h4>Relation, con't.</h4>
                    </c:if>
                    <input id="relation_${row.relation}" name=relation type="radio" value="${row.relation}"> ${row.relation}<br>
                </c:forEach>
             </div>
            <div id=slot0 style=" float:left; width:160px">
            <h4>Slot 0</h4>
                <sql:query var="modes" dataSource="jdbc/InCiteTagLib">
                    select slot0,sum(count)
                     from (
                    	select slot0,count(*) from extraction.template where slot0 is not null group by 1
                    union
                    	select name as slot0,count(*) from extraction.component where element='slot0' group by 1
                    ) as foo
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="slot0_${row.slot0}" name=slot0 type="radio" value="${row.slot0}"> ${row.slot0}<br>
                </c:forEach>
            </div>
            <div id=slot1 style=" float:left; width:150px">
            <h4>Slot 1</h4>
                 <sql:query var="modes" dataSource="jdbc/InCiteTagLib">
                    select slot1,sum(count)
                     from (
                    	select slot1,count(*) from extraction.template where slot1 is not null group by 1
                    union
                    	select name as slot1,count(*) from extraction.component where element='slot1' group by 1
                    ) as foo
                    group by 1
                    order by 2 desc;
                </sql:query>
                <c:forEach items="${modes.rows}" var="row" varStatus="rowCounter">
                    <input id="slot1_${row.slot1}" name=slot1 type="radio" value="${row.slot1}"> ${row.slot1}<br>
                </c:forEach>
            </div>
            <div id=samples style=" float:left; width:100%">
            <h4>Highest Frequency Text Fragments</h4>
            <table>
                <tr>
                    <th>Frequency</th>
                    <th>Fragment</th>
                    <th>Vocabulary</th>
                </tr>
                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select node,count(*) as frequency
                    from extraction.fragment
                    where fragment = ?
                    group by 1
                    order by 2 desc limit 100;
                    <sql:param>${param.fragment}</sql:param>
                </sql:query>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                    <tr>
                        <td align=right>${row.frequency}</td>
                        <td>${row.node}</td>
                        <td><a href="filter.jsp?node=${row.node}&tgrep=${param.fragment}&source=${param.source}">filter</a></td>
                    </tr>
                </c:forEach>
            </table>

			<c:choose>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'BiologicalFunction ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_biological_function").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'BodyPart ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organism").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Collaboration ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_collaboration").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Disease ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_disease").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Event ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Finding ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_finding").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'FirstName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Grant ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_award").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Injury ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_finding").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'LastName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'OrganicChemical ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organic_chemical").checked = true;
                        autoset = false;
                    </script>
                </c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Organism ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organism").checked = true;
                        autoset = false;
                    </script>
                </c:when>
				<c:when	test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Organization ]')}">
					<script type="text/javascript">
						document.getElementById("mode_instantiate").checked = true;
						document.getElementById("relation_organization").checked = true;
						autoset = false;
					</script>
				</c:when>
               <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'PathologicalFuntion ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_biological_function").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Person ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                 <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'PhysiologicalFunction ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_biological_function").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Place ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'PlaceName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_location").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Program ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_program").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Project ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_project").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'PubChemSubstance ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_substance").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Resource ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'SuffixName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Support ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                 <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Technique ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_technique").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'TitleName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person_concept").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'action ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
                <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'electronics ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
              <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'entityAggregator ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person_concept").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'establishment ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organization").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'emergence ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_emergence").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'event ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'geography ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_location").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'information ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_finding").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'leader ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person_concept").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'livingEntity ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organism").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'location ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_location").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'organization ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organization").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'outbreak ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_outbreak").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'person ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_person_concept").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'placeName ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_location").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'process ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_process").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'quantity ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'sign ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'Service ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_service").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'substance ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'time ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_event").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'transportation ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'vegetable ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_organism").checked = true;
                        autoset = false;
                    </script>
                </c:when>
    	        <c:when test="${fn:indexOf(fn:substringAfter(param.fragment, '['),'[') < 0 && fn:endsWith(param.fragment, 'weapon ]')}">
                    <script type="text/javascript">
                        document.getElementById("mode_instantiate").checked = true;
                        document.getElementById("relation_resource").checked = true;
                        autoset = false;
                    </script>
                </c:when>
			</c:choose>
			</div>
			</div>

	</div>
</body>
</html>


<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="ack"
	uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Document</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<jsp:include page="/menu.jsp" flush="true"><jsp:param
				name="caller" value="research" /></jsp:include><div id="centerCol">

			<table>
				<sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select url,title,length,modified,indexed,visited,did,suffix,response_code
                    from web.document
                    where id = ?::int
                    <sql:param>${param.id}</sql:param>
				</sql:query>
				<c:forEach items="${fragments.rows}" var="row"
					varStatus="rowCounter">
					<tr>
						<th>URL</th>
						<td>${row.url}</td>
					</tr>
					<tr>
						<th>Title</th>
						<td>${row.title}</td>
					</tr>
					<tr>
						<th>Length</th>
						<td>${row.length}</td>
					</tr>
					<tr>
						<th>Modified</th>
						<td>${row.modified}</td>
					</tr>
					<tr>
						<th>Indexed</th>
						<td>${row.indexed}</td>
					</tr>
					<tr>
						<th>Visited</th>
						<td>${row.visited}</td>
					</tr>
					<tr>
						<th>DID</th>
						<td>${row.did}</td>
					</tr>
					<tr>
						<th>Suffix</th>
						<td>${row.suffix}</td>
					</tr>
					<tr>
						<th>Response Code</th>
						<td>${row.response_code}</td>
					</tr>
					</tr>
				</c:forEach>
			</table>

                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select person.id, first_name,last_name,middle_name,title,appendix
                    from entity.person,entity.person_mention
                    where person_mention.id = ?::int
                    and person.id = person_mention.person_id
                    order by last_name,first_name
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>Person</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td><a href="<util:applicationRoot/>/person/person.jsp?id=${row.id}">${row.last_name}, ${row.first_name}</a></td></tr>
                </c:forEach>
                </table>

                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select organization.id,organization
                    from entity.organization,entity.organization_mention
                    where organization_mention.id = ?::int
                    and organization.id = organization_mention.organization_id
                    order by organization
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>Organization</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td><a href="<util:applicationRoot/>/organization/organization.jsp?id=${row.id}">${row.organization}</a></td></tr>
                </c:forEach>
                </table>

                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select distinct award
                    from web.award
                    where id = ?::int
                    order by award
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>Grant</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td>${row.award}</td></tr>
                </c:forEach>
                </table>

                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select distinct pmid
                    from web.pmid
                    where id = ?::int
                    order by pmid
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>PMID</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td>${row.pmid}</td></tr>
                </c:forEach>
                </table>

               <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select distinct doi
                    from web.doi
                    where id = ?::int
                    order by doi
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>DOI</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td>${row.doi}</td></tr>
                </c:forEach>
                </table>

              <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select url,anchor from web.hyperlink,web.document where hyperlink.target=document.id and hyperlink.id=?::int and anchor is not null order by seqnum
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>Hyperlink</th><th>Anchor Text</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td>${row.url}</td><td>${row.anchor}</td></tr>
                </c:forEach>
                </table>

                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select sentence
                    from web.sentence
                    where id = ?::int
                    order by seqnum
                    <sql:param>${param.id}</sql:param>
                </sql:query>
                <table>
                <tr><th>Sentence</th></tr>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                <tr><td>${row.sentence}</td></tr>
                </c:forEach>
                </table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>


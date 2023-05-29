<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
 		<jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include>
 	   <div class="container pl-0 pr-0">
        <br /> <br />
        <div class="container-fluid">
        	<a href="browse_unbound.jsp?source=simple">simple</a> | <a href="browse_unbound.jsp?source=promo">promo</a> | <a href="browse_unbound.jsp?source=nested">nested</a>

            <h3>Unbound fragments</h3>
            <table>
                <tr>
                    <th>Frequency</th>
                    <th>Fragment</th>
                </tr>
                <sql:query var="fragments" dataSource="jdbc/InCiteTagLib">
                    select fragment,count
					<c:choose>
						<c:when test="${param.source == 'simple' }">
		                    from extraction.fragment_candidate_simple /* where fragment~'Grant' */
						</c:when>
						<c:when test="${param.source == 'promo' }">
        		            from extraction.fragment_candidate where fragment ~ '^\[NP \[NP:'
						</c:when>
						<c:otherwise>
		                    from extraction.fragment_candidate where fragment ~ '^\[.*\['
						</c:otherwise>
					</c:choose>
                    order by 2 desc, 1 limit 100;
                </sql:query>
                <c:forEach items="${fragments.rows}" var="row" varStatus="rowCounter">
                    <tr>
                        <td align=right>${row.count}</td>
                        <td><a href='generate.jsp?fragment=${row.fragment}&source=${param.source}'>${row.fragment}</a></td>
                        <td><a href='suppress.jsp?fragment=${row.fragment}&source=${param.source}&tgrep=${param.tgrep}'>suppress</a></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td><a href='defer.jsp?fragment=${row.fragment}&source=${param.source}'>defer</a></td>
                    </tr>
                </c:forEach>
            </table>
			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>


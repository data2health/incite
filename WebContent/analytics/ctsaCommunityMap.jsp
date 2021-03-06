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
<title>Domain Graph</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
    <div id="content"><jsp:include page="/header.jsp" flush="true" />
        <jsp:include page="/menu.jsp" flush="true"><jsp:param
                name="caller" value="research" /></jsp:include><div id="centerCol">

                <c:url var="encodedMapURL" value="ctsaCommunityMapData.jsp">
                    <c:param name="detectionAlg" value="${param.detectionAlg}"/>
                    <c:param name="resolution" value="10"/>
                    <c:param name="mode" value="${param.mode}"/>
                    <c:param name="query" value="${param.query}"/>
                    <c:param name="selectedNode" value="${param.selectedNode}"/>
                    <c:param name="radius" value="${param.radius}"/>
                </c:url>
                <jsp:include page="forceGraph.jsp" flush="true">
                    <jsp:param name="charge" value="-50" />
                    <jsp:param name="ld" value="30" />
                    <jsp:param name="data_page" value="${encodedMapURL}" />
                    <jsp:param name="detectionAlg" value="${param.detectionAlg}"/>
                </jsp:include>

            <jsp:include page="/footer.jsp" flush="true" /></div>
    </div>
</body>
</html>


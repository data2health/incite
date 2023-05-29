<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="head.jsp" flush="true" />
<title>InCite 1.0</title>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<div class="row" style="margin-top: 30px;">
			<div class="col col-12 col-md-2">
				<jsp:include page="/menu.jsp" flush="true">
					<jsp:param name="caller" value="research" />
				</jsp:include>
			</div>
			<div class="col col-12 col-md-10">
				<h1>CD2H InCite</h1>
				<div id='biological_function-list'></div>
				Initial deployment of an app supporting exploration of the CTSA Consortium web presence.
				<h2>Sites Currently Crawled</h2>
				<div id='sites-list'></div>
				<jsp:include page="/footer.jsp" flush="true" />
			</div>
		</div>
	</div>
	<jsp:include page="tables/sites.jsp">
		<jsp:param name="entity" value="sites" />
	</jsp:include>
</body>
</html>


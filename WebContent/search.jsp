<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="head.jsp" flush="true">
	<jsp:param name="title" value="CTSA Consortium Landscape" />
</jsp:include>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>

<body>
	<div id="content">
		<jsp:include page="/header.jsp" flush="true" />
		<div class="row" style="margin-top: 30px;">
			<div class="col col-12 col-md-2">
				<jsp:include page="/menu.jsp" flush="true">
					<jsp:param name="caller" value="research" />
				</jsp:include>
			</div>
			<div class="col col-12 col-md-10">
				<h1>CTSA Website Exploration</h1>
				Enter a term of interest and click submit:
				<form action="search.jsp">
					<input name="term" value="${param.term}" size=50> <input type=submit name=submitButton value=Search>
				</form>
				<c:if test="${not empty param.term}">
					<p>
					<p>
					<h3>${param.term}</h3>
					<div id='search-list'></div>
					<jsp:include page="tables/search.jsp">
						<jsp:param name="term" value="${param.term}" />
					</jsp:include>
				</c:if>
			</div>
		</div>
	</div>
	<div id="contentBlock">
		<jsp:include page="footer.jsp" flush="true" />
	</div>
</body>

</html>

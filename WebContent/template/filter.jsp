<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<table border="1">
<tr><th>source</th><td>${param.source}</td></tr>
<tr><th>node</th><td>${param.node}</td></tr>
<tr><th>tgrep</th><td>${param.tgrep}</td></tr>
</table>

<table border="1">
<tr><th>Index</th><th>Node</th><th>tgrep</th><th>action</th></tr>
<c:forEach begin="0" end="${fn:length(fn:split(param.node,' ')) - 1}" varStatus="loop">
	<c:if test="${not empty util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$') && not empty util:regexMatch(fn:split(param.tgrep,' ')[loop.index],'.*:(.*)$')}">
	    <tr>
	    	<td>${loop.index}</td>
	    	<td>${util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$')}</td>
	    	<td>${util:regexMatch(fn:split(param.tgrep,' ')[loop.index],'.*:(.*)$')}</td>
	    	<td><a href="filter_suppress.jsp?node=${param.node}&term=${util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$')}&entity=${util:regexMatch(fn:split(param.tgrep,' ')[loop.index],'.*:(.*)$')}&fragment=${param.tgrep}&source=${param.source}">suppress</a></td>
		</tr>
	</c:if>
    <br/>
</c:forEach>
</table>
<p>

<table border="1">
<tr><th>Index</th><th>Node</th><th>tgrep</th><th>Service</th></tr>
<c:forEach begin="0" end="${fn:length(fn:split(param.node,' ')) - 1}" varStatus="loop">
	<c:if test="${not empty util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$')}">
	    <tr>
	    	<td>${loop.index}</td>
	    	<td>${util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$')}</td>
	    	<td>${util:regexMatch(fn:split(param.tgrep,' ')[loop.index],'.*:(.*)$')}</td>
	    	<td><a href="filter_detect.jsp?node=${param.node}&term=${util:regexMatch(fn:split(param.node,' ')[loop.index],'(.*)/[A-Z]+$')}&entity=Service&fragment=${param.tgrep}&source=${param.source}">detect</a></td>
		</tr>
	</c:if>
    <br/>
</c:forEach>
</table>
<p>

<a href='generate.jsp?fragment=${param.tgrep}&source=${param.source}'>${param.tgrep}</a>
</p>
</div>
</div>
</body>
</html>

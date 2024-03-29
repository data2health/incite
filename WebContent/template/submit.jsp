<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<c:if test="${param.mode == 'instantiate' }">
    <sql:update dataSource="jdbc/InCiteTagLib">
        insert into extraction.template(fragment,tgrep,mode,relation) values(?,?,?,?)
        <sql:param>${param.fragment}</sql:param>
        <sql:param>${param.tgrep}</sql:param>
        <sql:param>${param.mode}</sql:param>
        <sql:param>${param.relation}</sql:param>
    </sql:update>
</c:if>
<c:if test="${param.mode == 'promote' }">
    <sql:update dataSource="jdbc/InCiteTagLib">
        insert into extraction.template(fragment,tgrep,mode) values(?,?,?)
        <sql:param>${param.fragment}</sql:param>
        <sql:param>${param.tgrep}</sql:param>
        <sql:param>${param.mode}</sql:param>
    </sql:update>
</c:if>
<c:if test="${param.mode == 'store' }">
    <sql:update dataSource="jdbc/InCiteTagLib">
        insert into extraction.template(fragment,tgrep,mode,relation,slot0,slot1) values(?,?,?,?,?,?)
        <sql:param>${param.fragment}</sql:param>
        <sql:param>${param.tgrep}</sql:param>
        <sql:param>${param.mode}</sql:param>
        <sql:param>${param.relation}</sql:param>
        <sql:param>${param.slot0}</sql:param>
        <sql:param>${param.slot1}</sql:param>
    </sql:update>
</c:if>

<c:if test="${param.action == 'return'}">
	<c:redirect url="generate.jsp">
		<c:param name="fragment" value='${param.fragment}' />
		<c:param name="pattern" value="${param.pattern}" />
		<c:param name="source" value="${param.source}" />
	</c:redirect>
</c:if>
<c:if test="${param.action == 'submit'}">
	<c:redirect url="browse_unbound.jsp">
		<c:param name="fragment" value='${param.fragment}' />
		<c:param name="tgrep" value="${param.pattern}" />
		<c:param name="source" value="${param.source}" />
	</c:redirect>
</c:if>

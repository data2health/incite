<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:update dataSource="jdbc/InCiteTagLib">
    insert into extraction.vocabulary values(?,?,'ignore');
    <sql:param>${param.term}</sql:param>
    <sql:param>${param.entity}</sql:param>
</sql:update>
<sql:update dataSource="jdbc/InCiteTagLib">
    delete from extraction.fragment where node = ?;
    <sql:param>${param.node}</sql:param>
</sql:update>
<c:redirect url='generate.jsp?fragment=${param.fragment}&source=${param.source}' />

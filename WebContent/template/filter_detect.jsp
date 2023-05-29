<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<sql:update dataSource="jdbc/InCiteTagLib">
    insert into extraction.vocabulary values(?,?,'detect');
    <sql:param>${param.term}</sql:param>
    <sql:param>${param.entity}</sql:param>
</sql:update>
<c:redirect url='generate.jsp?fragment=${param.fragment}&source=${param.source}' />

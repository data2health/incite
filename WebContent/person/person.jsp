<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Person List</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:person ID="${param.id}">
   <table>
    <tr><th>First Name</th><td><ack:personFirstName/></td></tr>
    <tr><th>Middle Name</th><td><ack:personMiddleName/></td></tr>
    <tr><th>Last Name</th><td><ack:personLastName/></td></tr>
    <tr><th>Title</th><td><ack:personTitle/></td></tr>
    <tr><th>Appendix</th><td><ack:personAppendix/></td></tr>
   </table>
   

   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachPersonMention var="prov" sortCriteria="pmcid">
    <ack:personMention>
        <li><a href="<util:applicationRoot/>/document/document.jsp?id=<ack:personMentionPmcid/>"><ack:personMentionPmcid/></a>
    </ack:personMention>
   </ack:foreachPersonMention>
   </ol>

   </ack:person>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>


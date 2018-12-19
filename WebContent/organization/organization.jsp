<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ack" uri="http://icts.uiowa.edu/AcknowledgementsTagLib"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Organization</title>
<style type="text/css" media="all">    @import "<util:applicationRoot/>/resources/style.css";</style></head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" /> <jsp:include page="/menu.jsp" flush="true"><jsp:param name="caller" value="research" /></jsp:include><div id="centerCol">
   <ack:organization ID="${param.id}">
   <table>
    <tr><th>Organization</th><td><ack:organizationOrganization/></td></tr>
    <tr><th>GRID ID</th><td><ack:organizationGridId/></td></tr>
    <tr><th>GRID match string</th><td><ack:organizationGridMatchString/></td></tr>
    <tr><th>GeoNames ID</th><td><ack:organizationGeonamesId/></td></tr>
    <tr><th>GeoNames match string</th><td><ack:organizationGeonamesMatchString/></td></tr>
   </table>
   

   <h4>Mentions</h4>
   <ol class="bulletedList">
   <ack:foreachOrganizationMention var="prov" sortCriteria="pmcid">
    <ack:organizationMention>
        <li><a href="<util:applicationRoot/>/document/document.jsp?id=<ack:organizationMentionPmcid/>"><ack:organizationMentionPmcid/></a>
    </ack:organizationMention>
   </ack:foreachOrganizationMention>
   </ol>
   </ol>

   </ack:organization>

<jsp:include page="/footer.jsp" flush="true" /></div></div></body>
</html>


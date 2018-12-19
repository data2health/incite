<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="graph" uri="http://slis.uiowa.edu/graphtaglib"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<graph:graph>
    <sql:query var="nodes" dataSource="jdbc/InCiteTagLib">
        select did, domain, name, count
        from analytics.domain_node
    </sql:query>
    <c:forEach items="${nodes.rows}" var="row" varStatus="rowCounter">
        <graph:node uri="${row.did}" label="${row.domain}"  group="1"  score="${row.count}" />
    </c:forEach>

    <sql:query var="edges" dataSource="jdbc/InCiteTagLib">
        select source_did, target_did, count
        from analytics.domain_edge
    </sql:query>
    <c:forEach items="${edges.rows}" var="row" varStatus="rowCounter">
        <graph:edge source="${row.source_did}" target="${row.target_did}"  weight="${row.count}" />
    </c:forEach>

{
  "nodes":[
    <graph:foreachNode pruneOrphanThreshold="50">
        <graph:node>
            {"url":"<graph:nodeUri/>","name":"<graph:nodeLabel/>","group":<graph:nodeGroup/>,"score":<graph:nodeScore/>}<c:if test="${ ! isLastNode }">,</c:if>
        </graph:node>
    </graph:foreachNode>
  ],
  "links":[
    <graph:foreachEdge>
        <graph:edge>
            {"source":<graph:edgeSource/>,"target":<graph:edgeTarget/>,"value":<graph:edgeWeight/>}<c:if test="${ ! isLastEdge }">,</c:if>
        </graph:edge>
    </graph:foreachEdge>
  ]
}
</graph:graph>

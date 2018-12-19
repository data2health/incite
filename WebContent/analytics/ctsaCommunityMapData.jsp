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
        <graph:foreachNode pruneOrphanThreshold="100" > 
            <graph:node auxDouble="${param.resolution}" coloring="${param.detectionAlg}">
                {"url":"<graph:nodeUri/>","name":"<graph:nodeLabel/>","group":<graph:nodeGroup/>,"score":<graph:nodeScore/>,
            </graph:node>
            <graph:node auxDouble="${param.resolution}" coloring="site">
                "site":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="0.01" coloring="Louvain">,
                "Louvain001":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="0.1" coloring="Louvain">,
                "Louvain01":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="1" coloring="Louvain">,
                "Louvain1":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="10" coloring="Louvain">,
                "Louvain10":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="100" coloring="Louvain">,
                "Louvain100":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="0.01" coloring="LouvainMultilevelRefinement">,
                "LouvainMultilevelRefinement001":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="0.1" coloring="LouvainMultilevelRefinement">,
                "LouvainMultilevelRefinement01":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="1" coloring="LouvainMultilevelRefinement">,
                "LouvainMultilevelRefinement1":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="10" coloring="LouvainMultilevelRefinement">,
                "LouvainMultilevelRefinement10":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="100" coloring="LouvainMultilevelRefinement">,
                "LouvainMultilevelRefinement100":<graph:nodeGroup/>
            </graph:node>
                    <graph:node auxDouble="0.01" coloring="SmartLocalMoving">,
                "SmartLocalMoving001":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="0.1" coloring="SmartLocalMoving">,
                "SmartLocalMoving01":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="1" coloring="SmartLocalMoving">,
                "SmartLocalMoving1":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="10" coloring="SmartLocalMoving">,
                "SmartLocalMoving10":<graph:nodeGroup/>
            </graph:node>
            <graph:node auxDouble="100" coloring="SmartLocalMoving">,
                "SmartLocalMoving100":<graph:nodeGroup/>}<c:if test="${ ! isLastNode }">,</c:if>
            </graph:node>
        </graph:foreachNode>
        ],
      "links":[
        <graph:foreachEdge>
            <graph:edge>
                {"source":<graph:edgeSource/>,"target":<graph:edgeTarget/>,"value":<graph:edgeWeight/>}<c:if test="${ ! isLastEdge }">,</c:if>
            </graph:edge>
        </graph:foreachEdge>
      ],
      "sites":[
        ]
    }
    
    
</graph:graph>

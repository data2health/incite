<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<style>
.node {
    stroke: #fff;
    stroke-width: 1.5px;
}

text {
    stroke: #000;
    stroke-width: 0.0px;
    font: 9px sans-serif;
    pointer-events: none;
}

.link {
    stroke: #999;
    stroke-opacity: .6;
}
</style>
<script src="../resources/d3.v3.min.js"></script>
<script>

var width = 2500,
    height = 2500,
    radius = 4,
    charge = -50,
    linkDistance = 30;
    
<c:if test="${not empty param.charge}">
    charge = -${param.charge};
</c:if>
<c:if test="${not empty param.linkDistance}">
    linkDistance = ${param.linkDistance};
</c:if>

var color = d3.scale.category10();

var force = d3.layout.force()
    .charge(charge)
    .linkDistance(linkDistance)
    .size([width, height]);

var svg = d3.select("#graph").append("svg")
    .attr("xmlns","http://www.w3.org/2000/svg")
    .attr("width", width)
    .attr("height", height);

d3.json("${param.data_page}", function(error, graph) {
  force
      .nodes(graph.nodes)
      .links(graph.links)
      .start();

    var rScale = d3.scale.linear()
     .domain([0, d3.max(graph.nodes, function(d) { return d.score; })])
     .range([3, 50]);

    var eScale = d3.scale.linear()
    .domain([0, d3.max(graph.links, function(d) { return d.value; })])
    .range([1, 5]);

    var link = svg.selectAll(".link")
      .data(graph.links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return eScale(d.value); });

  var node = svg.selectAll(".node")
      .data(graph.nodes)
    .enter().append("g")
      .attr("class", "node")
        .on("dblclick", function(d) { window.open("persons/person.jsp?pid="+d.url+"&year=${param.year}","_self");})
       .call(force.drag);
  
  node.append("circle")
      .attr("r", function(d) { return rScale(d.score); })
      .style("fill", function(d) { return color(d.group); });

  node.append("text")
    .attr("x", function(d) { return rScale(d.score) + 5; })
        .attr("dy", ".35em")
     .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x = Math.max(radius, Math.min(width - d.score, d.x)); })
        .attr("cy", function(d) { return d.y = Math.max(radius, Math.min(height - d.score, d.y)); })
    .attr("transform", function(d) { return "translate(" + d.x + "," + d.y + ")"; });
  });
});

</script>
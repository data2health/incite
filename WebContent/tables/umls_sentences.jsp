<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
$.getJSON("<util:applicationRoot/>/feeds/umls_sentences.jsp?entity=${param.entity}&cui=${param.cui}", function(data){
		
	var json = $.parseJSON(JSON.stringify(data));

	var col = [];

	for (i in json['headers']){
		col.push(json['headers'][i]['label']);
	}


	var table = document.createElement("table");
	table.className = 'table table-hover';
	table.style.width = '100%';
	table.style.textAlign = "left";
	table.id="${param.entity}-table";

	var header= table.createTHead();
	var header_row = header.insertRow(0); 

	for (i in col) {
		var th = document.createElement("th");
		th.innerHTML = '<span style="color:#333; font-weight:600; font-size:16px;">' + col[i].toString() + '</span>';
		header_row.appendChild(th);
	}

	var divContainer = document.getElementById("${param.entity}-sentences");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#${param.entity}-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[0, 'asc']],
     	columns: [
        	{ data: 'id', orderable: true },
        	{ data: '${param.entity}', orderable: true },
        	{ data: 'sentence', orderable: true },
        	{ data: 'title',
          	  orderable: true,
       		  render: function ( data, type, row ) {
      			if (row.title == '')
      				return '<a href="' + row.url + '"><span style="color:#376076";>' +  row.url + '<\/span></a>';
      			else
          			return '<a href="' + row.url + '"><span style="color:#376076";>' +  row.title + '<\/span></a>';
           	  }
          	  },
        	{ data: 'url', visible: false, orderable: true}
    	]
	} );

	
});
</script>

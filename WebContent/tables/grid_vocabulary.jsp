<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
$.getJSON("<util:applicationRoot/>/feeds/grid_vocabulary.jsp", function(data){
		
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

	var divContainer = document.getElementById("${param.entity}-list");
	divContainer.innerHTML = "";
	divContainer.appendChild(table);

	var data = json['rows'];

	$('#${param.entity}-table').DataTable( {
    	data: data,
       	paging: true,
    	pageLength: 10,
    	lengthMenu: [ 10, 25, 50, 75, 100 ],
    	order: [[10, 'desc']],
     	columns: [
        	{ data: 'id',
        	  orderable: true,
     		  render: function ( data, type, row ) {
      			return '<a href="<util:applicationRoot/>/organization/sentences.jsp?id=' + row.id + '&concept=' + row.organization + '"><span style="color:#376076";>' +  row.id + '<\/span></a>';
         	  }
        	  },
        	{ data: 'organization', orderable: true },
        	{ data: 'name',
          	  orderable: true,
       		  render: function ( data, type, row ) {
      			if (row.wikipedia_url == null || row.wikipedia_url == '')
      				return row.name;
      			else
      				return '<a href="' + row.wikipedia_url + '"><span style="color:#376076";>' +  row.name + '<\/span></a>';
           	  }
          	  },
        	{ data: 'wikipedia_url', visible: false, orderable: true },
        	{ data: 'city', orderable: true },
        	{ data: 'state', orderable: true },
        	{ data: 'country', orderable: true },
        	{ data: 'latitude', orderable: true },
        	{ data: 'longitude', orderable: true },
        	{ data: 'type', orderable: true },
        	{ data: 'count', visible: true, orderable: true}
    	]
	} );

	
});
</script>

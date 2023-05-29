<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<script>
$.getJSON("<util:applicationRoot/>/feeds/pubchem_vocabulary.jsp", function(data){
		
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
    	order: [[4, 'desc']],
     	columns: [
        	{ data: 'sid',
        	  orderable: true,
     		  render: function ( data, type, row ) {
    			return '<a href="<util:applicationRoot/>/substance/sentences.jsp?sid=' + row.sid + '&concept=' + row.substance + '"><span style="color:#376076";>' +  row.sid + '<\/span></a>';
         	  }
        	  },
        	{ data: 'substance', orderable: true },
        	{ data: 'mesh', orderable: true },
        	{ data: 'pharm', orderable: true },
        	{ data: 'count', visible: true, orderable: true}
    	]
	} );

	
});
</script>

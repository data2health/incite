<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<head>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-136610069-2"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-136610069-2');
</script>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-title"
	content="CD2H - Center for Data To Health">
<title>${param.title}</title>

	<!-- bootstrap CSS -->
	<link href="<util:applicationRoot/>/resources/bootstrap/css/bootstrap.css" rel="stylesheet" >
	<script src="<util:applicationRoot/>/resources/anime.min.js"></script>

	<!-- jQuery library -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>$.ajaxPrefilter(function( options, originalOptions, jqXHR ) {    options.async = true; });</script>	
	
	

	<!-- bootstrap Latest compiled JavaScript -->
	<script type='text/javascript' src='<util:applicationRoot/>/resources/bootstrap/js/bootstrap.bundle.min.js '></script>
	
	<!-- bootstrap multiselect support -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/1.1.1/js/bootstrap-multiselect.min.js" integrity="sha512-fp+kGodOXYBIPyIXInWgdH2vTMiOfbLC9YqwEHslkUxc8JLI7eBL2UQ8/HbB5YehvynU3gA3klc84rAQcTQvXA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-multiselect/1.1.1/css/bootstrap-multiselect.min.css" integrity="sha512-jpey1PaBfFBeEAsKxmkM1Yh7fkH09t/XDVjAgYGrq1s2L9qPD/kKdXC/2I6t2Va8xdd9SanwPYHIAnyBRdPmig==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	
	<!-- datatables -->
<%-- 	<link rel="stylesheet" type="text/css" href="<util:applicationRoot/>/resources/DataTables/css/jquery.dataTables.min.css"/> --%>
<%-- 	<script type="text/javascript" charset="utf8" src="<util:applicationRoot/>/resources/DataTables/js/jquery.dataTables.min.js"></script> --%>
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css"/>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>
	
	<script type="text/javascript" charset="utf8" src="<util:applicationRoot/>/resources/jquery-colorize.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.10.19/dataRender/datetime.js"></script>
    <script src="https://cdn.datatables.net/plug-ins/1.11.5/sorting/datetime-moment.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css"/>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    
    <!-- select library -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<!-- select2 library latest development version -->	
<%-- 	<link href="<util:applicationRoot/>/resources/select2/select2.min.css" rel="stylesheet" /> --%>
<%-- 	<script src="<util:applicationRoot/>/resources/select2/select2.js"></script> --%>
	<script src="<util:applicationRoot/>/resources/select2/select2_search.js"></script>
    
	<!-- local stylesheets -->
	<link rel="stylesheet" href="<util:applicationRoot/>/resources/dashboard_style.css">
</head>

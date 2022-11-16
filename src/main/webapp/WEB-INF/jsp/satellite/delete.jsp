<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="it" class="h-100" >
	 <head>
	 	<jsp:include page="../header.jsp" />
	 	<title>Rimuovi satellite</title>
	   
	 </head>
	   <body class="d-flex flex-column h-100">
	   		<jsp:include page="../navbar.jsp"></jsp:include>
			<main class="flex-shrink-0">
			  <div class="container">
			  
			  		<div class='card'>
					    <div class='card-header'>
					        <h5>Conferma eliminazione</h5>
					    </div>
					    
					    
					    
					    <div class='card-body'>
					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Id:</dt>
							  <dd class="col-sm-9">${delete_satellite_attr.id}</dd>
					    	</dl>
					    	
					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Denominazione:</dt>
							  <dd class="col-sm-9">${delete_satellite_attr.denominazione}</dd>
					    	</dl>
					    	
					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Codice:</dt>
							  <dd class="col-sm-9">${delete_satellite_attr.codice}</dd>
					    	</dl>

					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Data di lancio:</dt>
							  <dd class="col-sm-9"><fmt:formatDate type="date" value = "${delete_satellite_attr.dataLancio}" /></dd>
					    	</dl>
					    	
					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Data di rientro:</dt>
							  <dd class="col-sm-9"><fmt:formatDate type="date" value = "${delete_satellite_attr.dataRientro}" /></dd>
					    	</dl>
					    	
					    	<dl class="row">
							  <dt class="col-sm-3 text-right">Stato:</dt>
							  <dd class="col-sm-9">${delete_satellite_attr.stato}</dd>
					    	</dl>
					    	
					    	
					    </div>
					    <div class='card-footer col-12' >
					    
					        <a href="${pageContext.request.contextPath}/satellite" class='btn btn-outline-secondary' style='width:80px'>
					            <i class='fa fa-chevron-left'></i>Back
					        </a>
					        
					        <form:form method="post" action="${pageContext.request.contextPath}/satellite/deleteEx/" >
					        	<input type="hidden" name="idSatellite" value="${delete_satellite_attr.id}" >
					        	<button type="submit" name="submit" value="submit" id="submit" class="btn btn-danger">Conferma</button>
					        </form:form>
					    </div>
					</div> 
			  </div>
			  
			</main>
			<jsp:include page="../footer.jsp" />
	  </body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="it" class="h-100" >
	 <head>
	 	<jsp:include page="../header.jsp" />
	   	<title>Elenco Satelliti</title>
	 </head>
	 
	<body class="d-flex flex-column h-100">
		<jsp:include page="../navbar.jsp"></jsp:include>
		<main class="flex-shrink-0">
		  <div class="container">
		  
		  		<div class="alert alert-success alert-dismissible fade show  ${successMessage==null?'d-none':'' }" role="alert">
				  ${successMessage}
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
				</div>
				<div class="alert alert-danger alert-dismissible fade show d-none" role="alert">
				  Esempio di operazione fallita!
				  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
				</div>
				<div class="alert alert-info alert-dismissible fade show d-none" role="alert">
				  Aggiungere d-none nelle class per non far apparire
				   <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" ></button>
				</div>
		  
		  
		  
		  		<div class='card'>
				    <div class='card-header'>
				        <h5>Elenco satelliti:</h5> 
				    </div>
				    <div class='card-body'>
				    	<a class="btn btn-primary " href="${pageContext.request.contextPath}/satellite/insert">Inserisci nuovo</a>
				    
				        <div class='table-responsive'>
				            <table class='table table-striped ' >
				                <thead>
				                    <tr>
			                         	<th>Denominazione</th>
				                        <th>Codice</th>
				                        <th>Data di Lancio</th>
				                        <th>Data di Rientro</th>
				                        <th>Stato</th>
				                        <th>Azioni</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<c:forEach items="${satellite_list_attribute}" var="satelliteItem">
										<tr>
											<td>${satelliteItem.denominazione}</td>
											<td>${satelliteItem.codice}</td>
											<td><fmt:formatDate type = "date" value = "${satelliteItem.dataLancio}" /></td>
											<td><fmt:formatDate type = "date" value = "${satelliteItem.dataRientro}" /></td>
											<td>${satelliteItem.stato}</td>
											<td>
												<a class="btn  btn-sm btn-outline-secondary" href="${pageContext.request.contextPath}/satellite/show/${satelliteItem.id }">Visualizza</a>
												
												<c:if test="${satelliteItem.getDataLancio() == null || satelliteItem.stato == 'IN_MOVIMENTO' || satelliteItem.stato == 'FISSO'}">
													<a class="btn  btn-sm btn-outline-primary ml-2 mr-2" href="${pageContext.request.contextPath}/satellite/edit/${satelliteItem.id}">Edit</a>
												</c:if>
												
												<c:if test="${satelliteItem.stato == null || satelliteItem.stato == 'DISATTIVATO' }">
													<a class="btn btn-sm btn-outline-danger" href="${pageContext.request.contextPath}/satellite/delete/${satelliteItem.id}">Delete</a>
												</c:if>
											</td>
										</tr>
									</c:forEach>
				                </tbody>
				            </table>
				        </div>
				        
				        <div class="col-12">
							<a href="${pageContext.request.contextPath}/satellite/search" class='btn btn-outline-secondary' style='width:80px'>
					            <i class='fa fa-chevron-left'></i>Back 
					        </a>
						</div>		   
			    </div>
			</div>
		  </div>
		  
		</main>
		<jsp:include page="../footer.jsp" />
		
	</body>
</html>
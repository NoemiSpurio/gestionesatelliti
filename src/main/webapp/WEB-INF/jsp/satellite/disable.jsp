<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it" class="h-100" >
	 <head>
	 	<jsp:include page="../header.jsp" />
	 	<title>Result</title>
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
		  			<c:if test="${successMessage==null}">
					    <div class='card-header'>
					        <h5 class="text-danger">Stai per avviare la procedura di emergenza, sei sicuro di voler disabilitare questi satelliti?</h5> 
					    </div>
				    </c:if>
				    <c:if test="${successMessage!=null}">
					    <div class='card-header'>
					        <h5 class="text-warning">Procedura di emergenza eseguita. Riepilogo:</h5> 
					    </div>
					</c:if>
				   
				    <div class='card-body'>
				   		 <h6>Totale satelliti: ${satellite_countall_attribute} </h6> 
				   		 <h6>Totale satelliti che saranno disabilitati: ${satellite_countdisable_attribute }</h6>
				    	
				        <div class='table-responsive'>
				            <table class='table table-striped ' >
				                <thead>
				                    <tr>
			                         	<th>Denominazione</th>
				                        <th>Codice</th>
				                        <th>Data di Lancio</th>
				                        <th>Data di Rientro</th>
				                        <th>Stato</th>
				                    </tr>
				                </thead>
				                <tbody>
				                	<c:forEach items="${satellite_list_attribute }" var="satelliteItem">
										<tr>
											<td>${satelliteItem.denominazione }</td>
											<td>${satelliteItem.codice }</td>
											<td><fmt:formatDate type = "date" value = "${satelliteItem.dataLancio }" /></td>
											<td><fmt:formatDate type = "date" value = "${satelliteItem.dataRientro }" /></td>
											<td>${satelliteItem.stato }</td>
										</tr>
									</c:forEach>
				                </tbody>
				            </table>
				        </div>
				        
				        <div class="col-12">
							
							<c:if test="${successMessage==null}">
						        <form:form method="post" action="disabilita" class="row g-3" novalidate="novalidate">
						        	 <button class="btn btn-danger fa fa-chevron-left">Conferma procedura di emergenza</button>
						        </form:form>
						        <form  method="get" action="${pageContext.request.contextPath}/home" class="row g-3" novalidate="novalidate">
						        	 <button class="btn btn-outline-warning fa fa-chevron-left">Annulla</button>
						        </form>
					        </c:if>
					        <c:if test="${successMessage!=null}">
					        	<a href="${pageContext.request.contextPath}/satellite/search" class='btn btn-outline-secondary' style='width:80px'>
					            <i class='fa fa-chevron-left'></i>Back
					        	</a>
					        </c:if>
					        
					        
						</div>		   
			    </div>
			</div>	
		  </div>
		  
		</main>
		<jsp:include page="../footer.jsp" />
		
	</body>
</html>
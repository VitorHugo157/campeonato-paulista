<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
	<title>Quartas Finais</title>
	<link href="estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
	
	<div align="center">
		<h3>Quartas de Finais</h3>
		<table>
			<thead>
				<tr>
					<th>Time Mandante</th>
					<th></th>
					<th>Time Visitante</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogo1}" var="jogo">
					<tr>
						<td><c:out value="${jogo.nomeTimeA}"></c:out></td>
						<td><c:out value="X"></c:out></td>
						<td><c:out value="${jogo.nomeTimeB}"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<table>
			<thead>
				<tr>
					<th>Time Mandante</th>
					<th></th>
					<th>Time Visitante</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogo2}" var="jogo">
					<tr>
						<td><c:out value="${jogo.nomeTimeA}"></c:out></td>
						<td><c:out value="X"></c:out></td>
						<td><c:out value="${jogo.nomeTimeB}"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
		
	<br>
		
	<div align="center">
		<table>
			<thead>
				<tr>
					<th>Time Mandante</th>
					<th></th>
					<th>Time Visitante</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogo3}" var="jogo">
					<tr>
						<td><c:out value="${jogo.nomeTimeA}"></c:out></td>
						<td><c:out value="X"></c:out></td>
						<td><c:out value="${jogo.nomeTimeB}"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<table>
			<thead>
				<tr>
					<th>Time Mandante</th>
					<th></th>
					<th>Time Visitante</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogo4}" var="jogo">
					<tr>
						<td><c:out value="${jogo.nomeTimeA}"></c:out></td>
						<td><c:out value="X"></c:out></td>
						<td><c:out value="${jogo.nomeTimeB}"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<br>
	
	<div align="center">
		<br>
		<a href="/campeonato-paulista"><button class="btnHome">Pagina principal</button></a>
	</div>
	
	<br>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, model.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Grupos</title>
	<link href="estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
		<div id="grupoA">
			<h3>Grupo A</h3>
			<table>
				<thead>
					<tr>
						<th>Time</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${GrupoA}" var="time">
						<tr>
							<td><c:out value="${time.nomeTime}"></c:out></td>
							<td><c:out value="${time.cidade}"></c:out></td>
							<td><c:out value="${time.estadio}"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br>
		
		<div id="grupoB">
			<h3>Grupo B</h3>
			<table>
				<thead>
					<tr>
						<th>Time</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${GrupoB}" var="time">
						<tr>
							<td><c:out value="${time.nomeTime}"></c:out></td>
							<td><c:out value="${time.cidade}"></c:out></td>
							<td><c:out value="${time.estadio}"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br>
		
		<div id="grupoC">
			<h3>Grupo C</h3>
			<table>
				<thead>
					<tr>
						<th>Time</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${GrupoC}" var="time">
						<tr>
							<td><c:out value="${time.nomeTime}"></c:out></td>
							<td><c:out value="${time.cidade}"></c:out></td>
							<td><c:out value="${time.estadio}"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<br>
		
		<div id="grupoD">
			<h3>Grupo D</h3>
			<table>
				<thead>
					<tr>
						<th>Time</th>
						<th>Cidade</th>
						<th>Estádio</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${GrupoD}" var="time">
						<tr>
							<td><c:out value="${time.nomeTime}"></c:out></td>
							<td><c:out value="${time.cidade}"></c:out></td>
							<td><c:out value="${time.estadio}"></c:out></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div>
			<br>
			<a href="/campeonato-paulista"><button class="btnHome">Pagina principal</button></a>
		</div>
	</div>
	<br><br>
</body>
</html>

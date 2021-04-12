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
			<h2>Grupo A</h2>
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
		
		<div id="grupoB">
			<h2>Grupo B</h2>
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
		
		<div id="grupoC">
			<h2>Grupo C</h2>
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
		
		<div id="grupoD">
			<h2>Grupo D</h2>
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
</body>
</html>
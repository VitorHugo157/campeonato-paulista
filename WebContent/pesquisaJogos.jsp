<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Pesquisar jogos por data</title>
	<link href="estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
		<table>
			<thead>
				<tr>
					<th>Time Casa</th>
					<th colspan=3>Gols</th>
					<th>Time Visitante</th>
					<th>Data do Jogo</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogos}" var="jogo">
					<tr>
						<td><c:out value="${jogo.codigoTimeA}"></c:out></td>
						<td><c:out value="${jogo.golsTimeA}"></c:out></td>
						<td><c:out value=" X "></c:out></td>
						<td><c:out value="${jogo.golsTimeB}"></c:out></td>
						<td><c:out value="${jogo.codigoTimeB}"></c:out></td>
						<td><c:out value="${jogo.data}"></c:out></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div>
			<br>
			<a href="/campeonato-paulista"><button class="btnHome">Pagina principal</button></a>
		</div>
	</div>
</body>
</html>
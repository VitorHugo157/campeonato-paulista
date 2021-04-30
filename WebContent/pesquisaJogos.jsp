<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
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
					<th>Ação</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${jogos}" var="jogo">
					<form action="/campeonato-paulista2/pesquisaJogos" method="post">
						<input type="hidden" name="nomeTimeA" value="${jogo.codigoTimeA}">
						<input type="hidden" name="nomeTimeB" value="${jogo.codigoTimeB}">
						<input type="hidden" name="dataJogo" value="${jogo.data}">
						<tr>
							<td><c:out value="${jogo.codigoTimeA}"></c:out></td>
							<td><input type="text" name="golsTimeA" value="<c:out value="${jogo.golsTimeA}" />" /></td>
							<td><c:out value="X"></c:out></td>
							<td><input type="text" name="golsTimeB" value="<c:out value="${jogo.golsTimeB}" />" /></td>
							<td><c:out value="${jogo.codigoTimeB}"></c:out></td>
							<td><c:out value="${jogo.data}"></c:out></td>
							<td><button type="submit" name="action" value="atualizar">Atualizar</button></td>
						</tr>
					</form>
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

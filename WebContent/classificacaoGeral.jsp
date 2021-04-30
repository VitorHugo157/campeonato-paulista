<%@ page contentType="text/html; charset=ISO-8859-1" language="java" pageEncoding="UTF-8" import="java.sql.*" errorPage="" %>
<%@ page import="java.util.List, model.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8' />
	<title>Classificação Geral</title>
	<link href="estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
	
	<div align="center">
		<h3>Classificação Geral</h3>
		<table>
			<thead>
				<tr>
					<th></th>
					<th class="posicao"></th>
					<th class="time">Time</th>
					<th>Pts</th>
					<th>PJ</th>
					<th>V</th>
					<th>E</th>
					<th>D</th>
					<th>GP</th>
					<th>GC</th>
					<th>SG</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${ClassificacaoGeral}" var="classificacao" varStatus="posicao">
					<c:choose>
						<c:when test="${posicao.count > 12}">
							<tr>
								<td class="rebaixamento">|</td>
								<td class="posicao"><c:out value="${classificacao.posicao}"></c:out></td>
								<td><c:out value="${classificacao.nomeTime}"></c:out></td>
								<td><c:out value="${classificacao.pontos}"></c:out></td>
								<td><c:out value="${classificacao.numJogosDisputados}"></c:out></td>
								<td><c:out value="${classificacao.vitorias}"></c:out></td>
								<td><c:out value="${classificacao.empates}"></c:out></td>
								<td><c:out value="${classificacao.derrotas}"></c:out></td>
								<td><c:out value="${classificacao.golsMarcados}"></c:out></td>
								<td><c:out value="${classificacao.golsSofridos}"></c:out></td>
								<td><c:out value="${classificacao.saldoGols}"></c:out></td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td class="normal">|</td>
								<td class="posicao"><c:out value="${classificacao.posicao}"></c:out></td>
								<td><c:out value="${classificacao.nomeTime}"></c:out></td>
								<td><c:out value="${classificacao.pontos}"></c:out></td>
								<td><c:out value="${classificacao.numJogosDisputados}"></c:out></td>
								<td><c:out value="${classificacao.vitorias}"></c:out></td>
								<td><c:out value="${classificacao.empates}"></c:out></td>
								<td><c:out value="${classificacao.derrotas}"></c:out></td>
								<td><c:out value="${classificacao.golsMarcados}"></c:out></td>
								<td><c:out value="${classificacao.golsSofridos}"></c:out></td>
								<td><c:out value="${classificacao.saldoGols}"></c:out></td>
							</tr>
						</c:otherwise>
					</c:choose>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Campeonato Paulista 2019</title>
	<link href="estilo.css" rel="stylesheet" type="text/css">
</head>
<body>
	<form action="/campeonato-paulista/grupos" method="get">
		<div align="center">
			<h3>Clique aqui para gerar os grupos</h3>
				<button type="submit" name="action" value="gerar" class="btnGerarGrupos">Gerar grupos</button>
				<button type="submit" name="action" value="mostrar" class="btnMostrarGrupos">Mostrar grupos</button>
		</div>
	</form>
	
	<br>
	
	<form action="/campeonato-paulista/jogos" method="get">
		<div align="center" class="divGerarJogos">
			<h3>Clique aqui para gerar os jogos</h3>
				<button type="submit" class="btnGerarJogos">Gerar jogos</button>
		</div>
	</form>

	<br>

	<form action="/campeonato-paulista/pesquisaJogos" method="post">
		<div align="center">
			<h3>Pesquise jogos por data</h3>
				<input type="date" name="data" placeholder="Insira uma data válida"/>
				<button type="submit" class="btnPesquisarJogos">Pesquisar</button>
		</div>
	</form>
	
	<br>
	
	<form action="/campeonato-paulista/classificacao" method="get">
		<div align="center">
			<h3>Clique aqui para ver a classificação</h3>
				<button type="submit" name="action" value="geral" class="btnClassificacaoGeral">Classificação Geral</button>
				<button type="submit" name="action" value="grupo" class="btnClassificacaoGrupo">Classificação Grupos</button>
		</div>
	</form>
	
	<br><br>
	
	<form action="/campeonato-paulista/quartas-finais" method="get">
		<div align="center">
			<h3>Clique aqui para ver as Quartas de Finais</h3>
				<button type="submit" class="btnQuartas">Quartas de Finais</button>
		</div>
	</form>
</body>
</html>

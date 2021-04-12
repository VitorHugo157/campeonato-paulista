<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="ISO-8859-1"%>

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
			<a href="/campeonato-paulista/grupos">
				<button type="submit" class="btnGerarGrupos">Gerar grupos</button>
			</a>
			<a href="/campeonato-paulista/grupos">
				<button type="submit" class="btnMostrarGrupos">Mostrar grupos</button>
			</a>
		</div>
	</form>
	
	<br>
	
	<form action="/campeonato-paulista/jogos" method="get">
		<div align="center" class="divGerarJogos">
			<h3>Clique aqui para gerar os jogos</h3>
			<a href="/campeonato-paulista/jogos">
				<button type="submit" class="btnGerarJogos">Gerar jogos</button>
			</a>
		</div>
	</form>

	<br>

	<div align="center" class="">
	<h3>Pesquise jogos por data</h3>
		<form action="/campeonato-paulista/pesquisaJogos" method="post">
			<input type="date" name="data" placeholder="Insira uma data v�lida"/>
			<button type="submit" class="btnPesquisarJogos">Pesquisar</button>
		</form>
	</div>
</body>
</html>
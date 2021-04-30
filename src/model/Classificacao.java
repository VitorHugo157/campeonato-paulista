package model;

public class Classificacao {

	private int posicao;
	private String nomeTime;
	private int pontos;
	private int numJogosDisputados;
	private int vitorias;
	private int empates;
	private int derrotas;
	private int golsMarcados;
	private int golsSofridos;
	private int saldoGols;
	
	public Classificacao() {}

	public int getPosicao() {
		return posicao;
	}
	public void setPosicao(int posicao) {
		this.posicao = posicao;
	}

	public String getNomeTime() {
		return nomeTime;
	}
	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}

	public int getPontos() {
		return pontos;
	}
	public void setPontos(int pontos) {
		this.pontos = pontos;
	}

	public int getNumJogosDisputados() {
		return numJogosDisputados;
	}
	public void setNumJogosDisputados(int numJogosDisputados) {
		this.numJogosDisputados = numJogosDisputados;
	}

	public int getVitorias() {
		return vitorias;
	}
	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}

	public int getEmpates() {
		return empates;
	}
	public void setEmpates(int empates) {
		this.empates = empates;
	}

	public int getDerrotas() {
		return derrotas;
	}
	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}

	public int getGolsMarcados() {
		return golsMarcados;
	}
	public void setGolsMarcados(int golsMarcados) {
		this.golsMarcados = golsMarcados;
	}

	public int getGolsSofridos() {
		return golsSofridos;
	}
	public void setGolsSofridos(int golsSofridos) {
		this.golsSofridos = golsSofridos;
	}

	public int getSaldoGols() {
		return saldoGols;
	}
	public void setSaldoGols(int saldoGols) {
		this.saldoGols = saldoGols;
	}
}

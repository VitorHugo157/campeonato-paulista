package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Classificacao;

public class ClassificacaoDao {

	private Connection c;
	
	public ClassificacaoDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public List<Classificacao> mostrarClassificacaoGeral() throws ClassNotFoundException, SQLException {
		
		String sql = "SELECT * FROM fn_classificacaoGeral() ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<Classificacao> classificacao = new ArrayList<>();
		
		try {
			int posicao = 1;
			while(rs.next()) {
				Classificacao cGeral = new Classificacao();
				cGeral.setPosicao(posicao);
				cGeral.setNomeTime(rs.getString("nome_time"));
				cGeral.setPontos(rs.getInt("pontos"));
				cGeral.setNumJogosDisputados(rs.getInt("num_jogos_disputados"));
				cGeral.setVitorias(rs.getInt("vitorias"));
				cGeral.setEmpates(rs.getInt("empates"));
				cGeral.setDerrotas(rs.getInt("derrotas"));
				cGeral.setGolsMarcados(rs.getInt("gols_marcados"));
				cGeral.setGolsSofridos(rs.getInt("gols_sofridos"));
				cGeral.setSaldoGols(rs.getInt("saldo_gols"));
				
				posicao++;
				classificacao.add(cGeral);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		ps.close();
		return classificacao;
	}
	
	public List<Classificacao> mostrarClassificacaoGrupo(String grupo) throws ClassNotFoundException, SQLException {
		
		String sql = "SELECT * FROM fn_classificacaoGrupo(?) ORDER BY pontos DESC, vitorias DESC, gols_marcados DESC, saldo_gols DESC";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		List<Classificacao> classificacao = new ArrayList<>();
		
		try {
			int posicao = 1;
			while(rs.next()) {
				Classificacao cGeral = new Classificacao();
				cGeral.setPosicao(posicao);
				cGeral.setNomeTime(rs.getString("nome_time"));
				cGeral.setPontos(rs.getInt("pontos"));
				cGeral.setNumJogosDisputados(rs.getInt("num_jogos_disputados"));
				cGeral.setVitorias(rs.getInt("vitorias"));
				cGeral.setEmpates(rs.getInt("empates"));
				cGeral.setDerrotas(rs.getInt("derrotas"));
				cGeral.setGolsMarcados(rs.getInt("gols_marcados"));
				cGeral.setGolsSofridos(rs.getInt("gols_sofridos"));
				cGeral.setSaldoGols(rs.getInt("saldo_gols"));
				
				posicao++;
				classificacao.add(cGeral);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		ps.close();
		return classificacao;
		
	}
}

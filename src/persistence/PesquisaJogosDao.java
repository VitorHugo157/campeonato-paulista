package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Jogo;

public class PesquisaJogosDao {

	private Connection c;
	
	public PesquisaJogosDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public List<Jogo> findJogosByData(String dataJogo) throws SQLException {
		
		List<Jogo> jogos = new ArrayList<>();
		
		String sql = "SELECT * FROM v_jogos WHERE dataJogo = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setDate(1, java.sql.Date.valueOf(dataJogo));
		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			Jogo jogo = new Jogo();
			jogo.setCodigoTimeA(rs.getString("nomeTimeA"));
			jogo.setGolsTimeA(rs.getInt("golsTimeA"));
			jogo.setGolsTimeB(rs.getInt("golsTimeB"));
			jogo.setCodigoTimeB(rs.getString("nomeTimeB"));
			jogo.setData(rs.getDate("dataJogo"));
			jogos.add(jogo);
		}
		
		ps.close();
		return jogos;		
	}
	
	public List<Jogo> updateJogos(String nomeTimeA, String nomeTimeB, int golsTimeA, int golsTimeB, String dataJogo) throws SQLException {
		
		String sql = "{CALL sp_atualizaJogos(?, ?, ?, ?, ?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, nomeTimeA);
		cs.setString(2, nomeTimeB);
		cs.setInt(3, golsTimeA);
		cs.setInt(4, golsTimeB);
		cs.setString(5, dataJogo);
		cs.execute();
		cs.close();
		
		return findJogosByData(dataJogo);
	}
}

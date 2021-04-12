package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class JogosDao {
	
	private Connection c;

	public JogosDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public void procGerarJogos() throws SQLException {
		String sql = "{CALL sp_gerarRodadas}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
	}
}
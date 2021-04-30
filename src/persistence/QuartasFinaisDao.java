package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.QuartasFinais;

public class QuartasFinaisDao {

	private Connection c;
	
	public QuartasFinaisDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public List<QuartasFinais> mostrarQuartasFinais() throws ClassNotFoundException, SQLException {
		
		String sql = "SELECT * FROM fn_quartasFinais()";
		PreparedStatement ps = c.prepareStatement(sql);
		
		ResultSet rs = ps.executeQuery();
		List<String> times = new ArrayList<>();
		List<QuartasFinais> quartas = new ArrayList<>();
		
		try {
			while(rs.next()) {
				times.add(rs.getString("nomeTime"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		for(int i = 0; i < times.size(); i = i + 2) {
			QuartasFinais qf = new QuartasFinais();
			qf.setNomeTimeA(times.get(i));
			qf.setNomeTimeB(times.get(i + 1));
			quartas.add(qf);
		}
		ps.close();
		return quartas;
	}
}

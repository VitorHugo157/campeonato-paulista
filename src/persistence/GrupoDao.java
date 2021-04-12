package persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Grupo;
import model.Time;

public class GrupoDao {

	private Connection c;

	public GrupoDao() throws ClassNotFoundException, SQLException {
		GenericDao gDao = new GenericDao();
		c = gDao.getConnection();
	}
	
	public void procGerarGrupos() throws SQLException {
		
		String sql = "{CALL sp_insereTimesGrupo}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		cs.close();
		
	}
	
	public List<Grupo> mostrarGrupos() throws ClassNotFoundException, SQLException {
		
		String g = "";
		String sqlSelectGrupos = "SELECT * FROM v_grupos";
		PreparedStatement ps = c.prepareStatement(sqlSelectGrupos);
		
		ResultSet rs = ps.executeQuery();
		List<Grupo> grupos = new ArrayList<>();
		
		try {
			while(rs.next()) {
				
				Grupo grupo = new Grupo();
				Time time = new Time();
				
				g = rs.getString("grupo");
				time.setNomeTime(rs.getString("nomeTime"));
				time.setCidade(rs.getString("nomeCidade"));
				time.setEstadio(rs.getString("nomeEstadio"));
				
				grupo.setGrupo(g);
				grupo.setTime(time);
				
				grupos.add(grupo);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		ps.close();
		return grupos;
	}
}
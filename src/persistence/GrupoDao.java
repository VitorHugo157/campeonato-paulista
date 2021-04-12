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
		System.out.println("Feita a conexao com o banco de dados");
		
	}
	
	public List<Grupo> procGerarGrupos() throws SQLException {
		
		String g = "";
		
		String sql = "{CALL sp_insereTimesGrupo}";
		CallableStatement cs = c.prepareCall(sql);
		cs.execute();
		System.out.println("Query executada");
		
		
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
			System.out.println("Erro na GrupoDao");
		}
		
		cs.close();
		
		return grupos;
	}
}
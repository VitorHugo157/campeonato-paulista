package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Grupo;
import model.Time;
import persistence.GrupoDao;

@WebServlet("/grupos")
public class GrupoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Grupo> grupos = new ArrayList<>();
		
		try {
			
			GrupoDao gDao = new GrupoDao();
			grupos = gDao.procGerarGrupos();
			System.out.println("Feita a conexao com o banco de dados");
			
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
			System.out.println("Erro na conexao com o banco de dados");
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("/grupos.jsp");
			List<Time> timesGrupoA = grupos.stream().filter(g -> g.getGrupo().equals("A")).map(g -> g.getTime()).collect(Collectors.toList());
			List<Time> timesGrupoB = grupos.stream().filter(g -> g.getGrupo().equals("B")).map(g -> g.getTime()).collect(Collectors.toList());
			List<Time> timesGrupoC = grupos.stream().filter(g -> g.getGrupo().equals("C")).map(g -> g.getTime()).collect(Collectors.toList());
			List<Time> timesGrupoD = grupos.stream().filter(g -> g.getGrupo().equals("D")).map(g -> g.getTime()).collect(Collectors.toList());
			request.setAttribute("GrupoA", timesGrupoA);
//			request.setAttribute("GrupoB", timesGrupoB);
//			request.setAttribute("GrupoC", timesGrupoC);
//			request.setAttribute("GrupoD", timesGrupoD);
			
			rd.forward(request, response);
		}
	}
}
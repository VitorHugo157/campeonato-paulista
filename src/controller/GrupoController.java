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
import javax.swing.JOptionPane;

import model.Grupo;
import model.Time;
import persistence.GrupoDao;

@WebServlet("/grupos")
public class GrupoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Grupo> grupos = new ArrayList<>();
		String action = request.getParameter("action");
		String forward = "";
		
		if(action.equalsIgnoreCase("gerar")) {
			try {
				GrupoDao gDao = new GrupoDao();
				gDao.procGerarGrupos();
				JOptionPane.showMessageDialog(null, "Grupos gerados com sucesso.");
				forward = "/index.jsp";
			} catch (ClassNotFoundException | SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				RequestDispatcher rd = request.getRequestDispatcher(forward);
				rd.forward(request, response);
			}
		} else {
			try {
				
				GrupoDao gDao = new GrupoDao();
				grupos = gDao.mostrarGrupos();
				System.out.println("Feita a conexao com o banco de dados");
				forward = "/grupos.jsp";
				
				
			} catch (ClassNotFoundException | SQLException e) {
				e.printStackTrace();
				System.out.println("Erro na conexao com o banco de dados");
			}finally {
				
				List<Time> timesGrupoA = grupos.stream().filter(g -> g.getGrupo().equals("A")).map(g -> g.getTime()).collect(Collectors.toList());
				List<Time> timesGrupoB = grupos.stream().filter(g -> g.getGrupo().equals("B")).map(g -> g.getTime()).collect(Collectors.toList());
				List<Time> timesGrupoC = grupos.stream().filter(g -> g.getGrupo().equals("C")).map(g -> g.getTime()).collect(Collectors.toList());
				List<Time> timesGrupoD = grupos.stream().filter(g -> g.getGrupo().equals("D")).map(g -> g.getTime()).collect(Collectors.toList());
				RequestDispatcher rd = request.getRequestDispatcher(forward);
				request.setAttribute("GrupoA", timesGrupoA);
				request.setAttribute("GrupoB", timesGrupoB);
				request.setAttribute("GrupoC", timesGrupoC);
				request.setAttribute("GrupoD", timesGrupoD);
				
				rd.forward(request, response);
			}
		}
	}
}
package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Classificacao;
import persistence.ClassificacaoDao;

@WebServlet("/classificacao")
public class ClassificacaoGeralController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Classificacao> classificacao = new ArrayList<>();
		List<Classificacao> classificacaoGrupoA = new ArrayList<>();
		List<Classificacao> classificacaoGrupoB = new ArrayList<>();
		List<Classificacao> classificacaoGrupoC = new ArrayList<>();
		List<Classificacao> classificacaoGrupoD = new ArrayList<>();
		String action = request.getParameter("action");
		String forward = "";
		
		if(action.equalsIgnoreCase("geral")) {
			try {
				ClassificacaoDao cDao = new ClassificacaoDao();
				classificacao = cDao.mostrarClassificacaoGeral();
				forward = "/classificacaoGeral.jsp";
			} catch (ClassNotFoundException | SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				RequestDispatcher rd = request.getRequestDispatcher(forward);
				request.setAttribute("ClassificacaoGeral", classificacao);
				rd.forward(request, response);
			}
		} else {
			try {
				ClassificacaoDao cDao = new ClassificacaoDao();
				classificacaoGrupoA = cDao.mostrarClassificacaoGrupo("A");
				classificacaoGrupoB = cDao.mostrarClassificacaoGrupo("B");
				classificacaoGrupoC = cDao.mostrarClassificacaoGrupo("C");
				classificacaoGrupoD = cDao.mostrarClassificacaoGrupo("D");
				forward = "/classificacaoGrupo.jsp";
			} catch (ClassNotFoundException | SQLException e) {
				System.out.println(e.getMessage());
			} finally {
				RequestDispatcher rd = request.getRequestDispatcher(forward);
				request.setAttribute("GrupoA", classificacaoGrupoA);
				request.setAttribute("GrupoB", classificacaoGrupoB);
				request.setAttribute("GrupoC", classificacaoGrupoC);
				request.setAttribute("GrupoD", classificacaoGrupoD);
				rd.forward(request, response);
			}
		}
	}
}

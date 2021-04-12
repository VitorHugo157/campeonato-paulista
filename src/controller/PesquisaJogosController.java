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

import model.Jogo;
import persistence.PesquisaJogosDao;

@WebServlet("/pesquisaJogos")
public class PesquisaJogosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<Jogo> jogos = new ArrayList<>();
		String dataJogo = request.getParameter("data");
		
		try {
			PesquisaJogosDao pjDao = new PesquisaJogosDao();
			jogos = pjDao.findJogosByData(dataJogo);
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("/pesquisaJogos.jsp");
			request.setAttribute("jogos", jogos);
			rd.forward(request, response);
		}
	}
}

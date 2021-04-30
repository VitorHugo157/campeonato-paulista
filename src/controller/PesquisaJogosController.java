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
		String dataJogo = "";
		String action = request.getParameter("action");
		String nomeTimeA = "";
		String nomeTimeB = "";
		int golsTimeA = 0;
		int golsTimeB = 0;
		
		
		if("atualizar".equalsIgnoreCase(action)) {
			dataJogo = request.getParameter("dataJogo");
			nomeTimeA = request.getParameter("nomeTimeA");
			nomeTimeB = request.getParameter("nomeTimeB");
			golsTimeA = Integer.parseInt(request.getParameter("golsTimeA"));
			golsTimeB = Integer.parseInt(request.getParameter("golsTimeB"));
			
			System.out.println("NomeTimeA -> " + nomeTimeA);
			System.out.println("NomeTimeB -> " + nomeTimeB);
			System.out.println("GolsTimeA -> " + golsTimeA);
			System.out.println("GolsTimeB -> " + golsTimeB);
			
		} else {
			dataJogo = request.getParameter("data");
		}
		
		try {
			PesquisaJogosDao pjDao = new PesquisaJogosDao();
			if("atualizar".equalsIgnoreCase(action)) {
				jogos = pjDao.updateJogos(nomeTimeA, nomeTimeB, golsTimeA, golsTimeB, dataJogo);
			} else {
				jogos = pjDao.findJogosByData(dataJogo);
			}
			System.out.println("dataJogo -> " + dataJogo);
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			RequestDispatcher rd = request.getRequestDispatcher("/pesquisaJogos.jsp");
			request.setAttribute("jogos", jogos);
			rd.forward(request, response);
		}
	}
}

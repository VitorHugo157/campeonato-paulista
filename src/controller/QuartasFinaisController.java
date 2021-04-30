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

import model.QuartasFinais;
import persistence.QuartasFinaisDao;

@WebServlet("/quartas-finais")
public class QuartasFinaisController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<QuartasFinais> quartas = new ArrayList<>();
		List<QuartasFinais> jogo1 = new ArrayList<>();
		List<QuartasFinais> jogo2 = new ArrayList<>();
		List<QuartasFinais> jogo3 = new ArrayList<>();
		List<QuartasFinais> jogo4 = new ArrayList<>();
		
		try {
			QuartasFinaisDao qfDao = new QuartasFinaisDao();
			quartas = qfDao.mostrarQuartasFinais();
		} catch (ClassNotFoundException | SQLException e) {
			System.out.println(e.getMessage());
		} finally {
			jogo1.add(quartas.get(0));
			jogo2.add(quartas.get(1));
			jogo3.add(quartas.get(2));
			jogo4.add(quartas.get(3));
			
			RequestDispatcher rd = request.getRequestDispatcher("/quartasFinais.jsp");
			request.setAttribute("jogo1", jogo1);
			request.setAttribute("jogo2", jogo2);
			request.setAttribute("jogo3", jogo3);
			request.setAttribute("jogo4", jogo4);
			
			rd.forward(request, response);
		}
	}
}

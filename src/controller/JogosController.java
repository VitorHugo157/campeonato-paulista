package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;

import persistence.JogosDao;

@WebServlet("/jogos")
public class JogosController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			JogosDao rDao = new JogosDao();
			rDao.procGerarJogos();
			JOptionPane.showMessageDialog(null, "Jogos gerados com sucesso.");
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}finally {
			RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
			rd.forward(request, response);
		}
	}
}

package Day2;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Database_Connectivity")
public class Database_Connectivity extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			if(req.getParameter("submit") !=null) {
				
				PrintWriter out = resp.getWriter();
				
				String Name = req.getParameter("name");
				String Email = req.getParameter("email");
				String Pass = req.getParameter("pass");
				String Address = req.getParameter("address");
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data", "root", "root");
				Statement st = con.createStatement();
				st.executeUpdate("insert into student (s_name, s_email, s_pass, s_add) values ('"+ Name +"' , '"+ Email +"', '"+Pass+"', '"+Address+"')");
				out.print("<script>alert('Registered Successfully !!!')</script>");
				
			
			}
			
		}catch(Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		
	}
	
}

package Day3;

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

@WebServlet("/Register2")
public class Register2 extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			if(req.getParameter("submit") !=null) {
				
				PrintWriter out = resp.getWriter();
				
				String Name = req.getParameter("fullname");
				String Email = req.getParameter("email");
				String Pass = req.getParameter("password");
				String PhoneNo = req.getParameter("phone");
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
				Statement st = con.createStatement();
				st.executeUpdate("insert into employee (e_fullname, e_email, e_pass, e_phone) values ('"+ Name +"' , '"+ Email +"', '"+Pass+"', '"+PhoneNo+"')");
				out.print("<script>alert('Registered Successfully !!!')</script>");
	
			}
			
		}catch(Exception e) {
			e.getMessage();
			e.printStackTrace();
		}
		
	}

}

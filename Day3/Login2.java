package Day3;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Login2")
public class Login2 extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        try {
            if (req.getParameter("submit") != null) {
                String Email = req.getParameter("email");
                String Password = req.getParameter("password");

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
                PreparedStatement ps = con.prepareStatement("select * from employee where e_email=? and e_pass=?");
                
                ps.setString(1, Email);
                ps.setString(2, Password);

                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    resp.sendRedirect("Profile2.html");
                } else {
                    resp.sendRedirect("Register2.html");
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

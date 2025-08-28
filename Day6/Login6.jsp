<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body { 
        	font-family: Arial; 
        	background: #f5f5f5; 
        }
        .container { 
        	width: 400px; 
        	margin: 80px auto; 
        	background: #fff; padding: 20px; 
        	border-radius: 10px; 
        	box-shadow: 0px 0px 10px #ccc; 
        }
        h2 { 
       		text-align: center; 
        }
        input, button { 
        	width: 100%; 
        	padding: 10px; 
        	margin: 10px 0; 
        	border-radius: 5px; 
        	border: 1px solid #ccc; 
        }
        button { 
        	background: #007BFF; 
        	color: white; 
        	cursor: pointer; 
        }
        button:hover { 
        	background: #0056b3;
		}
    </style>
</head>
<body>
    <div class="container">
        <h2>Forgot Password</h2>
        <form method="get">
            <label>Enter Phone Number:</label>
            <input type="tel" name="phone" required />
            <button type="submit" name="submit">Submit</button>
        </form>

        <%
            if(request.getParameter("submit") != null){
                String Phone = request.getParameter("phone");
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data","root","root");
                    PreparedStatement ps = con.prepareStatement("select * from employee where e_phone=?");
                    ps.setString(1, Phone);
                    ResultSet rs = ps.executeQuery();
                    if(rs.next()){
                        HttpSession ses = request.getSession();
                        ses.setAttribute("email", rs.getString("e_email"));
                        ses.setAttribute("id", rs.getInt("e_id"));
                        response.sendRedirect("ForgetPass.jsp");
                    } else {
                        out.println("<p style='color:red;text-align:center;'>Phone not found!</p>");
                    }
                } catch(Exception e){ 
                	e.getMessage();
                }
            }
        %>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="java.sql.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
<style>
    body { 
    	font-family: Arial; 
    	background: #f5f5f5; 
    }
    .container { 
    	width: 400px;
    	margin: 80px auto; 
    	background: #fff; 
    	padding: 20px; 
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
    	background: #28a745; 
    	color: white; 
    	cursor: pointer; }
    button:hover { 
    	background: #218838; 
    }
</style>
</head>
<body>
    <div class="container">
        <h2>Reset Password</h2>
        <%
            String Email = (String)session.getAttribute("email");
            int Id = (Integer)session.getAttribute("id");
        %>
        <form method="get">
            <input type="hidden" name="id1" value="<%=Id%>">
            
            <label>Email:</label>
            <input type="email1" value="<%=Email%>" readonly>
            
            <label>New Password:</label>
            <input type="password" name="password" required>
            <button type="submit" name="Login">Done</button>
        </form>

        <%
            if(request.getParameter("Login")!=null){
                String Pass= request.getParameter("password");
                int id1 = Integer.parseInt(request.getParameter("id1"));
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_data","root","root");
                    PreparedStatement ps = con.prepareStatement("update employee set e_pass=? where e_id=?");
                    ps.setString(1, Pass);
                    ps.setInt(2, id1);
                    ps.executeUpdate();
                    response.sendRedirect("Success.jsp");
                } catch(Exception e){ 
                	e.getMessage();
                }
            }
        %>
    </div>
</body>
</html>

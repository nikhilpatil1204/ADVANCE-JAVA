<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>JSP Example</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background: #f8d7da;
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	align-items: center;
	padding-top: 20px; 
}

.form-container {
	background: white;
	padding: 2rem;
	border-radius: 15px;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	margin-bottom: 20px;
}

.table-container {
	width: 100%;
	max-width: 800px;
	margin-bottom: 20px;
}

.form-control:focus {
	border-color: #dc3545;
	box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
}
</style>
</head>
<body>

	<div class="form-container">
		<h3 class="text-center text-danger mb-4">Create Account</h3>
		<form action="#" method="get">
			<div class="form-floating mb-3">
				<input type="text" name="name" class="form-control border-danger"
					id="name" placeholder="Name"> <label for="name"
					class="text-danger">Name</label>
			</div>
			<div class="form-floating mb-3">
				<input type="email" name="email" class="form-control border-danger"
					id="email" placeholder="Email"> <label for="email"
					class="text-danger">Email</label>
			</div>
			<div class="form-floating mb-4">
				<input type="password" name="password"
					class="form-control border-danger" id="password"
					placeholder="Password"> <label for="password"
					class="text-danger">Password</label>
			</div>
			<button type="submit" name="Register"
				class="btn btn-danger w-100 py-2">Register</button>
		</form>
	</div>

	<%
	try {
		if (request.getParameter("Register") != null) {
			String Name = request.getParameter("name");
			String Email = request.getParameter("email");
			String Pass = request.getParameter("password");

			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
			Statement st = con.createStatement();
			st.executeUpdate("insert into students (s_name ,s_email ,s_pass) values ('" + Name + "' , '" + Email + "','"
			+ Pass + "')");
	%>
	<script>
		alert("Registered Successfully !!");
	</script>
	<%
	}
	} catch (Exception e) {
	e.getMessage();
	}
	%>


	<div class="table-container">
		<h2 class="mb-4 text-danger text-center">Registered Students</h2>
		<table
			class="table table-bordered table-striped table-hover text-center">
			<thead class="table-danger">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>Password</th>
				</tr>
			</thead>
			<%
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
			PreparedStatement ps = con.prepareStatement("select * from students");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
			%>
			<tbody>
				<tr>
					<td><%=rs.getInt("s_id")%></td>
					<td><%=rs.getString("s_name")%></td>
					<td><%=rs.getString("s_email")%></td>
					<td><%=rs.getString("s_pass")%></td>
				</tr>
			</tbody>
			<%
			}
			%>
		</table>
	</div>


	<div class="form-container">
		<h3 class="text-center text-danger mb-4">Login</h3>
		<form action="#" method="post">
			<div class="form-floating mb-3">
				<input type="email" name="email1" class="form-control border-danger"
					id="email1" placeholder="Email"> <label for="email1"
					class="text-danger">Email</label>
			</div>
			<div class="form-floating mb-4">
				<input type="password" name="password1"
					class="form-control border-danger" id="password1"
					placeholder="Password"> <label for="password1"
					class="text-danger">Password</label>
			</div>
			<button type="submit" name="login" class="btn btn-danger w-100 py-2">Login</button>
		</form>

		<%
		String Email1 = request.getParameter("email1");
		String Pass1 = request.getParameter("password1");
		if (Email1 != null && Pass1 != null) {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
			PreparedStatement ps1 = con1.prepareStatement("select * from students where s_email=? and s_pass=?");
			ps1.setString(1, Email1);
			ps1.setString(2, Pass1);
			ResultSet rs1 = ps1.executeQuery();
			if (rs1.next()) {
				HttpSession ses = request.getSession();
				ses.setAttribute("name", rs1.getString("s_name"));
				ses.setAttribute("email", rs1.getString("s_email"));
				ses.setAttribute("password", rs1.getString("s_pass"));
		%>
		<script>
			alert("Login Successfully !!");
		</script>
		<%
		}
		}
		%>
	</div>

	<div class="table-container">
		<%
		String Name2 = (String) session.getAttribute("name");
		String Email2 = (String) session.getAttribute("email");
		String Pass2 = (String) session.getAttribute("password");
		if (Name2 != null) {
		%>
		<h3 class="text-danger text-center">
			Name:
			<%=Name2%></h3>
		<h3 class="text-danger text-center">
			Email:
			<%=Email2%></h3>
		<h3 class="text-danger text-center">
			Password:
			<%=Pass2%></h3>
		<%
		}
		%>
	</div>


	<div class="form-container mt-4">
		<h3 class="text-center text-danger mb-4">Admin Login</h3>
		<form action="#" method="get">
			<div class="form-floating mb-3">
				<input type="email" name="email3" class="form-control border-danger"
					id="adminEmail" placeholder="Admin Email" required> <label
					for="adminEmail" class="text-danger">Admin Email</label>
			</div>
			<div class="form-floating mb-4">
				<input type="password" name="password3"
					class="form-control border-danger" id="adminPassword"
					placeholder="Admin Password" required> <label
					for="adminPassword" class="text-danger">Admin Password</label>
			</div>
			<button type="submit" name="adminlogin"
				class="btn btn-danger w-100 py-2">Login as Admin</button>
		</form>
	</div>


	<div>
		<%
		if (request.getParameter("adminlogin") != null) {
			String Email3 = request.getParameter("email3");
			String Pass3 = request.getParameter("password3");

			if ((Email3.equals("nikhilpatil@gmail.com")) && (Pass3.equals("12345"))) {
				out.print("<script>alert('Admin Login Successful !!')</script>");
			} else {
				out.print("<script>alert('ID and Password did not match !!')</script>");
			}
		}
		%>
	</div>

</body>
</html>

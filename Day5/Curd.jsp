<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CRUD Operations</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" 
      rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <h3 class="text-center text-dark mb-4">Student Records</h3>

    <table class="table table-bordered table-striped text-center align-middle">
        <thead class="table-danger">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Password</th>
                <th>Phone</th>
                <th>Profile Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data", "root", "root");
            PreparedStatement ps = con.prepareStatement("select * from stu_registration");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){	
        %>
            <tr>
                <td><%=rs.getInt("s_id") %></td>
                <td><%=rs.getString("s_name") %></td>
                <td><%=rs.getString("s_email") %></td>
                <td><%=rs.getString("s_pass") %></td>
                <td><%=rs.getString("s_phone") %></td>
                <td>
                    <img class="img-fluid rounded" width="120" src="<%=rs.getString("s_img") %>" />
                </td>
                <td>
                
                    <button type="button" class="btn btn-info btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%=rs.getInt("s_id")%>">
                        Edit
                    </button>


                    <form action="#" method="post" style="display:inline;">
                        <input type="hidden" name="deleteId" value="<%=rs.getInt("s_id")%>"/>
                        <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                    </form>
                </td>
            </tr>

   
            <div class="modal fade" id="editModal<%=rs.getInt("s_id")%>" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="#" method="get">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit Student</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="editId" value="<%=rs.getInt("s_id")%>"/>
                                <input type="text" class="form-control mb-2" name="name"
                                    value="<%=rs.getString("s_name")%>" required />
                                <input type="email" class="form-control mb-2" name="email"
                                    value="<%=rs.getString("s_email")%>" required />
                                <input type="password" class="form-control mb-2" name="pass"
                                    value="<%=rs.getString("s_pass")%>" required />
                                <input type="tel" class="form-control mb-2" name="phone"
                                    value="<%=rs.getString("s_phone")%>" required />
                                <input type="url" class="form-control mb-2" name="img"
                                    value="<%=rs.getString("s_img")%>" required />
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" name="update">Save changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        <%
            } 
        %>
        </tbody>
    </table>
</div>


<%
    if(request.getParameter("deleteId") != null){
        try{
            int id = Integer.parseInt(request.getParameter("deleteId"));
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con1 = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data","root","root");
            PreparedStatement ps1 = con1.prepareStatement("delete from stu_registration where s_id=?");
            ps1.setInt(1, id);
            ps1.executeUpdate();
            con1.close();
            response.sendRedirect("Curd.jsp");
        }catch(Exception e){ 
        	e.printStackTrace(); 
        }
    }

    if(request.getParameter("update") != null){
        try{
            int id = Integer.parseInt(request.getParameter("editId"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            String phone = request.getParameter("phone");
            String img = request.getParameter("img");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/employee_data","root","root");
            PreparedStatement ps2 = con2.prepareStatement(
                "update stu_registration set s_name=?, s_email=?, s_pass=?, s_phone=?, s_img=? where s_id=?");
            ps2.setString(1, name);
            ps2.setString(2, email);
            ps2.setString(3, pass);
            ps2.setString(4, phone);
            ps2.setString(5, img);
            ps2.setInt(6, id);
            ps2.executeUpdate();
            response.sendRedirect("Curd.jsp");
        }catch(Exception e
        		){ e.printStackTrace(); 
        }
    }
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

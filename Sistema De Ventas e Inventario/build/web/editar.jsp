<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = Conexion.conectar();
    PreparedStatement ps = con.prepareStatement("SELECT * FROM producto WHERE id = ?");
    ps.setInt(1, id);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Producto</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('tienda.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: start;
            min-height: 100vh;
        }

        .contenido {
            background-color: rgba(255, 255, 255, 0.9);
            margin-top: 50px;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 90%;
            max-width: 600px;
            text-align: center;
        }

        h2 {
            color: #0077cc;
            margin-bottom: 30px;
        }

        input[type="text"],
        input[type="number"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #0077cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #005fa3;
        }

        .boton-volver {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="contenido">
    <h2>Editar Producto</h2>
    <form action="EditarProductoServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <input type="text" name="nombre" value="<%= rs.getString("nombre") %>" required><br>
        <input type="text" name="descripcion" value="<%= rs.getString("descripcion") %>" required><br>
        <input type="number" step="0.01" name="precio" value="<%= rs.getDouble("precio") %>" required><br>
        <input type="number" name="stock" value="<%= rs.getInt("stock") %>" required><br>
        <input type="submit" value="Actualizar Producto">
    </form>

    <div class="boton-volver">
        <a href="productos.jsp" style="text-decoration: none;">
            <button type="button">Volver a productos</button>
        </a>
    </div>
</div>
</body>
</html>
<%
    rs.close();
    ps.close();
    con.close();
%>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String nombreUsuario = (String) sesion.getAttribute("usuario");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Sistema de Ventas e Inventario</title>
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
            max-width: 700px;
            text-align: center;
        }

        h1 {
            color: #0077cc;
            margin-bottom: 10px;
        }

        .usuario {
            font-size: 16px;
            margin-bottom: 30px;
            color: #333;
        }

        .menu {
            margin-top: 20px;
        }

        .menu a {
            display: inline-block;
            background-color: #0077cc;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            margin: 10px;
            border-radius: 10px;
            font-size: 18px;
            transition: background-color 0.3s;
        }

        .menu a:hover {
            background-color: #005fa3;
        }

        .logout {
            margin-top: 30px;
        }

        .logout a {
            color: red;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="contenido">
    <h1>Bienvenido al Sistema</h1>
    <div class="usuario">
        Sesión iniciada como: <strong><%= nombreUsuario %></strong>
    </div>

    <div class="menu">
        <a href="productos.jsp">Gestión de Productos</a>
        <a href="ventas.jsp">Registrar Venta</a>
        <a href="historial.jsp">Historial de Ventas</a>
    </div>

    <div class="logout">
        <a href="logout.jsp">Cerrar sesión</a>
    </div>
</div>
</body>
</html>
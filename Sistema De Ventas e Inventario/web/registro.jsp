<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Usuario</title>
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
            margin-top: 60px;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            width: 90%;
            max-width: 500px;
            text-align: center;
        }

        h1 {
            color: #0077cc;
            margin-bottom: 30px;
        }

        input {
            width: 90%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"], button {
            background-color: #0077cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        button:hover {
            background-color: #005fa3;
        }

        p {
            font-size: 16px;
            margin-top: 10px;
        }

        a {
            color: #0077cc;
            text-decoration: none;
            font-weight: bold;
        }

        .volver {
            margin-top: 25px;
        }
    </style>
</head>
<body>
<div class="contenido">
    <h1>Registro de Nuevo Usuario</h1>
    <form action="RegistroServlet" method="post">
        <input type="text" name="nombre" placeholder="Nombre completo" required><br>
        <input type="email" name="correo" placeholder="Correo electrónico" required><br>
        <input type="password" name="contrasena" placeholder="Contraseña" required><br>
        <input type="submit" value="Registrarse">
    </form>

    <%
        String exito = request.getParameter("exito");
        String error = request.getParameter("error");
        if ("1".equals(exito)) {
    %>
        <p style="color: green;">Registro exitoso. Ahora puedes iniciar sesión.</p>
        <a href="index.html">Volver al inicio</a>
    <%
        } else if ("1".equals(error)) {
    %>
        <p style="color: red;">Ese correo ya está registrado.</p>
    <%
        }
    %>

    <div class="volver">
        <a href="index.html">
            <button type="button">Volver al inicio</button>
        </a>
    </div>
</div>
</body>
</html>
<%@ page language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <link rel="stylesheet" href="css/estilo.css">
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
            align-items: center;
            height: 100vh;
        }

        .contenido {
            background-color: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.5);
            text-align: center;
            width: 90%;
            max-width: 400px;
        }

        h1 {
            color: #0077cc;
            margin-bottom: 30px;
        }

        input[type="email"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
        }

        input[type="submit"],
        button {
            background-color: #0077cc;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover,
        button:hover {
            background-color: #005fa3;
        }

        .boton-volver {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="contenido">
        <h1>Iniciar Sesión</h1>
        <form action="LoginServlet" method="post">
            <input type="email" name="correo" placeholder="Correo electrónico" required><br>
            <input type="password" name="contrasena" placeholder="Contraseña" required><br>
            <input type="submit" value="Entrar">
        </form>

        <%
            String error = request.getParameter("error");
            if ("1".equals(error)) {
        %>
            <p style="color:red;">Correo o contraseña incorrectos</p>
        <%
            }
        %>

        <div class="boton-volver">
            <a href="index.html" style="text-decoration: none;">
                <button type="button">Volver al inicio</button>
            </a>
        </div>
    </div>
</body>
</html>

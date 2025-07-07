<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrar Venta Múltiple</title>
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
            width: 95%;
            max-width: 1000px;
            text-align: center;
        }

        h1 {
            color: #0077cc;
            margin-bottom: 30px;
        }

        table {
            width: 100%;
            margin-bottom: 30px;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #0077cc;
            color: white;
        }

        input[type="number"] {
            width: 60px;
            padding: 5px;
        }

        .submit-btn,
        button {
            background-color: #0077cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-btn:hover,
        button:hover {
            background-color: #005fa3;
        }

        .volver {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="contenido">
    <h1>Registrar Venta</h1>
    <form action="VentaServlet" method="post">
        <table>
            <tr>
                <th>Producto</th>
                <th>Stock</th>
                <th>Precio</th>
                <th>Cantidad a vender</th>
            </tr>
            <%
                Connection con = Conexion.conectar();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM producto WHERE stock > 0");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String nombre = rs.getString("nombre");
                    int stock = rs.getInt("stock");
                    double precio = rs.getDouble("precio");
            %>
            <tr>
                <td><%= nombre %></td>
                <td><%= stock %></td>
                <td>$<%= precio %></td>
                <td>
                    <input type="hidden" name="producto_id" value="<%= id %>">
                    <input type="number" name="cantidad_<%= id %>" min="0" max="<%= stock %>" value="0">
                </td>
            </tr>
            <%
                }
                con.close();
            %>
        </table>

        <input class="submit-btn" type="submit" value="Registrar Venta">

        <div class="volver">
            <a href="index.jsp" style="text-decoration: none;">
                <button type="button">Volver al menú</button>
            </a>
        </div>
    </form>
</div>

<script>
    document.querySelector("form").addEventListener("submit", function(e) {
        let cantidades = document.querySelectorAll("input[type='number']");
        let alMenosUno = false;

        cantidades.forEach(function(input) {
            if (parseInt(input.value) > 0) {
                alMenosUno = true;
            }
        });

        if (!alMenosUno) {
            e.preventDefault();
            alert("No se ha seleccionado ningún producto.");
        }
    });
</script>
</body>
</html>
<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Historial de Ventas</title>
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
            max-width: 1000px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
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

        h1, h2 {
            text-align: center;
            color: #0077cc;
        }

        .venta-block {
            margin-bottom: 40px;
        }

        button {
            background-color: #0077cc;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #005fa3;
        }

        .boton-volver {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="contenido">
    <h1>Historial de Ventas</h1>

    <%
        Connection con = Conexion.conectar();
        Statement stmt = con.createStatement();
        ResultSet rsVentas = stmt.executeQuery("SELECT * FROM venta ORDER BY fecha DESC");

        while (rsVentas.next()) {
            int ventaId = rsVentas.getInt("id");
            String fecha = rsVentas.getString("fecha");
            double total = rsVentas.getDouble("total");
    %>

    <div class="venta-block">
        <h2>Venta #<%= ventaId %> - <%= fecha %></h2>
        <table>
            <tr>
                <th>Producto</th>
                <th>Cantidad</th>
                <th>Subtotal</th>
            </tr>
            <%
                PreparedStatement psDetalle = con.prepareStatement(
                    "SELECT vd.cantidad, vd.subtotal, p.nombre FROM venta_detalle vd " +
                    "JOIN producto p ON vd.producto_id = p.id WHERE vd.venta_id = ?"
                );
                psDetalle.setInt(1, ventaId);
                ResultSet rsDetalles = psDetalle.executeQuery();

                while (rsDetalles.next()) {
                    String nombreProducto = rsDetalles.getString("nombre");
                    int cantidad = rsDetalles.getInt("cantidad");
                    double subtotal = rsDetalles.getDouble("subtotal");
            %>
            <tr>
                <td><%= nombreProducto %></td>
                <td><%= cantidad %></td>
                <td>$<%= subtotal %></td>
            </tr>
            <%
                }
                rsDetalles.close();
                psDetalle.close();
            %>
            <tr>
                <td colspan="2"><strong>Total:</strong></td>
                <td><strong>$<%= total %></strong></td>
            </tr>
        </table>
    </div>

    <%
        }
        rsVentas.close();
        stmt.close();
        con.close();
    %>

    <div class="boton-volver">
        <a href="index.jsp" style="text-decoration: none;">
            <button type="button">Volver al menú</button>
        </a>
    </div>
</div>
</body>
</html>

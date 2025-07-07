<%@ page import="java.sql.*" %>
<%@ page import="modelo.Conexion" %>
<%@ page session="true" %>
<html>
<head>
    <title>Productos</title>
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
            max-width: 1100px;
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

        h1 {
            color: #0077cc;
            text-align: center;
            margin-bottom: 30px;
        }

        .producto-block {
            margin-bottom: 40px;
        }

        button, input[type="submit"] {
            background-color: #0077cc;
            color: white;
            padding: 6px 14px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
        }

        button:hover, input[type="submit"]:hover {
            background-color: #005fa3;
        }

        .form-agregar {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-agregar input[type="text"],
        .form-agregar input[type="number"] {
            padding: 8px;
            margin: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            width: 180px;
        }

        .boton-volver {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuario") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<div class="contenido">
    <h1>Lista de Productos</h1>

    <div class="form-agregar">
        <form action="ProductoServlet" method="post">
            <input type="text" name="nombre" placeholder="Nombre" required>
            <input type="text" name="descripcion" placeholder="Descripción" required>
            <input type="number" step="0.01" name="precio" placeholder="Precio" required>
            <input type="number" name="stock" placeholder="Stock" required>
            <input type="submit" value="Agregar Producto">
        </form>
    </div>

    <div class="producto-block">
        <table>
            <tr>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Acciones</th>
            </tr>
            <%
                Connection con = Conexion.conectar();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM producto");
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("nombre") %></td>
                <td><%= rs.getString("descripcion") %></td>
                <td>$<%= rs.getDouble("precio") %></td>
                <td><%= rs.getInt("stock") %></td>
                <td>
                    <form action="editar.jsp" method="get" style="display:inline;">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit">Editar</button>
                    </form>
                    <form action="EliminarProductoServlet" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                        <button type="submit" onclick="return confirm('¿Eliminar este producto?')">Eliminar</button>
                    </form>
                </td>
            </tr>
            <% } con.close(); %>
        </table>
    </div>
                <%
        String exito = request.getParameter("exito");
        String error = request.getParameter("error");

        if ("eliminado".equals(exito)) {
    %>
        <p style="color: green; text-align:center;">Producto eliminado correctamente.</p>
    <%
        } else if ("relacion".equals(error)) {
    %>
        <p style="color: red; text-align:center;">No se puede eliminar: el producto está vinculado a una venta.</p>
    <%
        } else if ("noeliminado".equals(error)) {
    %>
        <p style="color: orange; text-align:center;">El producto no pudo ser eliminado o no existe.</p>
    <%
        }
    %>
    <div class="boton-volver">
        <a href="index.jsp"><button>Volver al menú</button></a>
    </div>
</div>
</body>
</html>

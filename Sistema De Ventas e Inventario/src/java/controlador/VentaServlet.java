
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Conexion;
import java.sql.*;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/VentaServlet")
public class VentaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try (Connection con = Conexion.conectar()) {
            con.setAutoCommit(false); // Transacción

            // Paso 1: Obtener lista de IDs de productos
            String[] ids = request.getParameterValues("producto_id");

            if (ids == null) {
                response.getWriter().println("No se seleccionó ningún producto.");
                return;
            }

            // Mapa para producto y su cantidad
            Map<Integer, Integer> ventaMap = new HashMap<>();
            Map<Integer, Double> precioMap = new HashMap<>();
            double totalVenta = 0;

            for (String idStr : ids) {
                int id = Integer.parseInt(idStr);
                int cantidad = 0;
                try {
                    cantidad = Integer.parseInt(request.getParameter("cantidad_" + id));
                } catch (Exception e) {
                    cantidad = 0;
                }

                if (cantidad > 0) {
                    // Obtener precio y stock
                    PreparedStatement ps = con.prepareStatement("SELECT precio, stock FROM producto WHERE id = ?");
                    ps.setInt(1, id);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        double precio = rs.getDouble("precio");
                        int stock = rs.getInt("stock");

                        if (cantidad > stock) {
                            con.rollback();
                            response.getWriter().println("Stock insuficiente para producto ID: " + id);
                            return;
                        }

                        ventaMap.put(id, cantidad);
                        precioMap.put(id, precio);
                        totalVenta += cantidad * precio;
                    }
                    rs.close();
                    ps.close();
                }
            }

            if (ventaMap.isEmpty()) {
                con.rollback();
                response.getWriter().println("No se ingresó cantidad para ningún producto.");
                return;
            }

            // Paso 2: Insertar venta
            PreparedStatement psVenta = con.prepareStatement(
                "INSERT INTO venta (total) VALUES (?)",
                Statement.RETURN_GENERATED_KEYS
            );
            psVenta.setDouble(1, totalVenta);
            psVenta.executeUpdate();
            ResultSet rsVenta = psVenta.getGeneratedKeys();
            int ventaId = 0;
            if (rsVenta.next()) ventaId = rsVenta.getInt(1);
            rsVenta.close();
            psVenta.close();

            // Paso 3: Insertar detalles y actualizar stock
            for (Map.Entry<Integer, Integer> entry : ventaMap.entrySet()) {
                int productoId = entry.getKey();
                int cantidad = entry.getValue();
                double precio = precioMap.get(productoId);
                double subtotal = cantidad * precio;

                // Insertar detalle
                PreparedStatement psDetalle = con.prepareStatement(
                    "INSERT INTO venta_detalle (venta_id, producto_id, cantidad, subtotal) VALUES (?, ?, ?, ?)"
                );
                psDetalle.setInt(1, ventaId);
                psDetalle.setInt(2, productoId);
                psDetalle.setInt(3, cantidad);
                psDetalle.setDouble(4, subtotal);
                psDetalle.executeUpdate();
                psDetalle.close();

                // Actualizar stock
                PreparedStatement psStock = con.prepareStatement(
                    "UPDATE producto SET stock = stock - ? WHERE id = ?"
                );
                psStock.setInt(1, cantidad);
                psStock.setInt(2, productoId);
                psStock.executeUpdate();
                psStock.close();
            }

            con.commit(); // Guardar todo
            response.sendRedirect("historial.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error al registrar la venta.");
        }
    }
}


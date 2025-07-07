/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import modelo.Conexion;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegistroServlet")
public class RegistroServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contrasena = request.getParameter("contrasena");

        try (Connection con = Conexion.conectar()) {
            // Verifica si el correo ya está registrado
            PreparedStatement psCheck = con.prepareStatement("SELECT id FROM usuario WHERE correo = ?");
            psCheck.setString(1, correo);
            ResultSet rs = psCheck.executeQuery();

            if (rs.next()) {
                response.sendRedirect("registro.jsp?error=1");
            } else {
                PreparedStatement psInsert = con.prepareStatement(
                    "INSERT INTO usuario (nombre, correo, contrasena) VALUES (?, ?, ?)"
                );
                psInsert.setString(1, nombre);
                psInsert.setString(2, correo);
                psInsert.setString(3, contrasena);
                psInsert.executeUpdate();

                response.sendRedirect("registro.jsp?exito=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registro.jsp?error=1");
        }
    }
}

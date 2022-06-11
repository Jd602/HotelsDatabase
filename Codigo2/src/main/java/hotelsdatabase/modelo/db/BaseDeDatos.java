package hotelsdatabase.modelo.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class BaseDeDatos {
	
	private Connection conexion;
	
	public void conectar() throws SQLException {
		
		System.out.println("Conectandose...");
		this.conexion = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "LIBRO", "12345");
		
		System.out.println("Probando conexión...");
		System.out.println("Hora de la máquina: " + probar());
		
	}
	
	public Object probar() throws SQLException {
		Statement sentencia = this.conexion.createStatement();
		ResultSet resultado = sentencia.executeQuery("SELECT SYSDATE FROM DUAL");
		if (resultado.next()) {
			return resultado.getObject(1);
		}
		throw new RuntimeException("¡No se ha logrado establecer conexión con el servidor!");
	}
	
	public Connection getConexion() {
		return conexion;
	}

}

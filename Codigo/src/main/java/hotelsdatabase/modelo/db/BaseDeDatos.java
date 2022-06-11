package hotelsdatabase.modelo.db;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Hospedaje;
import hotelsdatabase.modelo.entidad.Regimen;
import hotelsdatabase.modelo.entidad.TipoHospedaje;
import hotelsdatabase.modelo.entidad.Vehiculo;

import java.sql.*;
import java.util.*;

public class BaseDeDatos {
	
	private Connection conexion;
	
	public void conectar() throws SQLException {
		
		System.out.println("Conectandose...");
		this.conexion = DriverManager.getConnection("jdbc:oracle:thin:PROYECTO/12345@localhost:1521:xe");
		
		System.out.println("Probando conexión...");
		System.out.println("Hora de la máquina: " + probar());
		
	}

	public List<TipoHospedaje> buscarTipoHospedajes() throws SQLException {
		List<TipoHospedaje> lista = new ArrayList<>();
		PreparedStatement sentencia = this.conexion.prepareStatement("select id, nombre from TipoHospedaje");
		ResultSet resultado = sentencia.executeQuery();
		while (resultado.next()) {
			lista.add(new TipoHospedaje(resultado.getInt("id"), resultado.getString("nombre")));
		}
		sentencia.close();
		return lista;
	}

	public List<Regimen> buscarRegimenes() throws SQLException {
		List<Regimen> lista = new ArrayList<>();
		PreparedStatement sentencia = this.conexion.prepareStatement("select id, descripcion from Regimen");
		ResultSet resultado = sentencia.executeQuery();
		while (resultado.next()) {
			lista.add(new Regimen(resultado.getInt("id"), resultado.getString("descripcion")));
		}
		return lista;
	}

	public Collection<Vehiculo> buscarVehiculos(int cantPasajeros, String tipo, String gama) throws SQLException {

		List<Vehiculo> lista = new ArrayList<>();

		String sql = "SELECT placa,marca,tipo,capacidad,valordia,gama FROM Vehiculo WHERE estado = 'disponible'";

		if (cantPasajeros >= 1) {
			sql += " AND capacidad >= " + cantPasajeros;
		}

		if (tipo != null) {
			sql += " AND tipo = '" + tipo + "'";
		}

		if (gama != null) {
			sql += " AND gama = '" + gama + "'";
		}

		PreparedStatement sentencia = this.conexion.prepareStatement(sql);
		ResultSet resultado = sentencia.executeQuery();
		while (resultado.next()) {
			lista.add(new Vehiculo(
					resultado.getString("placa"),
					resultado.getString("marca"),
					resultado.getString("tipo"),
					resultado.getInt("capacidad"),
					resultado.getInt("valordia"),
					resultado.getString("gama")
			));
		}

		return lista;

	}

	public Collection<Hospedaje> buscarHospedajes(String nombre, TipoHospedaje tipoHospedaje, Regimen regimen) throws SQLException {

		String sql = "select id, nombre, cancelaciones, tipohospedaje_id, regimen_id from HospedajeInfo";

		if (nombre != null && nombre.trim().length() > 0) {
			sql += " WHERE LOWER(nombre) LIKE '%" + nombre.trim().toLowerCase() + "%'";
		}

		if (tipoHospedaje != null && tipoHospedaje.getId() >= 0) {
			sql += " " + (sql.contains(" WHERE ") ? "AND" : "WHERE") + " ";
			sql += "tipohospedaje_id = " + tipoHospedaje.getId();
		}

		if (regimen != null && regimen.getId() >= 0) {
			sql += " " + (sql.contains(" WHERE ") ? "AND" : "WHERE") + " ";
			sql += "regimen_id = " + regimen.getId();
		}

		Map<Integer, Hospedaje> mapa = new HashMap<>();
		PreparedStatement sentencia = this.conexion.prepareStatement(sql);
		ResultSet resultado = sentencia.executeQuery();
		while (resultado.next()) {
			int id = resultado.getInt("id");
			Hospedaje hospedaje = mapa.getOrDefault(id, null);
			if (hospedaje == null) {
				hospedaje = new Hospedaje(
						id,
						resultado.getString("nombre"),
						resultado.getString("cancelaciones"),
						Aplicacion.getCore().buscarTipoHospedaje(resultado.getInt("tipohospedaje_id")),
						new ArrayList<>()
				);
				mapa.put(id, hospedaje);
			}
			hospedaje.getRegimenes().add(Aplicacion.getCore().buscarRegimen(resultado.getInt("regimen_id")));
		}

		return mapa.values();
	}
	
	public Object probar() throws SQLException {
		Statement sentencia = this.conexion.createStatement();
		ResultSet resultado = sentencia.executeQuery("SELECT SYSDATE FROM DUAL");
		if (resultado.next()) {
			return resultado.getObject(1);
		}
		throw new RuntimeException("?No se ha logrado establecer conexi?n con el servidor!");
	}
	
	public Connection getConexion() {
		return conexion;
	}

}

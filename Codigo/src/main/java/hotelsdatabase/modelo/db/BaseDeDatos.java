package hotelsdatabase.modelo.db;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.*;
import oracle.jdbc.OracleTypes;

import java.sql.*;
import java.sql.Date;
import java.time.LocalDate;
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

	public List<Ciudad> buscarCiudades() throws SQLException {
		List<Ciudad> lista = new ArrayList<>();
		PreparedStatement sentencia = this.conexion.prepareStatement("select id, nombre from Ciudad");
		ResultSet resultado = sentencia.executeQuery();
		while (resultado.next()) {
			lista.add(new Ciudad(resultado.getInt("id"), resultado.getString("nombre")));
		}
		return lista;
	}

	public Factura buscarFactura(int id) throws SQLException {
		Statement sentencia = this.conexion.createStatement();
		ResultSet resultado = sentencia.executeQuery("SELECT id, valorTotal, persona_cedula, persona_nombre, persona_apellido FROM FacturaInfo WHERE id = " + id);
		if (resultado.next()) {
			Persona persona = new Persona(
					resultado.getInt("persona_cedula"),
					resultado.getString("persona_nombre"),
					resultado.getString("persona_apellido")
			);
			return new Factura(
					id,
					persona,
					resultado.getFloat("valorTotal")
			);
		}
		return null;
	}

	public Factura crearReserva(int clienteCedula, String placaVehiculo, LocalDate fechaInicial, LocalDate fechaFinal) throws SQLException {
		String sql="begin ? := TR_RESERVA_VEHICULO(?,?,?,?); end;";

		CallableStatement sentencia = this.conexion.prepareCall(sql);
		sentencia.registerOutParameter(1, OracleTypes.INTEGER);
		sentencia.setInt(2, clienteCedula);
		sentencia.setString(3, placaVehiculo);
		sentencia.setDate(4, new Date(fechaInicial.toEpochDay()));
		sentencia.setDate(5, new Date(fechaFinal.toEpochDay()));
		sentencia.executeUpdate();

		int facturaId = sentencia.getInt(1);
		if (facturaId >= 0) {
			return buscarFactura(facturaId);
		}

		return null;
	}

	public Factura crearReserva(int clienteCedula, int hospedajeId, String nivel, LocalDate fechaInicio, int cantidadNoches, int cantidadHabitaciones) throws SQLException {
		String sql="begin ? := TR_RESERVA_CLIENTE(?,?,?,?,?,?); end;";

		CallableStatement sentencia = this.conexion.prepareCall(sql);
		sentencia.registerOutParameter(1, OracleTypes.INTEGER);
		sentencia.setInt(2, clienteCedula);
		sentencia.setInt(3, hospedajeId);
		sentencia.setString(4, nivel);
		sentencia.setDate(5, new Date(fechaInicio.toEpochDay()));
		sentencia.setInt(6, cantidadNoches);
		sentencia.setInt(7, cantidadHabitaciones);
		sentencia.executeUpdate();

		int facturaId = sentencia.getInt(1);
		if (facturaId >= 0) {
			return buscarFactura(facturaId);
		}

		return null;
	}

	public boolean crearVehiculo(Vehiculo vehiculo) throws SQLException {
		PreparedStatement sentencia = this.conexion.prepareStatement("INSERT INTO Vehiculo VALUES (?, ?, ?, ?, ?, ?, ?)");
		sentencia.setString(1, vehiculo.getPlaca());
		sentencia.setString(2, vehiculo.getMarca());
		sentencia.setString(3, vehiculo.getTipo());
		sentencia.setInt(4, vehiculo.getCapacidad());
		sentencia.setFloat(5, vehiculo.getValorPorDia());
		sentencia.setString(6, vehiculo.getGama());
		sentencia.setString(7, vehiculo.getEstado());
		return sentencia.executeUpdate() >= 1;
	}

	public boolean actualizarVehiculo(Vehiculo vehiculo) throws SQLException {
		PreparedStatement sentencia = this.conexion.prepareStatement("UPDATE Vehiculo SET marca = ?, tipo = ?, capacidad = ?, valordia = ?, gama = ?, estado = ? WHERE placa = ?");
		sentencia.setString(1, vehiculo.getMarca());
		sentencia.setString(2, vehiculo.getTipo());
		sentencia.setInt(3, vehiculo.getCapacidad());
		sentencia.setFloat(4, vehiculo.getValorPorDia());
		sentencia.setString(5, vehiculo.getGama());
		sentencia.setString(6, vehiculo.getEstado());
		sentencia.setString(7, vehiculo.getPlaca());
		return sentencia.executeUpdate() >= 1;
	}

	public Collection<Vehiculo> buscarVehiculos(int cantPasajeros, String tipo, String gama, boolean disponible) throws SQLException {

		List<Vehiculo> lista = new ArrayList<>();

		String sql = "SELECT placa,marca,tipo,capacidad,valordia,gama,estado FROM Vehiculo";

		if (disponible) {
			sql += " WHERE estado = 'disponible'";
		}

		if (cantPasajeros >= 1) {
			if (sql.contains("WHERE")) {
				sql += " AND ";
			} else {
				sql += " WHERE ";
			}
			sql += "capacidad >= " + cantPasajeros;
		}

		if (tipo != null) {
			if (sql.contains("WHERE")) {
				sql += " AND ";
			} else {
				sql += " WHERE ";
			}
			sql += "tipo = '" + tipo + "'";
		}

		if (gama != null) {
			if (sql.contains("WHERE")) {
				sql += " AND ";
			} else {
				sql += " WHERE ";
			}
			sql += "gama = '" + gama + "'";
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
					resultado.getString("gama"),
					resultado.getString("estado")
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

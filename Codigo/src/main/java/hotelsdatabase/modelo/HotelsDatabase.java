package hotelsdatabase.modelo;

import java.sql.SQLException;

import hotelsdatabase.modelo.db.BaseDeDatos;

public class HotelsDatabase {
	
	private BaseDeDatos baseDeDatos;

	protected HotelsDatabase() {}
	
	public void iniciar() throws SQLException {
		this.baseDeDatos = new BaseDeDatos();
		this.baseDeDatos.conectar();
	}
	
	public BaseDeDatos getBaseDeDatos() {
		return this.baseDeDatos;
	}
	
}

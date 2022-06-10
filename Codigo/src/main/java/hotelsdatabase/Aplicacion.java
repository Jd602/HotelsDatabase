package hotelsdatabase;

import java.sql.SQLException;

import hotelsdatabase.modelo.HotelsDatabaseSingleton;

public class Aplicacion {
	
	public static void main(String[] args) throws SQLException {
		
		// Conectar a base de datos.
		HotelsDatabaseSingleton.getSingleton().iniciar();
		
	}

}

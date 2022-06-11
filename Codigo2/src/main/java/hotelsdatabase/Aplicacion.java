package hotelsdatabase;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;

public class Aplicacion extends Application {

	@Override
	public void start(Stage escenario) throws Exception {
		Scene escena = new Scene(cargarFXML("aplicacion"), 600, 400);
		escenario.setScene(escena);
		escenario.show();
	}

	public static <T> T cargarFXML(String fxml) throws IOException {
		FXMLLoader cargador = new FXMLLoader(Aplicacion.class.getResource(fxml + ".fxml"));
		return cargador.load();
	}

	public static void main(String[] args) throws SQLException {

/*
		// Conectar a base de datos.
		HotelsDatabaseSingleton.getSingleton().iniciar();
*/

		// Lanzar la aplicación
		launch();
		System.out.println("Lanzador...");

	}

}

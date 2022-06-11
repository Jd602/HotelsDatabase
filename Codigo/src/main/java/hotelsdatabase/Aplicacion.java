package hotelsdatabase;

import hotelsdatabase.controlador.HospedajesBusquedaControlador;
import hotelsdatabase.controlador.ReservarHospedajeControlador;
import hotelsdatabase.controlador.ReservarVehiculoControlador;
import hotelsdatabase.controlador.VehiculosBusquedaControlador;
import hotelsdatabase.modelo.HotelsDatabase;
import hotelsdatabase.modelo.entidad.Hospedaje;
import hotelsdatabase.modelo.entidad.Vehiculo;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;

public class Aplicacion extends Application {

	private static final HotelsDatabase core = new HotelsDatabase();
	private static Aplicacion aplicacion;

	private Stage escenarioPrincipal;

	public Aplicacion() {
		aplicacion = this;
	}

	@Override
	public void start(Stage escenario) {
		this.escenarioPrincipal = escenario;
		try {
			mostrarVehiculosBusqueda();
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}

	public void mostrarVehiculosBusqueda() throws Throwable {
		VehiculosBusquedaControlador controlador = new VehiculosBusquedaControlador();
		Scene escena = new Scene(cargarFXML("VehiculosBusqueda", controlador), 800, 600);
		this.escenarioPrincipal.setScene(escena);
		this.escenarioPrincipal.show();
		controlador.buscar(null);
	}

	public void mostrarReservarVehiculo(Vehiculo vehiculo) throws IOException {
		ReservarVehiculoControlador controlador = new ReservarVehiculoControlador();
		Scene escena = new Scene(cargarFXML("ReservaVehiculo", controlador), 800, 600);
		this.escenarioPrincipal.setScene(escena);
		this.escenarioPrincipal.show();
		controlador.iniciar(vehiculo);
	}

	public void mostrarHospedajesBusqueda() throws Throwable {
		HospedajesBusquedaControlador controlador = new HospedajesBusquedaControlador();
		Scene escena = new Scene(cargarFXML("HospedajesBusqueda", controlador), 800, 600);
		this.escenarioPrincipal.setScene(escena);
		this.escenarioPrincipal.show();
		controlador.buscar(null);
	}

	public void mostrarReservarHospedaje(Hospedaje hospedaje) throws IOException {
		ReservarHospedajeControlador controlador = new ReservarHospedajeControlador();
		Scene escena = new Scene(cargarFXML("ReservaHospedaje", controlador), 800, 600);
		this.escenarioPrincipal.setScene(escena);
		this.escenarioPrincipal.show();
		controlador.iniciar(hospedaje);
	}

	public static <T> T cargarFXML(String fxml, Object controlador) throws IOException {
		FXMLLoader cargador = new FXMLLoader(Aplicacion.class.getResource("/" + fxml + ".fxml"));
		if (controlador != null) {
			cargador.setController(controlador);
		}
		return cargador.load();
	}

	public static Aplicacion getAplicacion() {
		return aplicacion;
	}

	public static HotelsDatabase getCore() {
		return core;
	}

	public static void main(String[] args) throws SQLException {

		// Conectar a base de datos.
		getCore().iniciar();

		// Lanzar la aplicación
		launch();

	}

}

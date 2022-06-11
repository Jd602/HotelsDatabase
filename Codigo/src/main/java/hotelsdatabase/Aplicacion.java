package hotelsdatabase;

import hotelsdatabase.controlador.*;
import hotelsdatabase.modelo.HotelsDatabase;
import hotelsdatabase.modelo.entidad.Factura;
import hotelsdatabase.modelo.entidad.Hospedaje;
import hotelsdatabase.modelo.entidad.Vehiculo;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

import java.io.IOException;
import java.sql.SQLException;

public class Aplicacion extends Application {

	private static final HotelsDatabase core = new HotelsDatabase();
	private static Aplicacion aplicacion;

	private BorderPane escenaPrincipal;

	public Aplicacion() {
		aplicacion = this;
	}

	@Override
	public void start(Stage escenario) {
		try {

			this.escenaPrincipal = cargarFXML("Aplicacion", new AplicacionControlador());
			Scene escena = new Scene(this.escenaPrincipal, 800, 600);
			escenario.setScene(escena);
			escenario.show();

			mostrarVehiculosCRUD();
		} catch (Throwable e) {
			throw new RuntimeException(e);
		}
	}

	public void mostrarVehiculosCRUD() throws Throwable {
		VehiculosControlador controlador = new VehiculosControlador();
		this.escenaPrincipal.setCenter(cargarFXML("VehiculosCRUD", controlador));
		controlador.cargar(false);
	}

	public void mostrarVehiculosBusqueda() throws Throwable {
		VehiculosBusquedaControlador controlador = new VehiculosBusquedaControlador();
		this.escenaPrincipal.setCenter(cargarFXML("VehiculosBusqueda", controlador));
		controlador.buscar(null);
	}

	public void mostrarReservarVehiculo(Vehiculo vehiculo) throws IOException {
		ReservarVehiculoControlador controlador = new ReservarVehiculoControlador();
		this.escenaPrincipal.setCenter(cargarFXML("ReservaVehiculo", controlador));
		controlador.iniciar(vehiculo);
	}

	public void mostrarHospedajesBusqueda() throws Throwable {
		HospedajesBusquedaControlador controlador = new HospedajesBusquedaControlador();
		this.escenaPrincipal.setCenter(cargarFXML("HospedajesBusqueda", controlador));
		controlador.buscar(null);
	}

	public void mostrarReservarHospedaje(Hospedaje hospedaje) throws IOException {
		ReservarHospedajeControlador controlador = new ReservarHospedajeControlador();
		this.escenaPrincipal.setCenter(cargarFXML("ReservaHospedaje", controlador));
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

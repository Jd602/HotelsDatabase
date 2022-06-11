package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;

public class AplicacionControlador {

    @FXML
    void abrirCrudVehiculos(ActionEvent event) throws Throwable {
        Aplicacion.getAplicacion().mostrarVehiculosCRUD();
    }

    @FXML
    void abrirTransaccionHospedaje(ActionEvent event) throws Throwable {
        Aplicacion.getAplicacion().mostrarHospedajesBusqueda();
    }

    @FXML
    void abrirTransaccionVehiculo(ActionEvent event) throws Throwable {
        Aplicacion.getAplicacion().mostrarVehiculosBusqueda();
    }

}

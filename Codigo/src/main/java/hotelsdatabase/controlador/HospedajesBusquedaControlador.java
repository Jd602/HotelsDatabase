package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Hospedaje;
import hotelsdatabase.modelo.entidad.Regimen;
import hotelsdatabase.modelo.entidad.TipoHospedaje;
import javafx.beans.property.SimpleStringProperty;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;

import javax.swing.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HospedajesBusquedaControlador {

    @FXML
    TextField textFieldNombre;

    @FXML
    ComboBox<TipoHospedaje> comboBoxTipoHospedaje;

    @FXML
    ComboBox<Regimen> comboBoxRegimen;

    @FXML
    TableView<Hospedaje> tableHospedaje;

    @FXML
    TableColumn<Hospedaje, String> tableColumnHospedaje;

    @FXML
    TableColumn<Hospedaje, String> tableColumnTipoHospedaje;

    @FXML
    TableColumn<Hospedaje, String> tableColumnCancelaciones;

    @FXML
    TableColumn<Hospedaje, String> tableColumnRegimenes;

    @FXML
    public void reservar(ActionEvent evento) throws IOException {

        Hospedaje hospedajeSeleccionado = tableHospedaje.getSelectionModel().getSelectedItem();
        if (hospedajeSeleccionado == null) {
            JOptionPane.showMessageDialog(null, "No se ha seleccionado el hospedaje en el que se desea reservar.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Aplicacion.getAplicacion().mostrarReservarHospedaje(hospedajeSeleccionado);

    }

    @FXML
    public void buscar(ActionEvent evento) throws SQLException {

        // Cargar todos los elementos.
        if (evento == null) {

            List<TipoHospedaje> tipoHospedajes = Aplicacion.getCore().getTipoHospedajes();
            comboBoxTipoHospedaje.getItems().addAll(tipoHospedajes);
            comboBoxTipoHospedaje.setValue(tipoHospedajes.get(0));

            List<Regimen> regimenes = Aplicacion.getCore().getRegimenes();
            comboBoxRegimen.getItems().addAll(regimenes);
            comboBoxRegimen.setValue(regimenes.get(0));

            tableColumnHospedaje.setCellValueFactory(new PropertyValueFactory<>("nombre"));
            tableColumnTipoHospedaje.setCellValueFactory(new PropertyValueFactory<>("tipoHospedaje"));
            tableColumnCancelaciones.setCellValueFactory(hospedaje -> {
                if (hospedaje.getValue().getCancelaciones() == null) {
                    return new SimpleStringProperty("¡No tiene permitido cancelar la reservación!");
                } else {
                    return new SimpleStringProperty(hospedaje.getValue().getCancelaciones());
                }
            });
            tableColumnRegimenes.setCellValueFactory(hospedaje -> {
                List<String> lista = new ArrayList<>();
                for (Regimen regimen: hospedaje.getValue().getRegimenes()) {
                    lista.add(regimen.getDescripcion());
                }
                return new SimpleStringProperty(lista.isEmpty() ? "¡No tienen ningún regimen registrado!" : String.join(", ", lista));
            });

        }

        tableHospedaje.getItems().clear();
        tableHospedaje.getItems().addAll(Aplicacion.getCore().getBaseDeDatos().buscarHospedajes(
                textFieldNombre.getText(),
                comboBoxTipoHospedaje.getValue(),
                comboBoxRegimen.getValue())
        );

    }

}

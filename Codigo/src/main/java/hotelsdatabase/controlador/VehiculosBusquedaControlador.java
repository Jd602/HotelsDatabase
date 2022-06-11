package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Hospedaje;
import hotelsdatabase.modelo.entidad.Vehiculo;
import javafx.beans.property.SimpleIntegerProperty;
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
import java.util.Arrays;
import java.util.List;

public class VehiculosBusquedaControlador {

    @FXML
    private TextField textFieldCantPasajeros;

    @FXML
    private ComboBox<String> comboBoxTipo;

    @FXML
    private ComboBox<String> comboBoxGama;

    @FXML
    private TableView<Vehiculo> tableVehiculo;

    @FXML
    private TableColumn<Vehiculo, String> tableColumnPlaca;

    @FXML
    private TableColumn<Vehiculo, String> tableColumnMarca;

    @FXML
    private TableColumn<Vehiculo, String> tableColumnTipo;

    @FXML
    private TableColumn<Vehiculo, Integer> tableColumnCapacidad;

    @FXML
    private TableColumn<Vehiculo, Integer> tableColumnValorDia;

    @FXML
    public void buscar(ActionEvent evento) throws SQLException {

        if (evento == null) {

            this.textFieldCantPasajeros.setText("1");

            // Tipo
            comboBoxTipo.getItems().addAll(Arrays.asList("Cualquier tipo", "sedán", "camioneta", "van", "SUV", "deportivo"));
            comboBoxTipo.getSelectionModel().select(0);

            // Gama
            comboBoxGama.getItems().addAll(Arrays.asList("Cualquier gama", "media", "alta", "baja"));
            comboBoxGama.getSelectionModel().select(0);

            // Tabla
            tableColumnPlaca.setCellValueFactory(new PropertyValueFactory<>("placa"));
            tableColumnMarca.setCellValueFactory(new PropertyValueFactory<>("marca"));
            tableColumnTipo.setCellValueFactory(new PropertyValueFactory<>("tipo"));
            tableColumnCapacidad.setCellValueFactory(new PropertyValueFactory<>("capacidad"));
            tableColumnValorDia.setCellValueFactory(new PropertyValueFactory<>("valorPorDia"));

        }

        int cantPasajeros = 1;
        if (this.textFieldCantPasajeros.getText().length() > 0) {
            try {
                cantPasajeros = Integer.parseInt(this.textFieldCantPasajeros.getText());

                if (cantPasajeros <= 0) {
                    JOptionPane.showMessageDialog(null, "La cantidad de pasajeros debe ser al menos uno.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
                    return;
                }

            } catch (Throwable ex) {
                JOptionPane.showMessageDialog(null, "La cantidad de pasajeros es incorrecto.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
                return;
            }
        }

        String tipo = comboBoxTipo.getSelectionModel().getSelectedIndex() == 0 ? null : comboBoxTipo.getValue();
        String gama = comboBoxGama.getSelectionModel().getSelectedIndex() == 0 ? null : comboBoxGama.getValue();

        tableVehiculo.getItems().clear();
        tableVehiculo.getItems().addAll(
                Aplicacion.getCore().getBaseDeDatos().buscarVehiculos(cantPasajeros, tipo, gama)
        );

    }

    @FXML
    public void cancelar(ActionEvent evento) throws Throwable {
        Aplicacion.getAplicacion().mostrarVehiculosBusqueda();
    }

    @FXML
    void reservar(ActionEvent evento) throws IOException {

        Vehiculo vehiculoSeleccionado = tableVehiculo.getSelectionModel().getSelectedItem();
        if (vehiculoSeleccionado == null) {
            JOptionPane.showMessageDialog(null, "No se ha seleccionado el vehiculo en el que se desea reservar.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Aplicacion.getAplicacion().mostrarReservarVehiculo(vehiculoSeleccionado);

    }

}

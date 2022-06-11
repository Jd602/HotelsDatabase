package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Vehiculo;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.util.Callback;

import javax.swing.*;
import java.sql.SQLException;

public class VehiculosControlador {

    @FXML
    private TableView<Vehiculo> tableVehiculos;

    @FXML
    private TableColumn<Vehiculo, String> tableVehiculosPlaca;

    @FXML
    private TableColumn<Vehiculo, String> tableVehiculosMarca;

    @FXML
    private TableColumn<Vehiculo, String> tableVehiculosTipo;

    @FXML
    private TableColumn<Vehiculo, Integer> tableVehiculosCapacidad;

    @FXML
    private TableColumn<Vehiculo, String> tableValorPorDia;

    @FXML
    private TableColumn<Vehiculo, String> tableGama;

    @FXML
    private TableColumn<Vehiculo, String> tableEstado;

    @FXML
    private TextField textFieldPlaca;

    @FXML
    private TextField textFieldMarca;

    @FXML
    private TextField textFieldTipo;

    @FXML
    private TextField textFieldCapacidad;

    @FXML
    private TextField textFieldValorPorDia;

    @FXML
    private TextField textFieldGama;

    @FXML
    private Button crearVehiculoBoton;

    @FXML
    private Button cancelarBoton;

    @FXML
    private TabPane tabulador;

    private Vehiculo vehiculo;

    @FXML
    void crear(ActionEvent event) throws SQLException {

        String placa = textFieldPlaca.getText();
        String marca = textFieldMarca.getText();
        String tipo = textFieldTipo.getText();
        int capacidad = 0;
        int valorPorDia = 0;
        String gama = textFieldGama.getText();

        if (placa.trim().isEmpty()) {
            JOptionPane.showMessageDialog(null, "No se ha ingresado la placa.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (marca.trim().isEmpty()) {
            JOptionPane.showMessageDialog(null, "No se ha ingresado la marca.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (tipo.trim().isEmpty()) {
            JOptionPane.showMessageDialog(null, "No se ha ingresado el tipo.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try {

            capacidad = Integer.parseInt(textFieldCapacidad.getText());

            if (capacidad <= 0) {
                JOptionPane.showMessageDialog(null, "La capacidad debe ser al menos 1.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
                return;
            }

        } catch (Throwable ex) {
            JOptionPane.showMessageDialog(null, "La capacidad ingresada es incorrecta.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        if (gama.trim().isEmpty()) {
            gama = null;
        }


        try {

            valorPorDia = Integer.parseInt(textFieldValorPorDia.getText());

            if (valorPorDia <= 0) {
                JOptionPane.showMessageDialog(null, "El valor por dia debe ser al menos 1.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
                return;
            }

        } catch (Throwable ex) {
            JOptionPane.showMessageDialog(null, "El valor por dia ingresada es incorrecta.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Vehiculo nuevoVehiculo = new Vehiculo(
                placa,
                marca,
                tipo,
                capacidad,
                valorPorDia,
                gama,
                vehiculo == null ?  "disponible" : vehiculo.getEstado()
        );

        if (this.vehiculo == null) {
            if (Aplicacion.getCore().getBaseDeDatos().crearVehiculo(nuevoVehiculo)) {
                JOptionPane.showMessageDialog(null, "Se ha creado correctamente un vehiculo:\n  - Placa: " + nuevoVehiculo.getPlaca() + "\n  - Capacidad: " + capacidad + "\n  - Valor por Dia: " + valorPorDia, "Información", JOptionPane.INFORMATION_MESSAGE);
                tabulador.getSelectionModel().select(0);
                cargar(true);
            } else {
                JOptionPane.showMessageDialog(null, "No se ha podido crear el vehiculo.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            }
        } else {
            reiniciarEstado();
            if (Aplicacion.getCore().getBaseDeDatos().actualizarVehiculo(nuevoVehiculo)) {
                JOptionPane.showMessageDialog(null, "Se ha actualizado correctamente el vehiculo: #" + nuevoVehiculo.getPlaca(), "Información", JOptionPane.INFORMATION_MESSAGE);
                tabulador.getSelectionModel().select(0);
                cargar(true);
            } else {
                JOptionPane.showMessageDialog(null, "No se ha podido actualizar el vehiculo.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            }
        }


    }

    private void reiniciarEstado() {
        this.textFieldPlaca.setText("");
        this.textFieldMarca.setText("");
        this.textFieldTipo.setText("");
        this.textFieldCapacidad.setText("");
        this.textFieldValorPorDia.setText("");
        this.textFieldGama.setText("");
        this.crearVehiculoBoton.setText("Crear Vehiculo");
        this.cancelarBoton.setDisable(true);
        this.vehiculo = null;
    }

    @FXML
    void cancelarEdicion(ActionEvent event) {
        reiniciarEstado();
    }

    @FXML
    void modificar(ActionEvent event) {

        Vehiculo vehiculo = this.tableVehiculos.getSelectionModel().getSelectedItem();
        if (vehiculo == null) {
            JOptionPane.showMessageDialog(null, "No se ha seleccionado el vehiculo que se desea modificar.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        this.textFieldPlaca.setEditable(false);
        this.textFieldPlaca.setText(vehiculo.getPlaca());

        this.textFieldMarca.setText(vehiculo.getMarca());
        this.textFieldTipo.setText(vehiculo.getTipo());
        this.textFieldCapacidad.setText(String.valueOf(vehiculo.getCapacidad()));
        this.textFieldValorPorDia.setText(String.valueOf(vehiculo.getValorPorDia()));
        this.textFieldGama.setText(vehiculo.getGama() == null ? "" : vehiculo.getGama());

        this.crearVehiculoBoton.setText("Guardar Cambios");
        this.cancelarBoton.setDisable(false);

        tabulador.getSelectionModel().select(1);
        this.vehiculo = vehiculo;

    }


    public void cargar(boolean recargar) throws SQLException {


        if (!recargar) {
            // Tabla
            tableVehiculosPlaca.setCellValueFactory(new PropertyValueFactory<>("placa"));
            tableVehiculosMarca.setCellValueFactory(new PropertyValueFactory<>("marca"));
            tableVehiculosTipo.setCellValueFactory(new PropertyValueFactory<>("tipo"));
            tableVehiculosCapacidad.setCellValueFactory(new PropertyValueFactory<>("capacidad"));
            tableValorPorDia.setCellValueFactory(new PropertyValueFactory<>("valorPorDia"));
            tableGama.setCellValueFactory(vehiculo -> {
                if (vehiculo.getValue().getGama() != null) {
                    return new SimpleStringProperty(vehiculo.getValue().getGama());
                } else {
                    return new SimpleStringProperty("No definida.");
                }
            });
            tableEstado.setCellValueFactory(vehiculo -> {
                if (vehiculo.getValue().getEstado() != null) {
                    return new SimpleStringProperty(vehiculo.getValue().getEstado());
                } else {
                    return new SimpleStringProperty("mantenimiento");
                }
            });
        }

        this.tableVehiculos.getItems().clear();
        this.tableVehiculos.getItems().addAll(Aplicacion.getCore().getBaseDeDatos().buscarVehiculos(0, null, null, false));

    }

}

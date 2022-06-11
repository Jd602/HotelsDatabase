package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Factura;
import hotelsdatabase.modelo.entidad.Hospedaje;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import javax.swing.*;
import java.sql.SQLException;
import java.time.Duration;
import java.time.LocalDate;
import java.util.Arrays;

public class ReservarHospedajeControlador {

    @FXML
    private Label labelHospedajeNombre;

    @FXML
    private DatePicker datePickerFechaInicio;

    @FXML
    private DatePicker datePickerFechaFinal;

    @FXML
    private ComboBox<String> comboBoxNivelHabitacion;

    @FXML
    private TextField textFieldCedula;

    @FXML
    private TextField textFieldNumHabitacion;

    @FXML
    private Label labelNumNoches;

    private Hospedaje hospedaje;

    @FXML
    public void onCambioFechaInicial(ActionEvent evento) {

        LocalDate fechaInicial = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaFinal != null && fechaInicial.toEpochDay() > fechaFinal.toEpochDay()) {
            this.datePickerFechaInicio.setValue(fechaFinal);
            this.datePickerFechaFinal.setValue(fechaInicial);
        }

        calcularNoches();
    }

    @FXML
    public void onCambioFechaFinal(ActionEvent evento) {

        LocalDate fechaInicial = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaFinal.toEpochDay() < fechaInicial.toEpochDay()) {
            this.datePickerFechaInicio.setValue(fechaFinal);
            this.datePickerFechaFinal.setValue(fechaInicial);
        }

        calcularNoches();
    }

    public void iniciar(Hospedaje hospedaje) {

        this.hospedaje = hospedaje;
        this.labelHospedajeNombre.setText(hospedaje.getNombre());

        LocalDate actualFecha = LocalDate.now();
        LocalDate siguienteFecha = actualFecha.plusDays(1);
        this.datePickerFechaInicio.setValue(actualFecha);
        this.datePickerFechaFinal.setValue(siguienteFecha);

        this.comboBoxNivelHabitacion.getItems().addAll(Arrays.asList("Alto", "Medio", "Bajo"));
        this.comboBoxNivelHabitacion.setValue("Medio");
        this.textFieldNumHabitacion.setText("1");

        // Calcular noches
        calcularNoches();

    }

    public void calcularNoches() {
        LocalDate fechaActual = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaActual == null || fechaFinal == null) {
            return;
        }

        labelNumNoches.setText(String.valueOf(Duration.between(fechaActual.atStartOfDay(), fechaFinal.atStartOfDay()).toDays()));
    }

    private String formatoFecha(LocalDate fecha) {
        return "DATE'" + fecha.getYear() + "-" + fecha.getMonthValue() + "-" + fecha.getDayOfMonth();
    }

    @FXML
    public void cancelar(ActionEvent evento) throws Throwable {
        Aplicacion.getAplicacion().mostrarHospedajesBusqueda();
    }

    @FXML
    public void ejecutar(ActionEvent evento) throws Throwable {

        int cedula;
        int numHabitaciones;
        String nivelHabitacion = this.comboBoxNivelHabitacion.getValue().toLowerCase();
        Long cantidadNoches = Duration.between(this.datePickerFechaInicio.getValue().atStartOfDay(), this.datePickerFechaFinal.getValue().atStartOfDay()).toDays();

        try {
            cedula = Integer.parseInt(this.textFieldCedula.getText());
        } catch (Throwable ex) {
            JOptionPane.showMessageDialog(null, "El número de cédula es incorrecto.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        try {
            numHabitaciones = Integer.parseInt(this.textFieldNumHabitacion.getText());

            if (numHabitaciones <= 0) {
                JOptionPane.showMessageDialog(null, "El número ingresado de habitaciones debe ser al menos uno.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
                return;
            }

        } catch (Throwable ex) {
            JOptionPane.showMessageDialog(null, "El número ingresado de habitaciones es incorrecto.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Factura factura = Aplicacion.getCore().getBaseDeDatos().crearReserva(cedula, this.hospedaje.getId(), nivelHabitacion, datePickerFechaInicio.getValue(), cantidadNoches.intValue(), numHabitaciones);
        if (factura == null) {
            JOptionPane.showMessageDialog(null, "No se han encontrado las habitaciones requeridas.", "¡Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        JOptionPane.showMessageDialog(null, "Se ha creado la reserva de un hospedaje con factura (#" + factura.getId() + ") registrada al cliente " + factura.getPersona().getNombreCompleto() + " por un valor de: $" + factura.getValorTotal(), "¡Factura Creada!", JOptionPane.INFORMATION_MESSAGE);
        Aplicacion.getAplicacion().mostrarHospedajesBusqueda();

    }

}

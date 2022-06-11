package hotelsdatabase.controlador;

import hotelsdatabase.Aplicacion;
import hotelsdatabase.modelo.entidad.Factura;
import hotelsdatabase.modelo.entidad.Vehiculo;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;

import javax.swing.*;
import java.time.Duration;
import java.time.LocalDate;

public class ReservarVehiculoControlador {

    @FXML
    private Label labelPlaca;

    @FXML
    private Label labelMarca;

    @FXML
    private Label labelGama;

    @FXML
    private Label labelTipo;

    @FXML
    private Label labelCapacidadMaxima;

    @FXML
    private Label labelValorPorDia;

    @FXML
    private TextField textFieldCedula;

    @FXML
    private DatePicker datePickerFechaInicio;

    @FXML
    private DatePicker datePickerFechaFinal;

    @FXML
    private Label labelDias;

    @FXML
    private Label labelValorTotal;

    private Vehiculo vehiculo;

    public void iniciar(Vehiculo vehiculo) {

        this.vehiculo = vehiculo;

        this.labelPlaca.setText(vehiculo.getPlaca());
        this.labelMarca.setText(vehiculo.getMarca());
        this.labelGama.setText(vehiculo.getGama() == null ? "baja" : vehiculo.getGama() );
        this.labelTipo.setText(vehiculo.getTipo());
        this.labelCapacidadMaxima.setText(String.valueOf(vehiculo.getCapacidad()));
        this.labelValorPorDia.setText(String.valueOf(vehiculo.getValorPorDia()));

        LocalDate actualFecha = LocalDate.now();
        LocalDate siguienteFecha = actualFecha.plusDays(1);
        this.datePickerFechaInicio.setValue(actualFecha);
        this.datePickerFechaFinal.setValue(siguienteFecha);

        calcularDias();

    }

    public void calcularDias() {
        LocalDate fechaActual = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaActual == null || fechaFinal == null) {
            return;
        }

        long dias = Duration.between(fechaActual.atStartOfDay(), fechaFinal.atStartOfDay()).toDays();
        this.labelDias.setText(String.valueOf(dias));
        this.labelValorTotal.setText(String.valueOf(this.vehiculo.getValorPorDia() * dias));

    }

    @FXML
    void cancelar(ActionEvent event) throws Throwable {
        Aplicacion.getAplicacion().mostrarVehiculosBusqueda();
    }

    @FXML
    public void ejecutar(ActionEvent evento) throws Throwable {

        int cedula;

        try {
            cedula = Integer.parseInt(this.textFieldCedula.getText());
        } catch (Throwable ex) {
            JOptionPane.showMessageDialog(null, "El n�mero de c�dula es incorrecto.", "�Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        Factura factura = Aplicacion.getCore().getBaseDeDatos().crearReserva(
                cedula,
                this.vehiculo.getPlaca(),
                datePickerFechaInicio.getValue(),
                datePickerFechaFinal.getValue());
        if (factura == null) {
            JOptionPane.showMessageDialog(null, "El vehiculo actualmente no se encuentra disponible.", "�Ha ocurrido un error!", JOptionPane.ERROR_MESSAGE);
            return;
        }

        JOptionPane.showMessageDialog(null, "Se ha creado la reserva de un vehiculo #" + vehiculo.getPlaca() + " con factura (#" + factura.getId() + ") registrada al cliente " + factura.getPersona().getNombreCompleto() + " por un valor de: $" + factura.getValorTotal(), "�Factura Creada!", JOptionPane.INFORMATION_MESSAGE);
        Aplicacion.getAplicacion().mostrarVehiculosBusqueda();

    }

    @FXML
    public void onCambioFechaInicial(ActionEvent evento) {

        LocalDate fechaInicial = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaFinal != null && fechaInicial.toEpochDay() > fechaFinal.toEpochDay()) {
            this.datePickerFechaInicio.setValue(fechaFinal);
            this.datePickerFechaFinal.setValue(fechaInicial);
        }

        calcularDias();
    }

    @FXML
    public void onCambioFechaFinal(ActionEvent evento) {

        LocalDate fechaInicial = this.datePickerFechaInicio.getValue();
        LocalDate fechaFinal = this.datePickerFechaFinal.getValue();

        if (fechaFinal.toEpochDay() < fechaInicial.toEpochDay()) {
            this.datePickerFechaInicio.setValue(fechaFinal);
            this.datePickerFechaFinal.setValue(fechaInicial);
        }

        calcularDias();
    }

    private String formatoFecha(LocalDate fecha) {
        return "DATE'" + fecha.getYear() + "-" + fecha.getMonthValue() + "-" + fecha.getDayOfMonth();
    }

}

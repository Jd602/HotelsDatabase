package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class Persona {

    private final int cedula;
    private final String nombre;
    private final String apellido;

    public String getNombreCompleto() {
        return this.nombre + " " + this.apellido;
    }

}

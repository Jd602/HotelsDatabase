package hotelsdatabase.modelo.entidad;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class Factura {

    private final int id;
    private final Persona persona;
    private final float valorTotal;

}

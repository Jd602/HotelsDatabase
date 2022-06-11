package hotelsdatabase.modelo;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import hotelsdatabase.modelo.db.BaseDeDatos;
import hotelsdatabase.modelo.entidad.Regimen;
import hotelsdatabase.modelo.entidad.TipoHospedaje;
import lombok.Getter;

public class HotelsDatabase {

	@Getter
	private BaseDeDatos baseDeDatos;

	@Getter
	private final List<TipoHospedaje> tipoHospedajes = new ArrayList<>();

	@Getter
	private final List<Regimen> regimenes = new ArrayList<>();

	public HotelsDatabase() {}

	private void cargarTipoHospedajes() throws SQLException {
		this.tipoHospedajes.add(new TipoHospedaje(-1, "Sin Selección"));
		this.tipoHospedajes.addAll(baseDeDatos.buscarTipoHospedajes());
	}

	public TipoHospedaje buscarTipoHospedaje(int id) {
		for (TipoHospedaje tipoHospedaje: this.tipoHospedajes) {
			if (tipoHospedaje.getId() == id) {
				return tipoHospedaje;
			}
		}
		return null;
	}

	private void cargarRegimenes() throws SQLException {
		this.regimenes.add(new Regimen(-1, "Sin Selección"));
		this.regimenes.addAll(baseDeDatos.buscarRegimenes());
	}

	public Regimen buscarRegimen(int id) {
		for (Regimen regimen: this.regimenes) {
			if (regimen.getId() == id) {
				return regimen;
			}
		}
		return null;
	}

	public void iniciar() throws SQLException {

		this.baseDeDatos = new BaseDeDatos();
		this.baseDeDatos.conectar();

		// Cargar los tipos de hospedajes
		cargarTipoHospedajes();
		cargarRegimenes();

	}

}

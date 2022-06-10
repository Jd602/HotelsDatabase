package hotelsdatabase.modelo;

public class HotelsDatabaseSingleton {

	private static final HotelsDatabase singleton = new HotelsDatabase();
	
	public static HotelsDatabase getSingleton() {
		return singleton;
	}
	
}

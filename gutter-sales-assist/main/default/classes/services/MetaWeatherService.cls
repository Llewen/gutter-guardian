public with sharing class MetaWeatherService implements IForecastService {
    public MetaWeatherService() {

    }

    public WeatherForecast getWeatherForecastForLocation(String location) {
        return new WeatherForecast(null);
    }
}

public class WeatherForecast {
    public List<DailyWeatherForecast> dailyWeatherForecasts { get; private set; }

    public WeatherForecast(List<DailyWeatherForecast> dailyWeatherForecasts) {
        this.dailyWeatherForecasts = dailyWeatherForecasts;
    }
}

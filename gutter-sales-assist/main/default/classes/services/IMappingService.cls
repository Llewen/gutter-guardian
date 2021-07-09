public interface IMappingService {
    SalesScoreAndForecastDto getDto(WeatherForecast forecast, Integer salesScore);
}

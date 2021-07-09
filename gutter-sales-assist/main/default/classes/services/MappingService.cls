public with sharing class MappingService implements IMappingService {
    public SalesScoreAndForecastDto  getDto(WeatherForecast forecast, Integer salesScore) {
        SalesScoreAndForecastDto response = new SalesScoreAndForecastDto();
        response.salesScore = salesScore;
        response.forecast = new ForecastDto();

        if (forecast != null) {
            List<DailyForecastDto> dailyForecastDtos = new List<DailyForecastDto>();
            for (DailyWeatherForecast dailyForecast : forecast.consolidated_weather) {
                DailyForecastDto dailyForecastDto = new DailyForecastDto();
                dailyForecastDto.forecastDate = dailyForecast.applicable_date;
                dailyForecastDto.weatherAbbreviation = dailyForecast.weather_state_abbr;
                dailyForecastDtos.add(dailyForecastDto);    
            }
            response.forecast.dailyForecasts = dailyForecastDtos;
        }

        return response;
    }
}

public with sharing class ForecastController {
    @TestVisible private static IForecastService forecastService = new MetaWeatherService();
    @TestVisible private static ISalesScoringService salesScoringService = new SalesScoringService();

    @AuraEnabled(Cacheable = true)
    public static string getSalesScoreWithForecast(String location) {
        try {
            WeatherForecast forecast = forecastService.getWeatherForecastForLocation(location);
            Integer salesScore = salesScoringService.getSalesScoreFromForecast(forecast);

            SalesScoreAndForecastDto response = new SalesScoreAndForecastDto();
            response.salesScore = salesScore;
            response.forecast = new ForecastDto();

            List<DailyForecastDto> dailyForecastDtos = new List<DailyForecastDto>();
            for (DailyWeatherForecast dailyForecast : forecast.consolidated_weather) {
                DailyForecastDto dailyForecastDto = new DailyForecastDto();
                dailyForecastDto.forecastDate = dailyForecast.applicable_date;
                dailyForecastDto.weatherAbbreviation = dailyForecast.weather_state_abbr;
                dailyForecastDtos.add(dailyForecastDto);    
            }
            response.forecast.dailyForecasts = dailyForecastDtos;

            return JSON.serialize(response);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }    
}

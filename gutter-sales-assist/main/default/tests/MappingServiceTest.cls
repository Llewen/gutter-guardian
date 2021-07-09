@isTest
private class MappingServiceTest {
    @isTest
    static void testShouldMapSalesScoreToDto() {
        Integer testScore = 10;

        MappingService mappingService = new MappingService();
        Test.startTest();
            SalesScoreAndForecastDto salesScoreDto = mappingService.getDto(null, testScore);
        Test.stopTest();

        System.assertEquals(testScore, salesScoreDto.salesScore, 'Did not map Sales Score to DTO.');
    }

    @isTest
    static void testShouldMapForecastToDto() {
        DailyWeatherForecast dailyForecast = new DailyWeatherForecast();
        dailyForecast.applicable_date = Date.today();
        dailyForecast.weather_state_abbr = 'r';

        WeatherForecast forecast = new WeatherForecast();
        forecast.consolidated_weather = new List<DailyWeatherForecast> {dailyForecast};

        MappingService mappingService = new MappingService();
        Test.startTest();
            SalesScoreAndForecastDto forecastDto = mappingService.getDto(forecast, 0);
        Test.stopTest();

        System.assert(forecastDto.forecast != null, 'Did not map forecast.');
        System.assert(forecastDto.forecast.dailyForecasts != null && forecastDto.forecast.dailyForecasts.size() == 1, 'Did not map daily forecasts.');
        System.assertEquals(dailyForecast.applicable_date, forecastDto.forecast.dailyForecasts[0].forecastDate, 'Did not map daily forecast applicable date.');
        System.assertEquals(dailyForecast.weather_state_abbr, forecastDto.forecast.dailyForecasts[0].weatherAbbreviation, 'Did not map daily forecast weather abbreviation.');
    }
}

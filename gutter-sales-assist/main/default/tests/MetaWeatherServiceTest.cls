@isTest
private class MetaWeatherServiceTest {
    @isTest
    static void testShouldReturnWeatherForecastWhenGivenAValidLocation() {
        String location = 'valid';

        MetaWeatherService service = new MetaWeatherService();

        Test.setMock(HttpCalloutMock.class, new MetaWeatherCalloutMock());
        Test.startTest();
            WeatherForecast forecast = service.getWeatherForecastForLocation(location);
        Test.stopTest();

        System.assert(forecast != null, 'Did not return weather forecast for valid location.');
        System.assert(forecast.dailyWeatherForecasts != null, 'Did not return daily forecasts for valid location.');
        System.assertEquals(3, forecast.dailyWeatherForecasts.size(), 'Incorrect amount of daily forecasts were returned for valid location.');
    }
}

@isTest
private class ForecastControllerTest {
    @isTest
    static void testShouldRetrieveWeatherForecastAndLeadScoringWhenGivenLocation() {
        String location = 'ValidLocation';

        DailyWeatherForecast dailyForecast = new DailyWeatherForecast();
        dailyForecast.applicable_date = Date.today();
        dailyForecast.weather_state_abbr = 'r';
        WeatherForecast forecast = new WeatherForecast();
        forecast.consolidated_weather = new List<DailyWeatherForecast> {
            dailyForecast
        };

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IForecastService mockForecastService = (IForecastService) mocks.mock(MetaWeatherService.class);
        ISalesScoringService mockSalesScoringService = (ISalesScoringService) mocks.mock(SalesScoringService.class);

        mocks.startStubbing();
            mocks.when(mockForecastService.getWeatherForecastForLocation(location)).thenreturn(forecast);
            mocks.when(mockSalesScoringService.getSalesScoreFromForecast(forecast)).thenreturn(100);
        mocks.stopStubbing();

        ForecastController.forecastService = mockForecastService;
        ForecastController.salesScoringService = mockSalesScoringService;
        Test.startTest();
            String jsonResult = ForecastController.getSalesScoreWithForecast(location);
        Test.stopTest();

        SalesScoreAndForecastDto scoreAndForecast = (SalesScoreAndForecastDto) JSON.deserialize(jsonResult, SalesScoreAndForecastDto.class);
        System.assert(scoreAndForecast.forecast != null, 'Did not return forecast for location.');
        System.assertEquals(forecast.consolidated_weather.size(), scoreAndForecast.forecast.dailyForecasts.size(), 'Did not return expected forecast.');
        System.assertEquals(100, scoreAndForecast.salesScore, 'Did not return sales score for location.');
    }

}
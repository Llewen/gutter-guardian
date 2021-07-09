@isTest
private class ForecastControllerTest {
    @isTest
    static void testShouldRetrieveWeatherForecastAndLeadScoringWhenGivenLocation() {
        String location = 'ValidLocation';
        Integer salesScore = 100;

        DailyWeatherForecast dailyForecast = new DailyWeatherForecast();
        dailyForecast.applicable_date = Date.today();
        dailyForecast.weather_state_abbr = 'r';
        WeatherForecast forecast = new WeatherForecast();
        forecast.consolidated_weather = new List<DailyWeatherForecast> {
            dailyForecast
        };

        DailyForecastDto dailyDto = new DailyForecastDto();
        dailyDto.forecastDate = dailyForecast.applicable_date;
        dailyDto.weatherAbbreviation = dailyForecast.weather_state_abbr;

        SalesScoreAndForecastDto dto = new SalesScoreAndForecastDto();
        dto.salesScore = salesScore;
        dto.forecast = new ForecastDto();
        dto.forecast.dailyForecasts = new List<DailyForecastDto> {
            dailyDto
        };

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        IForecastService mockForecastService = (IForecastService) mocks.mock(MetaWeatherService.class);
        ISalesScoringService mockSalesScoringService = (ISalesScoringService) mocks.mock(SalesScoringService.class);
        IMappingService mockMappingService = (IMappingService) mocks.mock(MappingService.class);

        mocks.startStubbing();
            mocks.when(mockForecastService.getWeatherForecastForLocation(location)).thenreturn(forecast);
            mocks.when(mockSalesScoringService.getSalesScoreFromForecast(forecast)).thenreturn(salesScore);
            mocks.when(mockMappingService.getDto(forecast, salesScore)).thenReturn(dto);
        mocks.stopStubbing();

        ForecastController.forecastService = mockForecastService;
        ForecastController.salesScoringService = mockSalesScoringService;
        ForecastController.mappingService = mockMappingService;
        Test.startTest();
            String jsonResult = ForecastController.getSalesScoreWithForecast(location);
        Test.stopTest();

        ((IForecastService) mocks.verify(mockForecastService, 1)).getWeatherForecastForLocation(location);
        ((ISalesScoringService) mocks.verify(mockSalesScoringService, 1)).getSalesScoreFromForecast(forecast);
        ((IMappingService) mocks.verify(mockMappingService, 1)).getDto(forecast, salesScore);
        SalesScoreAndForecastDto scoreAndForecast = (SalesScoreAndForecastDto) JSON.deserialize(jsonResult, SalesScoreAndForecastDto.class);
        System.assert(scoreAndForecast.forecast != null, 'Did not return forecast for location.');
        System.assertEquals(forecast.consolidated_weather.size(), scoreAndForecast.forecast.dailyForecasts.size(), 'Did not return expected forecast.');
        System.assertEquals(salesScore, scoreAndForecast.salesScore, 'Did not return sales score for location.');
    }

}
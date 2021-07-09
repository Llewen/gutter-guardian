@isTest
private class MetaWeatherServiceTest {
    @isTest
    static void testShouldReturnWeatherForecastWhenGivenAValidLocation() {
        String location = 'valid';

        fflib_ApexMocks mocks = new fflib_ApexMocks();
        ICalloutLogRepository mockCalloutLogRepo = (ICalloutLogRepository) mocks.mock(CalloutLogRepository.class);

        MetaWeatherService service = new MetaWeatherService();
        service.calloutLogRepository = mockCalloutLogRepo;

        Test.setMock(HttpCalloutMock.class, new MetaWeatherCalloutMock());
        Test.startTest();
            WeatherForecast forecast = service.getWeatherForecastForLocation(location);
        Test.stopTest();

        System.assert(forecast != null, 'Did not return weather forecast for valid location.');
        System.assert(forecast.consolidated_weather != null, 'Did not return daily forecasts for valid location.');
        System.assertEquals(6, forecast.consolidated_weather.size(), 'Incorrect amount of daily forecasts were returned for valid location.');
    }

    @isTest
    static void testShouldLogValidResponses() {
        String location = 'valid';

        MetaWeatherService service = new MetaWeatherService();

        Test.setMock(HttpCalloutMock.class, new MetaWeatherCalloutMock());
        Test.startTest();
            WeatherForecast forecast = service.getWeatherForecastForLocation(location);
        Test.stopTest();

        List<CalloutLog__c> testLogs = [SELECT Id FROM CalloutLog__c];
        System.assertEquals(2, testLogs.size(), 'Did not log all responses.');
    }

    @isTest
    static void testShouldLogFailedResponse() {
        String location = 'not found';

        MetaWeatherService service = new MetaWeatherService();

        Test.setMock(HttpCalloutMock.class, new MetaWeatherCalloutMock());
        Test.startTest();
            WeatherForecast forecast = service.getWeatherForecastForLocation(location);
        Test.stopTest();

        List<CalloutLog__c> testLogs = [SELECT Id, StatusCode__c FROM CalloutLog__c];
        System.assertEquals(1, testLogs.size(), 'Did not log response.');
        System.assertEquals('404', testLogs[0].StatusCode__c, 'Did not log failed response.');
    }
}

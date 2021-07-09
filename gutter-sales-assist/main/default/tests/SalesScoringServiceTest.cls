@isTest
private class SalesScoringServiceTest {
    @isTest
    static void testShouldReturn10PercentWhenNoPrecipitationIsPredicted() {
        DailyWeatherForecast testDailyForecast = new DailyWeatherForecast();
        testDailyForecast.applicable_date = Date.today().addDays(1);
        testDailyForecast.weather_state_abbr = 'c';

        WeatherForecast testForecast = new WeatherForecast();
        testForecast.consolidated_weather = new List<DailyWeatherForecast> {testDailyForecast};

        List<String> precipitousAbbreviations = new List<String> {'r'};
        SalesScoringService salesScoringService = new SalesScoringService(precipitousAbbreviations);
        Test.startTest();
            Integer salesScore = salesScoringService.getSalesScoreFromForecast(testForecast);
        Test.stopTest();

        System.assertEquals(10, salesScore, 'Did not return baseline of 10 percent when no precipitation predicted.');
    }
}

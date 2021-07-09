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

    @isTest
    static void testShouldReturnSalesScoreAsAPercentageOfPredictedPrecipitationWhenPassedAForecast() {
        List<DailyWeatherForecast> clearDays = new List<DailyWeatherForecast>();
        for (Integer x = 1; x < 6; x++) {
            DailyWeatherForecast dailyForecast = new DailyWeatherForecast();
            dailyForecast.applicable_date = Date.today().addDays(x);
            dailyForecast.weather_state_abbr = 'c';
            clearDays.add(dailyForecast);
        }

        List<DailyWeatherForecast> rainyDays = new List<DailyWeatherForecast>();
        for (Integer x = 6; x < 11; x++) {
            DailyWeatherForecast dailyForecast = new DailyWeatherForecast();
            dailyForecast.applicable_date = Date.today().addDays(x);
            dailyForecast.weather_state_abbr = 'r';
            rainyDays.add(dailyForecast);
        }

        WeatherForecast testForecast = new WeatherForecast();
        testForecast.consolidated_weather = new List<DailyWeatherForecast>();
        testForecast.consolidated_weather.addAll(clearDays);
        testForecast.consolidated_weather.addAll(rainyDays);

        List<String> precipitousAbbreviations = new List<String> {'r'};
        SalesScoringService salesScoringService = new SalesScoringService(precipitousAbbreviations);
        Test.startTest();
            Integer salesScore = salesScoringService.getSalesScoreFromForecast(testForecast);
        Test.stopTest();

        System.assertEquals(50, salesScore, 'Did not return Sales Score as percent of forecasted days with precipitation.');
    }
}

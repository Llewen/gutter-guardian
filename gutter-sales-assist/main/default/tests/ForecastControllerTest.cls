@isTest
private class ForecastControllerTest {
    @isTest
    static void testShouldRetrieveWeatherForecastAndLeadScoringWhenGivenLocation() {
        String location = 'New York, New York';

        Test.startTest();
            String jsonResult = ForecastController.getSalesScoreWithForecast(location);
        Test.stopTest();

        SalesScoreAndForecastDto scoreAndForecast = (SalesScoreAndForecastDto) JSON.deserializeUntyped(jsonResult);
        System.assert(scoreAndForecast.forecast != null, 'Did not return forecast for location.');
        System.assert(scoreAndForecast.salesScore != 0, 'Did not return sales score for location.');
    }

}
public with sharing class ForecastController {
    @TestVisible private static IForecastService forecastService = new MetaWeatherService();
    @TestVisible private static ISalesScoringService salesScoringService = new SalesScoringService();
    @TestVisible private static IMappingService mappingService = new MappingService();

    @AuraEnabled
    public static string getSalesScoreWithForecast(String location) {
        try {
            WeatherForecast forecast = forecastService.getWeatherForecastForLocation(location);
            Integer salesScore = salesScoringService.getSalesScoreFromForecast(forecast);
            SalesScoreAndForecastDto response = mappingService.getDto(forecast, salesScore);

            return JSON.serialize(response);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }    
}

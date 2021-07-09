public with sharing class ForecastController {
    @TestVisible private static IForecastService forecastService = new MetaWeatherService();

    @AuraEnabled
    public static string getSalesScoreWithForecast(String location) {
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }    
}

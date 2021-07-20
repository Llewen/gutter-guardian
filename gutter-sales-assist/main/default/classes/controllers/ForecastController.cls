public with sharing class ForecastController {
    @TestVisible private static IForecastService forecastService = new MetaWeatherService();
    @TestVisible private static ISalesScoringService salesScoringService = new SalesScoringService();
    @TestVisible private static IMappingService mappingService = new MappingService();
    private static ISearchLogRepository searchLogRepo = new SearchLogRepository();

    @AuraEnabled
    public static string getSalesScoreWithForecast(String location) {
        try {
            WeatherForecast forecast = forecastService.getWeatherForecastForLocation(location);
            Integer salesScore = salesScoringService.getSalesScoreFromForecast(forecast);
            SalesScoreAndForecastDto response = mappingService.getDto(forecast, salesScore);

            return JSON.serialize(response);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        } finally {
            searchLogRepo.logSearch(location);
        }
    } 
    
    @AuraEnabled(cacheable=true)
    public static List<SearchLog__c> getLastTenSearches(){
        try {
            return searchLogRepo.getLastTenSearchLogs();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

public with sharing class SearchLogRepository implements ISearchLogRepository{
    public void logSearch(String locationName) {
        SearchLog__c sLog = new SearchLog__c(
            LocationName__c = locationName
        );

        insert sLog;
    }

    public List<SearchLog__c> getLastTenSearchLogs() {
        List<SearchLog__c> logs = [
            SELECT Id, LocationName__c
            FROM SearchLog__c
            ORDER BY CreatedDate DESC
            LIMIT 10
        ];

        return logs;
    }
}

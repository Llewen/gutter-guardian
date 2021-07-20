public interface ISearchLogRepository {
    void logSearch(String locationName);
    List<SearchLog__c> getLastTenSearchLogs();
}

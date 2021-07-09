public with sharing class CalloutLogRepository implements ICalloutLogRepository {
    public void logResponse(HttpResponse response) {
        CalloutLog__c calloutLog = new CalloutLog__c(
            RequestDateTime__c = DateTime.now(),
            StatusCode__c = String.valueOf(response.getStatusCode()),
            ResponseBody__c = response.getBody()
        );

        insert calloutLog;
    }
}

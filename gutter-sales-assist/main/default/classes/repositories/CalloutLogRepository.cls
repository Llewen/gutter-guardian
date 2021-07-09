public with sharing class CalloutLogRepository implements ICalloutLogRepository {
    public void logResponse(HttpResponse response) {
        CalloutLog__c calloutLog = getCalloutLogFromResponse(response);

        insert calloutLog;
    }

    public void logResponses(List<HttpResponse> responses) {
        List<CalloutLog__c> calloutLogs = new List<CalloutLog__c>();
        for (HttpResponse response : responses) {
            calloutLogs.add(getCalloutLogFromResponse(response));
        }

        insert calloutLogs;
    }

    private CalloutLog__c getCalloutLogFromResponse(HttpResponse response) {
        CalloutLog__c calloutLog = new CalloutLog__c(
            RequestDateTime__c = DateTime.now(),
            StatusCode__c = String.valueOf(response.getStatusCode()),
            ResponseBody__c = response.getBody()
        );

        return calloutLog;
    }
}

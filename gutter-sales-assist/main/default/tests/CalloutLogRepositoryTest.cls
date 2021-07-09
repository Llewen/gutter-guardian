@isTest
private class CalloutLogRepositoryTest {
    @isTest
    static void testShouldInsertCalloutLogWhenGivenResponse() {
        Integer statusCode = 200;
        String responseBody = 'Testing';

        HttpResponse testResponse = new HttpResponse();
        testResponse.setStatusCode(statusCode);
        testResponse.setBody(responseBody);

        CalloutLogRepository calloutLogRepo = new CalloutLogRepository();
        Test.startTest();
            calloutLogRepo.logResponse(testResponse);
        Test.stopTest();

        CalloutLog__c testLog = [SELECT RequestDateTime__c, ResponseBody__c, StatusCode__c FROM CalloutLog__c LIMIT 1];
        System.assert(Date.today().isSameDay(testLog.RequestDateTime__c.date()), 'Did not log time of request.');
        System.assertEquals(String.valueOf(statusCode), testLog.StatusCode__c, 'Did not log status code.');
        System.assertEquals(responseBody, testLog.ResponseBody__c, 'Did not log response body.');
    }

    @isTest
    static void testShouldInsertCalloutLogsWhenGivenListOfResponses() {
        Integer statusCode = 200;
        String responseBody = 'Testing';

        HttpResponse testResponse = new HttpResponse();
        testResponse.setStatusCode(statusCode);
        testResponse.setBody(responseBody);

        HttpResponse testResponse2 = new HttpResponse();
        testResponse2.setStatusCode(statusCode);
        testResponse2.setBody(responseBody);

        CalloutLogRepository calloutLogRepo = new CalloutLogRepository();
        Test.startTest();
            calloutLogRepo.logResponses(new List<HttpResponse> {testResponse, testResponse2});
        Test.stopTest();

        List<CalloutLog__c> testLogs = [SELECT Id FROM CalloutLog__c];
        System.assertEquals(2, testLogs.size(), 'Did not log all responses.');
    }
}

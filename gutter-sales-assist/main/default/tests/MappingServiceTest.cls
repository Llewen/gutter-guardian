@isTest
private class MappingServiceTest {
    @isTest
    static void testShouldMapSalesScoreToDto() {
        Integer testScore = 10;

        MappingService mappingService = new MappingService();
        Test.startTest();
            SalesScoreAndForecastDto salesScoreDto = mappingService.getDto(null, testScore);
        Test.stopTest();

        System.assertEquals(testScore, salesScoreDto.salesScore, 'Did not map Sales Score to DTO.');
    }
}

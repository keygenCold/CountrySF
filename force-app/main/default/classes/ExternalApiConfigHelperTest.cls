@IsTest
private class ExternalApiConfigHelperTest {

    @IsTest
    static void testGetCountryApiKey_WhenQueryFails() {
        Test.startTest();
        ExternalApiConfigHelper.simulateError = true;
        String result = ExternalApiConfigHelper.getCountryApiKey();
        Test.stopTest();

        System.assertEquals(null, result, 'Should return null when the query throws an exception.');
    }

    @IsTest
static void testGetCountryApiKey_WhenConfigExists() {
    Test.startTest();
    ExternalApiConfigHelper.simulateError = false; 
    String result = ExternalApiConfigHelper.getCountryApiKey();
    Test.stopTest();


    System.assertNotEquals(null, result, 'Should return the API key when config is present');
}

}
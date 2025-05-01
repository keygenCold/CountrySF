@isTest
public class CountrySchedulerTest {

    @isTest
    static void testScheduler() {
        // Set mock callout
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Test.startTest();

        String cronExp = '0 0 0 15 5 ? 2025';
        String jobId = System.schedule('Test Country Scheduler Job', cronExp, new CountryScheduler());

        Test.stopTest();

        System.assertNotEquals(null, jobId);
    }
}
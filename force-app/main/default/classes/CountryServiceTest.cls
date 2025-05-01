@isTest
public class CountryServiceTest {

    @isTest
    static void testFetchCountries() {
        // Setup mock callout
        Test.setMock(HttpCalloutMock.class, new CountryServiceMock());

        insert new Country__c(
            Name = 'Portugal',
            Alpha2__c = 'PT',
            Alpha3__c = 'OLD',
            Capital__c = 'Old Capital',
            Region__c = 'Old Region',
            RegionalBlocs__c = 'Old Bloc'
        );

        Test.startTest();
        CountryService.fetchCountriesImpl('FAKE-KEY'); // ✅ Fixed
        Test.stopTest();

        List<Country__c> results = [
            SELECT Name, Alpha2__c, Alpha3__c, Capital__c, Region__c, RegionalBlocs__c 
            FROM Country__c 
            WHERE Alpha2__c IN ('PT', 'BR')
        ];

        System.assertEquals(2, results.size(), 'Two countries should exist');

        for (Country__c c : results) {
            if (c.Alpha2__c == 'PT') {
                System.assertEquals('Lisbon', c.Capital__c);
                System.assertEquals('EU', c.RegionalBlocs__c);
            } else if (c.Alpha2__c == 'BR') {
                System.assertEquals('Brasília', c.Capital__c);
            }
        }
    }

    @isTest
    static void testFetchCountries_CalloutFails() {
        Test.setMock(HttpCalloutMock.class, new CountryServiceMock_Failure());

        Test.startTest();
        CountryService.fetchCountriesImpl('FAKE-KEY'); // ✅ Simulates failed callout
        Test.stopTest();

        System.assert(true, 'Should not throw error when API fails');
    }

    @isTest
    static void testFetchCountries_NoAccessKey() {
        Test.startTest();
        CountryService.fetchCountriesImpl(''); // ✅ Simulates missing key
        Test.stopTest();

        System.assert(true, 'Should complete even if key is missing');
    }
    
}
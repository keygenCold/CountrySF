@isTest
public class LeadCountryTriggerTest {
    @isTest
    static void testLeadCountryTrigger() {
        Country__c country = new Country__c(
            Name = 'Spain',
            Alpha2__c = 'ES',
            Alpha3__c = 'ESP',
            Capital__c = 'Madrid',
            Region__c = 'Europe'
        );
        insert country;


        Lead testLead = new Lead(
            LastName = 'Test Lead',
            Company = 'Test Company',
            Country__c = 'Spain' 
        );
        insert testLead;

        Lead insertedLead = [SELECT Id, Alpha2__c, Alpha3__c, Capital__c, Region__c FROM Lead WHERE Id = :testLead.Id];

        System.assertEquals('ES', insertedLead.Alpha2__c, 'Alpha2 code should match');
        System.assertEquals('ESP', insertedLead.Alpha3__c, 'Alpha3 code should match');
        System.assertEquals('Madrid', insertedLead.Capital__c, 'Capital should match');
        System.assertEquals('Europe', insertedLead.Region__c, 'Region should match');
    }

    @isTest
    static void testLeadWithoutMatchingCountry() {
        Lead testLead = new Lead(
            LastName = 'Test Lead 2',
            Company = 'Test Company 2',
            Country__c = 'Unknown'
        );
        insert testLead;

        Lead insertedLead = [SELECT Id, Alpha2__c, Alpha3__c, Capital__c, Region__c FROM Lead WHERE Id = :testLead.Id];

        System.assertEquals(null, insertedLead.Alpha2__c, 'Alpha2 should not be filled');
        System.assertEquals(null, insertedLead.Alpha3__c, 'Alpha3 should not be filled');
        System.assertEquals(null, insertedLead.Capital__c, 'Capital should not be filled');
        System.assertEquals(null, insertedLead.Region__c, 'Region should not be filled');
    }
}
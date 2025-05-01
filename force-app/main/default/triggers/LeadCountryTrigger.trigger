trigger LeadCountryTrigger on Lead (before insert, before update) {
    Set<String> countryNames = new Set<String>();
    for (Lead l : Trigger.new) {
        if (l.Country__c != null) {
            countryNames.add(l.Country__c);
        }
    }

    Map<String, Country__c> countryMap = new Map<String, Country__c>();
    if (!countryNames.isEmpty()) {
        for (Country__c c : [
            SELECT Name, Alpha2__c, Alpha3__c, Capital__c, Region__c 
            FROM Country__c
            WHERE Name IN :countryNames
        ]) {
            countryMap.put(c.Name, c);
        }
    }

    for (Lead l : Trigger.new) {
        if (l.Country__c != null && countryMap.containsKey(l.Country__c)) {
            Country__c c = countryMap.get(l.Country__c);
            l.Alpha2__c = c.Alpha2__c;
            l.Alpha3__c = c.Alpha3__c;
            l.Region__c = c.Region__c;
            l.Capital__c = c.Capital__c;
        }
    }
}
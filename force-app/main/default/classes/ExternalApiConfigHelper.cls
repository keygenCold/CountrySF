public class ExternalApiConfigHelper {
    @TestVisible private static Boolean simulateError = false;

    public static String getCountryApiKey() {
        try {
            External_API_Config__mdt config = getConfig();
            return config.Country_Key__c;
        } catch (Exception e) {
            System.debug('Config not found: ' + e.getMessage());
            return null;
        }
    }

    @TestVisible
    private static External_API_Config__mdt getConfig() {
        if (simulateError) {
            // Simulate query failure
            throw new QueryException('Simulated failure');
        }

        return [
            SELECT Country_Key__c
            FROM External_API_Config__mdt
            WHERE DeveloperName = 'Country_API'
            LIMIT 1
        ];
    }
}
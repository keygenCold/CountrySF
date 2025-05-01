public with sharing class CountryService {

    public class RegionalBloc {
        public String acronym;
        public String name;
    }

    public class CountryData {
        public String name;
        public String alpha2Code;
        public String alpha3Code;
        public String capital;
        public String region;
        public List<RegionalBloc> regionalBlocs;
    }

    @future (callout=true)
    public static void fetchCountries() {
        String accessKey = ExternalApiConfigHelper.getCountryApiKey();
        fetchCountriesImpl(accessKey); 
    }

    public static void fetchCountriesImpl(String apiKey) {
        if (String.isBlank(apiKey)) {
            System.debug('Access key is missing');
            return;
        }

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.countrylayer.com/v2/all?access_key=' + apiKey);
        req.setMethod('GET');

        HttpResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            List<CountryData> countries = (List<CountryData>) JSON.deserialize(res.getBody(), List<CountryData>.class);

            Map<String, Country__c> existingCountriesMap = new Map<String, Country__c>();
            for (Country__c c : [SELECT Id, Alpha2__c FROM Country__c]) {
                existingCountriesMap.put(c.Alpha2__c, c);
            }

            List<Country__c> toInsert = new List<Country__c>();
            List<Country__c> toUpdate = new List<Country__c>();

            for (CountryData country : countries) {
                String blocAcronyms = '';
                if (country.regionalBlocs != null) {
                    List<String> acronyms = new List<String>();
                    for (RegionalBloc bloc : country.regionalBlocs) {
                        if (bloc.acronym != null) {
                            acronyms.add(bloc.acronym);
                        } else if (bloc.name != null) {
                            acronyms.add(bloc.name);
                        }
                    }
                    blocAcronyms = String.join(acronyms, ', ');
                }

                if (!existingCountriesMap.containsKey(country.alpha2Code)) {
                    toInsert.add(new Country__c(
                        Name = country.name,
                        Alpha2__c = country.alpha2Code,
                        Alpha3__c = country.alpha3Code,
                        Capital__c = country.capital,
                        Region__c = country.region,
                        RegionalBlocs__c = blocAcronyms
                    ));
                } else {
                    Country__c existing = existingCountriesMap.get(country.alpha2Code);
                    existing.Name = country.name;
                    existing.Alpha3__c = country.alpha3Code;
                    existing.Capital__c = country.capital;
                    existing.Region__c = country.region;
                    existing.RegionalBlocs__c = blocAcronyms;
                    toUpdate.add(existing);
                }
            }

            if (!toInsert.isEmpty()) {
                insert toInsert;
            }
            if (!toUpdate.isEmpty()) {
                update toUpdate;
            }

        } else {
            System.debug('Failed to fetch countries: ' + res.getStatus());
        }
    }
}
global class CountryScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        CountryService.fetchCountries();
    }
}
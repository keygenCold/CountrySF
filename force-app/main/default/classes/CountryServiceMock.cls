@isTest
global class CountryServiceMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody(
    '[{"name":"Portugal","alpha2Code":"PT","alpha3Code":"PRT","capital":"Lisbon","region":"Europe","regionalBlocs":[{"acronym":"EU","name":"European Union"}]},' +
     '{"name":"Brazil","alpha2Code":"BR","alpha3Code":"BRA","capital":"Brasília","region":"Americas","regionalBlocs":[{"acronym":"USAN","name":"Union of South American Nations"}]}]'
);

        return res;
    }
}
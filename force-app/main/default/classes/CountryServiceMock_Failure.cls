public class CountryServiceMock_Failure implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"error": "Invalid API key"}');
        res.setStatusCode(403);
        return res;
    }
}
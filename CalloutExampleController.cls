public class CalloutExampleController {

    public String accountName { get; set; }
    public Account acct { get; set; }

    public PageReference getAccount() {
        system.debug('=== accountName ' + accountName);
        getAccountAndContacts(accountName);
        return null;
    }

    // this uses a Site that is published from within the current developer org;
    // you must publish your own site and expose the relevant RESTful GET method
    // through it; the value of this variable will also have to be modified to match
    // the site name you chose for the site you published, as well as the instance.
    public static final String GRAMEEN_DEMO_REST_URL = 'https://grameen-session-developer-edition.na14.force.com/services/apexrest/Account/';

    // Pass in the endpoint to be used using the string url
    public void getAccountAndContacts(String accountName) {

        // Instantiate a new http object
        Http h = new Http();

        // Instantiate a new HTTP request, specify GET as well as the endpoint
        HttpRequest req = new HttpRequest();
        String encodedName = EncodingUtil.urlEncode(accountName, 'UTF-8');
        req.setEndpoint(GRAMEEN_DEMO_REST_URL +  encodedName);
        req.setMethod('GET');

        // Send the request, and return a response
        HttpResponse res = h.send(req);
        Integer statusCode = res.getStatusCode();

        String JSONString = res.getBody();

        if (statusCode != 200){
            ApexPages.addMessage( new ApexPages.message( ApexPages.severity.ERROR, res.getStatus()) );
        } else {
            ApexPages.addMessage( new ApexPages.message( ApexPages.severity.INFO, JSONString ) );
            // Deserialize the retrieved JSON -- just one statement!
            this.acct = (Account) JSON.deserialize(JSONString, Account.class);
        }
    }

}
@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {

    @HttpGet
    global static Account getAccountByName() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account[] result =
           [SELECT Id, Name, Phone, Website,
                (SELECT Name, Phone FROM Contacts)
            FROM Account
            WHERE Name = :EncodingUtil.urlDecode(accountName, 'UTF-8')
            LIMIT 1];

        if (result.isEmpty()){
            RestContext.response.statusCode = 404;
            return null;
        } else {
            return result[0];
        }
    }

    @HttpPost
    global static Id doPost(String name, String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}
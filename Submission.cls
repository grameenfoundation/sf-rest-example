@RestResource(urlMapping='/submission')
global class Submission {

    @HttpPost
    global static Id doPost() {

        // Get the body of this request into a string before processing.
        // This is possible because this method has no parameters.
        // If it had, Salesforce would attempt to parse the body into the given parameters.
        String xml = RestContext.request.requestBody.toString();

        // Perform complex processing of the data.
        Submission__c submission = processSubmission(xml);

        // Return Id of created record.
        return submission.Id;
    }

    private static Submission__c processSubmission(String xml){

        // This method contains the logic to create a new Submission record
        // based on the contents of the xml. Actual code is not presented here.
        //
        // For more information on parsing XML, refer to official documentation:
        // * http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_xml_dom.htm
        // * http://www.salesforce.com/us/developer/docs/apexcode/Content/apex_classes_xml_XmlStream_reader.htm

        return null;
    }
}
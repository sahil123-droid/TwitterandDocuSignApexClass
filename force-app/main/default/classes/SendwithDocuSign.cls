global class SendwithDocuSign {
    @InvocableMethod(label='Send With DocuSign for Signature' description='This class will execute envelope method to automate DocuSign Process')
    global static void executeSendMethod(List<InvocableParams> params){
        SendwithDocuSign.sendEnvelopeMethod(params[0].recordId,params[0].template);
    }
    global class InvocableParams{
        @InvocableVariable(required=true)
        global Id recordId;
        
        @InvocableVariable(required=true)
        global String template;
    }
    @future(callout=true)
    global static void sendEnvelopeMethod(Id sourceId,String tempId){
        try{
            Id mySourceId=sourceId; // The ID of the initiating Salesforce object
            String templateId=tempId; // The ID of the DocuSign template
            
            // Create an empty envelope
            dfsle.Envelope myEnvelope = dfsle.EnvelopeService.getEmptyEnvelope(
                new dfsle.Entity(mySourceId));
            // The initiating Salesforce entity
            
            // Use myEnvelope for later 
            // We will use a Salesforce contact record as a Recipient here
            OpportunityContactRole parentsourcerecord=[Select Id,ContactId,isPrimary from OpportunityContactRole where OpportunityId = :mySourceId and isPrimary=true LIMIT 1];
            Contact sourcerecord=[Select FirstName,LastName,Email from Contact where Id = :parentsourcerecord.ContactId];
            
            //use the Recipient.fromSource method to create the Recipient
            dfsle.Recipient myRecipient = dfsle.Recipient.fromSource(
                sourcerecord.FirstName+sourcerecord.LastName, // Recipient name
                sourcerecord.Email, // Recipient email
                null, // Optional phone number
                'Signer 1', // Role Name. Specify the exact role name from template
                new dfsle.Entity(sourcerecord.Id)); // Source object for the recipient
            
            // Add a recipient to the envelope
            myEnvelope = myEnvelope.withRecipients(new List<dfsle.Recipient> { myRecipient });
            
            // myTemplateId contains the DocuSign Id of the DocuSign Template
            dfsle.UUID myTemplateId = dfsle.UUID.parse(templateId);
            
            // create a new document for the Envelope
            dfsle.Document myDocument = dfsle.Document.fromTemplate(
                myTemplateId, // Template Id in dfsle.UUID format
                'myTemplate'); // Name of the template
            
            //add document to the envelope
            myEnvelope = myEnvelope.withDocuments(new List<dfsle.Document> { myDocument });
            
            // Send the envelope
            myEnvelope = dfsle.EnvelopeService.sendEnvelope(
                myEnvelope, // The envelope to send
                true); // True to send the envelope now
            
        }
        catch(Exception e){
            System.debug(e.getMessage());
        }
    }
}
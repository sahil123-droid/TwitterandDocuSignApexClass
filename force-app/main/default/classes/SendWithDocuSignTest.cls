@IsTest
private class SendWithDocuSignTest {
    @IsTest
    static void testSendEnvelope() {
        // Mock the DocuSign eSignature API
        dfsle.TestUtils.setMock(new dfsle.ESignatureAPIMock());
        
        // Run the test as a DocuSign Sender. This is required by dfsle.EnvelopeService.sendEnvelope
        System.runAs(dfsle.UserMock.createDocuSignSender()) {
            
            // Create test data
            
            Account account = new Account(Name='Test Account');
            INSERT account;
            
            //your record type Id
            Contact contact = new Contact(LastName='Test Contact',Email='manglani.sahil.sm@gmail.com',RecordTypeId='0123z000000VrJYAA0');
            INSERT contact;
            
            
            Opportunity testOpportunity = new Opportunity();
            testOpportunity.Name='Test Opportunity';
            testOpportunity.AccountId=account.Id;
            testOpportunity.CloseDate=System.today();
            testOpportunity.StageName='Demo';
            INSERT testOpportunity;
            
            
            OpportunityContactRole testOpportunityContactRole = new OpportunityContactRole();
            testOpportunityContactRole.ContactId=contact.Id;
            testOpportunityContactRole.OpportunityId=testOpportunity.Id;
            testOpportunityContactRole.IsPrimary=true;
            INSERT testOpportunityContactRole;
            
            
            testOpportunity.StageName='Contract Sent';
            // when stage is updated it will call process builder
            UPDATE testOpportunity;
            
            // docusign config steps to send emails when stage updated with mock reponse because process builder will call the docusign method but there is no web serive callout available for it
            // Create a test envelope with one document and one recipient
            dfsle.Envelope myEnvelope = dfsle.EnvelopeService.getEmptyEnvelope(new dfsle.Entity(testOpportunity.Id))
                .withDocuments(new List<dfsle.Document> { 
                    dfsle.Document.fromTemplate(
                        dfsle.UUID.randomUUID(),
                        'test template')
                        })
                .withRecipients(new List<dfsle.Recipient> {
                    dfsle.Recipient.fromSource(
                        contact.FirstName + ' ' + contact.LastName,
                        contact.Email,
                        contact.Phone,
                        'Signer 1',
                        new dfsle.Entity(contact.Id))
                        });
            // Perform the test
            Test.startTest();
            dfsle.Envelope myResult = dfsle.EnvelopeService.sendEnvelope(myEnvelope, true);
            Test.stopTest();
            
            // Verify the results
            System.assertNotEquals(null, myResult);
            System.assertEquals(true, testOpportunity.StageName == 'Contract Sent');
        }
    }
}
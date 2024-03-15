public with sharing class ContactController {
    @AuraEnabled
    public static List<Contact> getRelatedContactList(String accountId) {
        return [ SELECT Name, Title, Email FROM Contact WHERE AccountId = :accountId WITH SECURITY_ENFORCED ];
    }
}
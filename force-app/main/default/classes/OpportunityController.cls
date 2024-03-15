public with sharing class OpportunityController {
    @AuraEnabled
    public static Opportunity getRelatedOpportunity( String accountId ) {
        return [ SELECT Id, Name, Amount, CloseDate, StageName FROM Opportunity WHERE AccountId = :accountId WITH SECURITY_ENFORCED LIMIT 1 ];
    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getRelatedOpportunityList( String accountId ) {
        return [ SELECT Id, Name, Amount, CloseDate, StageName FROM Opportunity WHERE AccountId = :accountId WITH SECURITY_ENFORCED ];
    }
}
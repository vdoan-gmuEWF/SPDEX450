public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getTopFiveAccounts() {
        return [ SELECT Id, Name, Phone, AnnualRevenue FROM Account WITH SECURITY_ENFORCED ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5 ];
    }
}
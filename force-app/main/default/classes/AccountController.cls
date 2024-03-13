public with sharing class AccountController {
    @AuraEnabled
    public static List<Account> getTopFiveAccounts() {
        return [ SELECT Id, Name, Phone, AnnualRevenue FROM Account WITH SECURITY_ENFORCED LIMIT 5  ];
    }
}
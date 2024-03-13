/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountControllerTest {

    @TestSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>();
        for(Integer i = 0; i < 10; i++) {
            testAccounts.add(new Account(
                Name = 'Test Account ' + i,
                Phone = '123-456-789' + i,
                AnnualRevenue = 10000 * i
            ));
        }
        insert testAccounts;
    }

    @isTest
    static void testGetTopFiveAccounts() {
        // Call the method to be tested
        List<Account> topFiveAccounts = AccountController.getTopFiveAccounts();

        System.assertEquals(5, topFiveAccounts.size(), 'Expected to get top 5 accounts');
    }
}  
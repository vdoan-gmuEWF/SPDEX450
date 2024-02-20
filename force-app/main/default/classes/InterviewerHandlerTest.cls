/*
As a recruiter, when I attach an interviewer to a specific position, I need review records to be generated for each applicant in the interviewing stage so that the designated interviewer can see who they need to meet with. 
As a recruiter, when I advance an applicant to the 'Interviewing' stage, I need review records to be generated for each interviewer who needs to meet with that applicant.
*/
@isTest
private class InterviewerHandlerTest {

    @isTest
    private static void testSingleInterviewerInsertPositive() {

        RecruitingDataFactory.createSimpleScenario( 'Single' );

        Application__c oCurrentApplication  = [ SELECT Id, Position__c, Status__c FROM Application__c LIMIT 1 ];
        oCurrentApplication.Status__c       = 'Interviewing';
            update oCurrentApplication;

        User oNewInterviewerUser            = [ SELECT Id FROM User WHERE Profile.Name = 'GenWatt Recruiting' LIMIT 1 ];
        
        Test.startTest();
        Interviewer__c oNewInterviewer      = RecruitingDataFactory.createInterviewer( oCurrentApplication.Position__c, oNewInterviewerUser.Id );
            insert oNewInterviewer;
        Test.stopTest();

        List<Review__c> lNewReviews         = [ SELECT Id, Application__c, Interviewer__c FROM Review__c ];

        System.assertEquals( 1, lNewReviews.size(), 'Incorrect number of review records created' );
        for ( Review__c r : lNewReviews ) {
            System.assertEquals( oCurrentApplication.Id, r.Application__c, 'Review record is created but is not linked to Application' );           
            System.assertEquals( oNewInterviewer.Id, r.Interviewer__c, 'Review record is created but is not linked to Application' );           
        }

    }

    @isTest
    private static void testSingleInterviewerInsertNegative() {

        RecruitingDataFactory.createSimpleScenario( 'Single' );

        Application__c oCurrentApplication  = [ SELECT Id, Position__c, Status__c FROM Application__c LIMIT 1 ];
        oCurrentApplication.Status__c       = 'Interviewing';
        User oNewInterviewerUser            = [ SELECT Id FROM User WHERE Profile.Name = 'GenWatt Recruiting' LIMIT 1 ];
        
        Test.startTest();
        Interviewer__c oNewInterviewer      = RecruitingDataFactory.createInterviewer( oCurrentApplication.Position__c, oNewInterviewerUser.Id );
            insert oNewInterviewer;
        Test.stopTest();

        List<Review__c> lNewReviews         = [ SELECT Id, Application__c, Interviewer__c FROM Review__c ];
        System.assertEquals( 0, lNewReviews.size(), 'Incorrect number of review records created' );

    }

    @isTest
    private static void testBulkInterviewerInsertPositive() {

        List<Position__c> lNewPositions         = RecruitingDataFactory.createPositions( 'Open', 1 );
            insert lNewPositions;

        List<Application__c> lNewApplications   = RecruitingDataFactory.createApplications( 201, lNewPositions );
            insert lNewApplications;
            for ( Application__c a : lNewApplications ) { a.Status__c = 'Interviewing'; }
            update lNewApplications;
        System.Debug( 'Print lNewApplications in Test class');
        System.Debug( lNewApplications );


        User oNewInterviewerUser            = [ SELECT Id FROM User WHERE Profile.Name = 'GenWatt Recruiting' LIMIT 1 ];
        
        Test.startTest();
        Interviewer__c oNewInterviewer      = RecruitingDataFactory.createInterviewer( lNewPositions[0].Id, oNewInterviewerUser.Id );
            insert oNewInterviewer;
        Test.stopTest();

        List<Review__c> lNewReviews         = [ SELECT Id, Application__c, Interviewer__c FROM Review__c ];

        System.assertEquals( 201, lNewReviews.size(), 'Incorrect number of review records created' );
        Set<Id> lApplicationIds = new Set<Id>();
        for ( Review__c r : lNewReviews ) {
            lApplicationIds.add( r.Application__c );
            System.assertEquals( oNewInterviewer.Id, r.Interviewer__c, 'Review record is created but is not linked to Application' );           
        }
        System.assertEquals( 201, lApplicationIds.size(), 'Incomplete linking of review records to applications' );

    }
}
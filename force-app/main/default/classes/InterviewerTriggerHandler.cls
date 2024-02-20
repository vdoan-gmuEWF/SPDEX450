public with sharing class InterviewerTriggerHandler {

    public static void createReviewRecordOnInterviewerInsert( List<Interviewer__c> triggernew ) {
        
        Set<Id> lPositionIds = new Set<Id>();
        for ( Interviewer__c interviewer : triggernew ) { lPositionIds.add( interviewer.Position__c ); }

        List<Application__c> lInterviewerApplications = new List<Application__c>();
        for ( Position__c p : [ SELECT Id, ( SELECT Id, Status__c, Position__c FROM Applications__r ) FROM Position__c WHERE Id IN :lPositionIds ] ) {
            for ( Application__c a : p.Applications__r ) {
                if ( a.Status__c == 'Interviewing' ) { lInterviewerApplications.add( a ) ; }
            }
        }

        List<Review__c> lNewReviews = new List<Review__c>();
        for ( Interviewer__c interviewerCheck : triggernew ) {
            for ( Application__c a : lInterviewerApplications ) { 
                if ( a.Position__c == interviewerCheck.Position__c ) {
                    Review__c oReview = new Review__c();
                        oReview.Interviewer__c = interviewerCheck.Id;
                        oReview.Application__c = a.Id;
                    lNewReviews.add( oReview );
                }
            }
        }

        insert lNewReviews;
    }

}
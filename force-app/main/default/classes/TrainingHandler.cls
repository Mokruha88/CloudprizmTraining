public with sharing class TrainingHandler {

    private static final String TRAINING_STATUS_COMPLETED = 'Completed';
    private static final String PARTICIPANT_STATUS_COMPLETED = 'Participated';

    // If the training is marked as “Completed” all participants must be marked as “Participated”
    public static void markParticipantsAsParticipated(List<Training__c> trainings) {
        Set<Id> trainingsIds = (new Map<Id, SObject> (trainings)).keySet();
        List <Training__c> relevant = queryTrainingsById(trainingsIds);// call here a method "queryTrainingsById" and pass the set of trainingsIds

        List<Participant__c> participants = new List<Participant__c>(); // declare a new empty list that has the type "Participant"

        // loop through all the trainigs
        for(Training__c t:relevant ) {
			System.debug('t = ' + t);
            // create an inner loop to loop throug all perticipants that are related to each aprticulat training
            for(Participant__c p:t.Participants__r) {
                p.Status__c = PARTICIPANT_STATUS_COMPLETED;
                participants.add(p);
                System.debug('p = ' + p);
                // Assign the status "participated" to each of participant (use PARTICIPANT_STATUS_COMPLETED constant for it)
                // add a participant to the "partipants" list
            }
        }

        update participants; // write a DML statement to update the "participants" list
    }

    private static List<Training__c> queryTrainingsById(Set<Id> trainingsIds) {
        List<Training__c> trainings = new List<Training__c>();
        trainings = [
            SELECT Id, Name,(SELECT Id, Name, Status__c FROM Participants__r) 
            FROM Training__c
            WHERE Id IN:trainingsIds
        ];
        return trainings;
        // Query a list of trainigs with related participats
        // Query trainigs by the ids that are in trainingsIds
        
    }
        
   
    
}
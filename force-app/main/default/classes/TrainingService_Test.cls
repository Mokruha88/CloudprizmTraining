@IsTest
public with sharing class TrainingService_Test {
    @TestSetup
    static void makeData() {

        List<Training__c> trainings = new List<Training__c>(); 
        List<Participant__c> participants = new List<Participant__c>(); 

        // call createTrainingCourse method
        // insert traing course     

        Training_Course__c course  = new Training_Course__c();
        insert course;

        for (Integer i = 0; i < 5; i++ ) {  
            String name = 'Andrew';   
            Date startDate = Date.today();
            Date endDate = Date.today();
            endDate.addDays(10);
            String status = 'Active';       
            Id courseId = course.Id;

            Training__c training =  TrainingFactory.createTraining(name, startDate, endDate, status, courseId);  
            training.Max_participants_quantity__c = 100;  
            trainings.add(training); 
        }   

        insert trainings;
        for (Training__c tr : trainings) {
            Participant__c participant1 = new Participant__c();
            participant1.Training__c = tr.Id;
            participants.add(participant1);
            

        }
        insert participants;
    }
    @IsTest
    private static void filterTrainingsByStatusPositive() {
        List<Training__c> filterStatus = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Status__c 
                                            FROM Training__c ];
        String status ='Active';
        


        Test.startTest();
            filterStatus = TrainingService.filterTrainingsByStatus(trainingsList, status) ;
        Test.stopTest();

        System.assertEquals(trainingsList.size(), filterStatus.size());
    }
    @IsTest
    private static void filterTrainingsByStatusNegative() {
        List<Training__c> filterStatus = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Status__c 
                                            FROM Training__c ];
        String status ='Draft';
        
        

        Test.startTest();
            filterStatus = TrainingService.filterTrainingsByStatus(trainingsList, status) ;
        Test.stopTest();

        System.assertEquals(0, filterStatus.size());
//-----------------------------------------------------------------------------------------------------------------------------------------------------\\      
    }
    @IsTest
    private static void filterTrainingsByStartDatePositive() {
        List<Training__c> filterStartDate = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Start_Date__c
                                            FROM Training__c ];
        Date startDate = Date.today();
        
        

        Test.startTest();
            filterStartDate = TrainingService.filterTrainingsByStartDate(trainingsList, startDate) ;
        Test.stopTest();

        System.assertEquals(trainingsList.size(), filterStartDate.size());
    }
    
    @IsTest
    private static void filterTrainingsByStartDateNegative() {
        List<Training__c> filterStartDate = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Start_Date__c
                                            FROM Training__c ];
        Date startDate = Date.today().addDays(2);

        

        Test.startTest();
            filterStartDate = TrainingService.filterTrainingsByStartDate(trainingsList, startDate) ;
        Test.stopTest();

        System.assertEquals(0,filterStartDate.size());
    }
    
    @IsTest
    private static void filterTrainingsByEndDatePositive() {
        List<Training__c> filterEndDate = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, End_Date__c
                                            FROM Training__c ];
        Date endDate = Date.today();
        
        

        Test.startTest();
            filterEndDate = TrainingService.filterTrainingsByEndDate(trainingsList, endDate) ;
        Test.stopTest();

        System.assertEquals(trainingsList.size(), filterEndDate.size());
    }
    @IsTest
    private static void filterTrainingsByEndDateNegative() {
        List<Training__c> filterEndDate = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, End_Date__c
                                            FROM Training__c ];
        Date endDate = Date.today().addDays(2);

        

        Test.startTest();
            filterEndDate = TrainingService.filterTrainingsByEndDate(trainingsList, endDate) ;
        Test.stopTest();

        System.assertEquals(0,filterEndDate.size());
    }

//-----------------------------------------------------------------------------------------------------------------------------------------------------\\
    @IsTest
    private static void filterFreeTrainingsTest() {
        List<Training__c> freeTrainings = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Free_Places__c
                                        FROM Training__c ];
        Test.startTest();
            freeTrainings = TrainingService.filterFreeTrainings(trainingsList);   
        Test.stopTest();

        System.assertEquals(trainingsList.size(), freeTrainings.size());
    }
    @IsTest
    private static void filterEmptyTrainingsTest() {
        List<Training__c> emptyTrainings = new List<Training__c>();
        List<Training__c> trainingsList = [ SELECT Id, Involved_Participants__c
                                            FROM Training__c ];   
        Test.startTest();
            emptyTrainings = TrainingService.filterEmptyTrainings(trainingsList);   
        Test.stopTest();

        System.assertEquals(0 , emptyTrainings.size());
    }  


    /**

    public static List<Training__c> filterByStatusChange(
        List<Training__c> trainings, 
        Map<Id, Training__c> oldMap, 
        String oldStatus, 
        String newStatus
        ){
        List<Training__c> filterStatusChange = new List<Training__c>();
        
        for (Training__c training:trainings){
            if (training.Status__c == newStatus && oldMap.get(training.Id).Status__c == oldStatus){
                filterStatusChange.add(training);
            }
        }

        return filterStatusChange;
    }
 
     */
    @IsTest
    private static void filterByStatusChange() {
        Map<Id, Training__c> oldMap = new Map<Id, Training__c>();

        // declare 2 string varibales with status values
        String statusActive = 'Active';
        String statusCanceled = 'Cancelled';

        // query 2 training 
        List<Training__c> testTrainings =  [
            SELECT Id, Status__c
            FROM Training__c
            LIMIT 2
        ];

        Training__c training1 = testTrainings.get(0);
        Training__c training2 = testTrainings.get(1);

        training2.Status__c = statusCanceled;
        update testTrainings;

        oldMap.put(training1.Id, training2);

        // Map: training1.Id -> training2
        // List: training1

        List<Training__c> activeTrainigs = new List<Training__c> {training1};

        Test.startTest();
        TrainingService.filterByStatusChange(activeTrainigs, oldMap, statusCanceled, statusActive);
        Test.stopTest();
    }

}
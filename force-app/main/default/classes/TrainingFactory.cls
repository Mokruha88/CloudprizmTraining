public class TrainingFactory {
    public static Training_Course__c createTrainingCourse() {
        Training_Course__c trainingCourse = new Training_Course__c();
        	return trainingCourse;
    }  
    public static Training_Course__c createTrainingCourse(String name, String description) {
        Training_Course__c trainingCourse = new Training_Course__c();
        trainingCourse.Name = name;
        trainingCourse.Description__c = description;
        	return trainingCourse;
    }             
    
    public static Training__c createTraining(){
        Training__c trainingCourse = new Training__c();
        return trainingCourse;
        
    }
    public static Training__c createTraining (String name, Date startDate, Date endDate, String status, String trainingCourse) {
        Training__c training = new Training__c();
        training.Name = name;
        training.Start_Date__c = startDate;
        training.End_Date__c = endDate;   
        training.Status__c = status;
        training.Training_Course__c	= trainingCourse;
        return training;
    
    }
    public static Contact createContact (String lastName ){
        Contact contact = new Contact();
        contact.LastName = lastName;
        return contact;
    }
    public static Account createAccount (String name ){
        Account account = new Account();
        account.Name = name;
        return account;
    }
 	
    public static void insertTrainingRecords ( Account account, Contact contact, Training_Course__c trainingCourse, Training__c training){
     insert account;
     insert contact;
     insert trainingCourse; // немає ID, треба створити
     training.Training_Course__c = trainingCourse.Id;
     insert training;
    
    //------------------------------------------------------------------------------------------------------------------------------\\
    }
    public static Participant__c createParticipant (String status, String training ){
        Participant__c participant = new Participant__c();
        participant.Status__c = status;
        participant.Training__c = training;
        return participant; 
    }
    public static List<Participant__c> createParticipantList(Set<Id> trainingsIds){
    List<Participant__c> trainings = new List<Participant__c>();
        trainings = [
            SELECT Id, Name, Status__c
            FROM Participant__c
            WHERE Id IN:trainingsIds
            ];
            return trainings;
    }
}
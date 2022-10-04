public with sharing class TrainingService {
    
    public static List<Training__c> filterTrainingsByStatus(List<Training__c> trainings, String status){
        List<Training__c> filterStatus = new List<Training__c>();
        
        for (Training__c training:trainings){
            if (training.Status__c == status){
                filterStatus.add(training);
            }
        }

        return filterStatus;
    }    
    
    public static List<Training__c> filterByStatusChange(List<Training__c> trainings, Map<Id, Training__c> oldMap, String oldStatus, String newStatus){
        List<Training__c> filterStatusChange = new List<Training__c>();
        
        for (Training__c training:trainings){
            if (training.Status__c == newStatus && oldMap.get(training.Id).Status__c == oldStatus){
                System.debug('Success!');
                filterStatusChange.add(training);
            }
        }

        return filterStatusChange;
    }
 
   //--------------------------------------------------------------------------------------------------\\

    public static List<Training__c> filterTrainingsByStartDate ( List<Training__c> trainings, Date startDate){
        List<Training__c> filterStartDate = new List<Training__c>(); 
        
        for (Training__c training:trainings){
            if (training.Start_Date__c == startDate){
                filterStartdate.add(training);
            }
        }

        return filterStartDate;
    }
    public static List<Training__c> filterTrainingsByEndDate ( List<Training__c> trainings, Date endDate){
        List<Training__c> filterEnddate = new List<Training__c>(); 
        
        for (Training__c training:trainings){
            if (training.End_Date__c == endDate){
                filterEnddate.add(training);
            }
        }

        return filterEndDate;
    }
//-------------------------------------------------------------------------------------------\\

    public static List<Training__c> filterEmptyTrainings (List<Training__c> trainings ){
        List<Training__c> trainingsEmpty = new List<Training__c>(); 
        
        for (Training__c training:trainings){
            if (training.Involved_Participants__c == 0){
                trainingsEmpty.add(training);
            }
        }
        return trainingsEmpty;
    }

    public static List<Training__c> filterFreeTrainings (List<Training__c> trainings ){
        List<Training__c> trainingsFree = new List<Training__c>(); 
        
        for (Training__c training:trainings){
            if (training.Free_Places__c != 0){
                trainingsFree.add(training);
            }
        }
        return trainingsFree;
    }
}
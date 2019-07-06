//
//  QuestionViewModelDataHandler.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation
import CoreData
protocol QuestionViewModelDataHandlerDelegate {
    
    init(_ dataManager: CoreDataManager?)
    func getDataFromCoreData(_ subjectId: String) -> [Questions]?
    func upDateData(questionId: String)
}
class QuestionViewModelDataHandler: QuestionViewModelDataHandlerDelegate {
    
    var dataManager: CoreDataManager?
    required init(_ coreDataManager: CoreDataManager?) {
        self.dataManager = coreDataManager
    }
    func getDataFromCoreData(_ subjectId: String) -> [Questions]? {
        
        let fetchRequest: NSFetchRequest<Subjects> = Subjects.fetchRequest()
        let predicate = NSPredicate(format: "subjectId == %d", Int(subjectId)!)
        fetchRequest.predicate = predicate
        let subjects = try? dataManager?.getManagedObjectContext().fetch(fetchRequest)
        guard let unWrappedSubjects = subjects, unWrappedSubjects.count > 0 else { return nil}
        let questionArray = unWrappedSubjects[0].questions?.getArray() as? [Questions]
        guard let unWrappedQuestionsArray = questionArray else { return nil}
        return unWrappedQuestionsArray
    }
    func upDateData(questionId: String) {
        
        let fetchRequest: NSFetchRequest<Questions> = Questions.fetchRequest()
        let predicate = NSPredicate(format: "questionId == %@", questionId)
        fetchRequest.predicate = predicate
        do {
            let results = try dataManager?.getManagedObjectContext().fetch(fetchRequest)
            guard let unWrappedResults = results else { return }
                if unWrappedResults.count > 0 {
                    let question = unWrappedResults[0]
                    question.isAlreadyAnswered = true
                    try dataManager?.getManagedObjectContext().save()
                }
        }
        catch {
            print("\(error), \(error.localizedDescription)")
        }
    }

}

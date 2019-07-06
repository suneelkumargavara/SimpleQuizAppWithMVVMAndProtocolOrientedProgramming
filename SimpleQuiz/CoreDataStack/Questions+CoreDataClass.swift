//
//  Questions+CoreDataClass.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Questions)
public class Questions: NSManagedObject {

    class func loadQuestionIntoCoreData(_ value: [String: Any], _ dataManager: CoreDataManager?) -> Questions? {
        
        let context = dataManager?.getManagedObjectContext()
        guard let unWrappedContext = context else { return nil}
        let questionModel = NSEntityDescription.insertNewObject(forEntityName: CoreDataConstants.Questions, into: unWrappedContext) as? Questions
        questionModel?.question = value[keys.Question] as? String ?? ""
        questionModel?.questionId = value[keys.QuestionId] as? Int32 ?? 0
        let answers = value[keys.Answers] as? [[String: Any]] ?? []
        for (_, value) in answers.enumerated() {
            let answerModel = Answers.loadAnswerIntoCoreData(value, dataManager)
            guard let unWrappedModel = answerModel else { continue }
            questionModel?.addToAnswers(unWrappedModel)
        }
        return questionModel
    }
    
}

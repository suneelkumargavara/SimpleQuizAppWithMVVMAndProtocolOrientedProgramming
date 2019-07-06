//
//  Subjects+CoreDataClass.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Subjects)
public class Subjects: NSManagedObject {

    class func addSubjectToCoreData(_ value: [String: Any], _ dataManager: CoreDataManager?) {
        let context = dataManager?.getManagedObjectContext()
        guard let unWrappedContext = context else { return }
        let subjectModel = NSEntityDescription.insertNewObject(forEntityName: CoreDataConstants.Subjects, into: unWrappedContext) as? Subjects
        subjectModel?.subject = value[keys.SubjectName] as? String ?? ""
        subjectModel?.subjectId = value[keys.SubjectId] as? Int32 ?? 0
        let questions = value[keys.Questions] as? [[String: Any]] ?? []
        for (_, value) in questions.enumerated() {
            let questionModel = Questions.loadQuestionIntoCoreData(value, dataManager)
            guard let unWrappedModel = questionModel else { continue }
            subjectModel?.addToQuestions(unWrappedModel)
        }
    }

}

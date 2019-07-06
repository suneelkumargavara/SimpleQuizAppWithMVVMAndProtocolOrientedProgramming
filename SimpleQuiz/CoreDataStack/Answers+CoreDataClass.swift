//
//  Answers+CoreDataClass.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Answers)
public class Answers: NSManagedObject {

    class func loadAnswerIntoCoreData(_ value: [String: Any], _ dataManger: CoreDataManager?) -> Answers? {
        let context = dataManger?.getManagedObjectContext()
        guard let unWrappedContext = context else { return nil}
        let entity = NSEntityDescription.insertNewObject(forEntityName: CoreDataConstants.Answers, into: unWrappedContext) as? Answers
        entity?.answer = value[keys.Answer] as? String ?? ""
        entity?.answerId = value[keys.AnswerId] as? Int32 ?? 0
        entity?.isCorrect = value[keys.isCorrect] as? Bool ?? false
        return entity
    }
    

}

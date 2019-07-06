//
//  Questions+CoreDataProperties.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//
//

import Foundation
import CoreData


extension Questions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Questions> {
        return NSFetchRequest<Questions>(entityName: "Questions")
    }

    @NSManaged public var isAlreadyAnswered: Bool
    @NSManaged public var question: String?
    @NSManaged public var questionId: Int32
    @NSManaged public var answers: NSSet?
    @NSManaged public var questions: Subjects?

}

// MARK: Generated accessors for answers
extension Questions {

    @objc(addAnswersObject:)
    @NSManaged public func addToAnswers(_ value: Answers)

    @objc(removeAnswersObject:)
    @NSManaged public func removeFromAnswers(_ value: Answers)

    @objc(addAnswers:)
    @NSManaged public func addToAnswers(_ values: NSSet)

    @objc(removeAnswers:)
    @NSManaged public func removeFromAnswers(_ values: NSSet)

}

//
//  Answers+CoreDataProperties.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    @NSManaged public var answer: String?
    @NSManaged public var answerId: Int32
    @NSManaged public var isCorrect: Bool
    @NSManaged public var answers: Questions?

}

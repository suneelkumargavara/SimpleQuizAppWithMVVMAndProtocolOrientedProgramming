//
//  Constants.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

struct CoreDataConstants {
    static let SimpleQuiz = "SimpleQuiz"
    static let Subjects = "Subjects"
    static let Questions = "Questions"
    static let Answers   = "Answers"
}
struct CoreDataErrors {
    static let UnableToFindModel = "Unable to Find Data Model"
    static let UnableToLoadData  = "Unable to Load Data Model"
    static let UnableToAddPersistantCoordinator = "Unable to Add Persistent Store"
}
struct ViewErrors {
    static let UnableToLoadNib = "Unable To Load Nib"
}
struct CellIdentifiers {
    static let HomeCellIdentifier = "HomeCellIdentifier"
}
struct NibNames {
    static let HomeView = "HomeView"
    static let CellPlayerModeAndSubjectInfo = "CellPlayerModeAndSubjectInfo"
}
 struct ImageNames {
    static let PlaceHolder = "placeHolder"
}
 struct keys {
    static let SubjectName = "SubjectName"
    static let SubjectId   = "SubjectId"
    static let SubjectRating = "SubjectRating"
    static let Questions = "Questions"
    static let Question = "Question"
    static let QuestionId = "QuestionId"
    static let Answers = "Answers"
    static let Answer = "Answer"
    static let AnswerId = "AnswerId"
    static let isCorrect = "isCorrect"
}
 struct Alerts {
    static let alert = "Alert!"
    static let noMoreData = "No More Questions!"
    static let Ok = "OK"
}
 struct StoryBoardNames {
    static let Main = "Main"
}
struct ViewControllerIdentifiers {
    static let QuestionViewController = "QuestionViewController"
}
struct Colors {
    static var colorTheme = UIColor(red: 17/255.0, green: 130/255.0, blue: 227/255.0, alpha: 1.0)
}

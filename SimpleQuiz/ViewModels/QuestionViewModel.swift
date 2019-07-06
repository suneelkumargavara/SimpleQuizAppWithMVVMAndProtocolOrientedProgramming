//
//  QuestionViewModel.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation
import CoreData

final class QuestionViewModel {
    
    private let questionViewDataHandler: QuestionViewModelDataHandlerDelegate
    private let coreDataManager: CoreDataManager?
    var dataFetched: (() -> ())?

    private var questions: [Questions]? {
        didSet {
            self.dataFetched?()
        }
    }
    private var currentQuestion: Questions?
    
    init(_ questionViewDataHandler: QuestionViewModelDataHandlerDelegate,
         _ coreDataManager: CoreDataManager?) {
        self.questionViewDataHandler = questionViewDataHandler
        self.coreDataManager = coreDataManager
    }
    
    func loadDataFromCoreData(_ subjectId: String) {
        
        let questions = questionViewDataHandler.getDataFromCoreData(subjectId)
        guard let questionsUnWrapped = questions else { return }
        self.questions = questionsUnWrapped
    }
    
    func getNextQuestion() -> Questions? {
        
        if let unWrappeCurrentdQuestion = currentQuestion {
            upDateQuestion(unWrappeCurrentdQuestion)
            unWrappeCurrentdQuestion.isAlreadyAnswered = true
        }
        guard let unWrappedQuestions = self.questions else { return nil }
        let unAnsweredQuestions =  unWrappedQuestions.filter({$0.isAlreadyAnswered == false})
        self.currentQuestion = unAnsweredQuestions.count > 0 ? unAnsweredQuestions[0] : nil
        return currentQuestion
    }
    func upDateQuestion(_ question: Questions) {
        self.questionViewDataHandler.upDateData(questionId: "\(question.questionId)")
    }
    private func getCurrentQuestionsAnswers() -> [Answers]? {
        guard let unWrappedQuestion = self.currentQuestion,
              let answers = unWrappedQuestion.answers?.getArray() as? [Answers]
            else { return nil}
        return answers
    }
    func getTitle() -> String {
        return currentQuestion?.question ?? ""
    }
    func getAnswers() -> [(String, String)] {
        
        var toBeReturned: [(String, String)] = []
        guard let answers = getCurrentQuestionsAnswers() else { return toBeReturned}
        answers.forEach({toBeReturned.append(($0.answer ?? "", "\($0.answerId)"))})
        return toBeReturned
    }
    func isCorrect(_ answerId: String) -> Bool {
        
        guard let unWrappedQuestion = self.currentQuestion,
            let answers = unWrappedQuestion.answers?.getArray() as? [Answers]
            else { return false}
        let correctAnswer = answers.filter({$0.isCorrect})[0]
        return answerId == "\(correctAnswer.answerId)"
    }
}

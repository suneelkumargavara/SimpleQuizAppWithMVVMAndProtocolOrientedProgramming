//
//  QuestionViewDataHandler.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation

protocol QuestionViewModelDataHandlerDelegate {
    func getQuestionsWithSubjectId(_ id: Int) -> [Questions]?
    func updateQuestionStatusWithQuestionId(_ id: Int)
}

class QuestionViewModelDataHandler: QuestionViewModelDataHandlerDelegate {
    
    func getQuestionsWithSubjectId(_ id: Int) -> [Questions]? {
        return nil
    }
    func updateQuestionStatusWithQuestionId(_ id: Int) {
        
    }

}

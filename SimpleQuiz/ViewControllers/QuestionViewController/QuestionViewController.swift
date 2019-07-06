//
//  QuestionViewController.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

protocol QuestionViewDataDelegate {
    func loadNextQuestion()
    func getTitle() -> String
    func getAnswersArray() -> [(String, String)]
    func isAnswerCorrect(_ answerId: String) -> Bool
    func goBack()
}

final class QuestionViewController: UIViewController {

    var questionViewModel: QuestionViewModel!
    var viewQuestions: QuestionViewDelegate?
    var subjectId: String?
    var manager: CoreDataManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    private func initialSetup() {
        
        let questionViewDataHandler = QuestionViewModelDataHandler(manager)
        self.questionViewModel = QuestionViewModel(questionViewDataHandler, manager)
        self.questionViewModel.dataFetched = {[weak self] in
            self?.loadQuestionView()
        }
        guard let unWrappedSubject = subjectId else { return }
        self.questionViewModel?.loadDataFromCoreData(unWrappedSubject)
    }
    private func loadQuestionView() {
        self.viewQuestions = QuestionView(self, self.view.bounds)
        self.view.addSubview(self.viewQuestions as! UIView)
        let _ =  self.questionViewModel.getNextQuestion()
        self.viewQuestions?.reloadData()
    }
}
extension QuestionViewController: QuestionViewDataDelegate {
    
    func loadNextQuestion() {
        let nextQuestion = questionViewModel.getNextQuestion()
        guard let _ = nextQuestion else {
//            let alertActionOk = UIAlertAction(title: Alerts.Ok, style: .cancel) { [weak self] _  in
//                self?.dismiss(animated: true, completion: nil)
//            }
//            let alertData = AlertControllerData(title: Alerts.alert, message: Alerts.noMoreData, alertActions: [alertActionOk])
//            self.showAlert(alertData)
            self.navigationController?.popViewController(animated: true)
            return
        }
        viewQuestions?.reloadData()
    }
    func getTitle() -> String {
        
        return questionViewModel.getTitle()
    }
    func getAnswersArray() -> [(String, String)] {
        
        return questionViewModel.getAnswers()
    }
    func isAnswerCorrect(_ answerId: String) -> Bool {
        
        return questionViewModel.isCorrect(answerId)
    }
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

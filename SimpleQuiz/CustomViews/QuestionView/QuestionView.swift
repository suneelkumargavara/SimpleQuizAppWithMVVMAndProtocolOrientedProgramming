//
//  QuestionView.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    init(_ delagetQuestionData: QuestionViewDataDelegate, _ frame: CGRect)
    func reloadData()
}
final class QuestionView: UIView, QuestionViewDelegate {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerOne: UIButton!
    @IBOutlet weak var answerTwo: UIButton!
    @IBOutlet weak var answerThree: UIButton!
    @IBOutlet weak var answerFour: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private var answers: [(String, String)]?
    private var delagetQuestionData: QuestionViewDataDelegate?

    init(_ delagetQuestionData: QuestionViewDataDelegate, _ frame: CGRect) {
        self.delagetQuestionData = delagetQuestionData
        super.init(frame: frame)
        self.loadNib()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func reloadData() {
        self.changeBackgroundColorsOfButtons()
        self.questionLabel.text = delagetQuestionData?.getTitle()
        self.answers = delagetQuestionData?.getAnswersArray()
        guard let unWrappedAnswers = self.answers else { return }
        for (i, value) in unWrappedAnswers.enumerated() {
            let answerButton = self.viewWithTag(100 + i) as? UIButton
            answerButton?.setTitle(value.0, for: .normal)
        }
    }
    func changeBackgroundColorsOfButtons() {
        contentView.subviews.forEach({
            if $0.isKind(of: UIButton.self) {
                if $0.tag != 1200 {
                    $0.backgroundColor = Colors.colorTheme
            }
            }
        })
    }
    @IBAction func  answerButtonClicked(_ button: UIButton) {
        contentView.isUserInteractionEnabled = false
        let isCorrect =  self.delagetQuestionData?.isAnswerCorrect(self.answers![button.tag - 100].0)
        isCorrect! ? (button.backgroundColor = UIColor.green) : (button.backgroundColor = UIColor.red)
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] _ in
            self?.contentView.isUserInteractionEnabled = true
            self?.delagetQuestionData?.loadNextQuestion()
        }
    }
    @IBAction func buttonBackPressed(_ sender: UIButton) {
        delagetQuestionData?.goBack()
    }
}

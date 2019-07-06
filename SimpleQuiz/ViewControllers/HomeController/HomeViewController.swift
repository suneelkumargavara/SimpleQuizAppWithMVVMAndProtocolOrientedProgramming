//
//  HomeViewController.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var coreDataManager: CoreDataManager?
    private var viewHome: HomeViewAndTableDelegate?
    private var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    private func initialSetup() {
        self.setupViewModel()
        self.setUpHomeView()
    }
    private func setupViewModel() {
        
        let handler = HomeViewModelDataHandler(self.coreDataManager)
        viewModel = HomeViewModel(handler)
        viewModel.reloadData = { [weak self] in
            self?.viewHome?.tableViewHome?.reloadData()
        }
        viewModel.loadData()
    }
    private func setUpHomeView() {
        self.viewHome = HomeView(self, self.view.bounds)
        self.view.addSubview(self.viewHome as! UIView)
    }
}

extension HomeViewController: HomeTableViewFeeder {
    
    func numberOfSections() -> Int {
        return viewModel.getNumberOfSections()
    }
    
    func numberOfRows(_ index: Int) -> Int {
        return viewModel.getNumberOfRows(section: index)
    }
    
    func getData(for indexPath: IndexPath) -> (String, UIImage?) {
        return viewModel.getDataForIndexPath(indexPath)
    }
    func onRowSelect(_ indexPath: IndexPath) {
        let subjectId = viewModel.getSubjectId(indexPath)
        guard let unWrappedSubjectId = subjectId else { return }
        let mainStoryBoard = UIStoryboard(name: StoryBoardNames.Main, bundle: nil)
        let vcQuestion = mainStoryBoard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.QuestionViewController) as! QuestionViewController
        vcQuestion.subjectId = unWrappedSubjectId
        vcQuestion.manager = coreDataManager
        self.navigationController?.pushViewController(vcQuestion, animated: true)
    }
}

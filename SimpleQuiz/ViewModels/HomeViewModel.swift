//
//  HomeViewModel.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit


final class HomeViewModel {
    
    private var homeDataHandler: HomeViewDataHandlerProtocol
    
    private var subjects: [Subjects]? {
        didSet {
            self.reloadData?()
        }
    }
    var reloadData: (() -> ())?

    
    init(_ handler: HomeViewDataHandlerProtocol) {
        
        self.homeDataHandler = handler
    }
    func loadData() {
        
        self.homeDataHandler.loadDataOnToCoreData? { [weak self] in
            let subjectsFromFetch = self?.homeDataHandler.subjectFetchRequest()
            self?.subjects = subjectsFromFetch
        }
    }
    func getDataForIndexPath(_ indexPath: IndexPath) -> (String, UIImage?) {
        
        let subjectName = subjects?[indexPath.row].subject ?? ""
        return (subjectName, UIImage(named: "learning"))
    }
    func getSubjectId(_ indexPath: IndexPath) -> String? {
        let subject = subjects?[indexPath.row].subjectId
        return subject == nil ? nil : "\(subject!)"
    }
    func getNumberOfSections() -> Int {
        
        return 1
    }
    func getNumberOfRows(section: Int) -> Int {
        
        return subjects?.count ?? 0
    }
}

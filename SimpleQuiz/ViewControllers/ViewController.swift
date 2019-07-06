//
//  ViewController.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit


typealias ViewWithTableViewMethods = UITableViewDataSource & UITableViewDelegate

final class HomeViewController: UIViewController {
    
    private var viewHome: ViewWithTableViewMethods!
    
    private var viewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    private func initialSetup() {
        self.viewHome = HomeView(frame: self.view.bounds) as! ViewWithTableViewMethods
        self.viewHome
    }
}


//
//  HomeView.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import UIKit

protocol HomeViewDelegate {
    init(_ delegateForTableViewData: HomeTableViewFeeder, _ frame: CGRect)
    var tableViewHome: UITableView?{get}
}

typealias HomeViewAndTableDelegate = HomeViewDelegate & UITableViewDelegate & UITableViewDataSource
    
final class HomeView: UIView, HomeViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private weak var delegateForTableViewData: HomeTableViewFeeder?
    
    // MARK: HomeView Delegate Methods
    
    init(_ delegateForTableViewData: HomeTableViewFeeder, _ frame: CGRect) {
        super.init(frame: frame)
        self.delegateForTableViewData = delegateForTableViewData
        self.initialSetup()
    }
    
    var tableViewHome: UITableView? {
        return self.tableView
    }
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private func initialSetup() {
        self.loadNib()
        self.tableView.register(UINib(nibName: NibNames.CellPlayerModeAndSubjectInfo, bundle: nil), forCellReuseIdentifier: CellIdentifiers.HomeCellIdentifier)
        self.tableView.addFooter()
    }
}
extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return self.delegateForTableViewData?.numberOfSections() ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegateForTableViewData?.numberOfRows(section) ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.getCell(indexPath)
    }
    func getCell(_ indexPath: IndexPath) -> CellPlayerModeAndSubjectInfo {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.HomeCellIdentifier, for: indexPath) as! CellPlayerModeAndSubjectInfo
        if let unWrappedDelegate = delegateForTableViewData {
            let titleAndImage = unWrappedDelegate.getData(for: indexPath)
            cell.setData(titleAndImage: titleAndImage)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegateForTableViewData?.onRowSelect(indexPath)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.frame.size.height * 0.2
    }
}

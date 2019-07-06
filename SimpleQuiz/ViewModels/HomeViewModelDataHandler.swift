//
//  HomeViewModelDataHandler.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 06/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import Foundation
import CoreData

@objc protocol HomeViewDataHandlerProtocol: class {
    
    func subjectFetchRequest() -> [Subjects]?
    
    @objc optional
    func loadDataOnToCoreData(_ onCompletion: @escaping () -> ())
}

final class HomeViewModelDataHandler: HomeViewDataHandlerProtocol {
    
    private let dataManager: CoreDataManager?
    
    init(_ coreDataManager: CoreDataManager?) {
        
        self.dataManager = coreDataManager
    }
    
    func subjectFetchRequest() -> [Subjects]? {
        
        guard let unWrappedManager = dataManager else { return nil}
        let fetchRequest = NSFetchRequest<Subjects>(entityName: "Subjects")
        do {
            let results = try unWrappedManager.performFetchRequest(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
            return results as? [Subjects] ?? nil
        }
        catch{
            print("\(error.localizedDescription)")
            return nil
        }
    }

    func loadDataOnToCoreData(_ onCompletion: @escaping () -> ()) {
        
        let jsonPathUrl = Bundle.main.path(forResource: "Subjects", ofType: "json")
        guard let unWrappedPath = jsonPathUrl,
            let jsonString = try? String(contentsOfFile: unWrappedPath),
            let data = jsonString.data(using: .utf8),
            let serializedValue = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let arraySubjects = serializedValue["Subjects"] as? [[String: Any]]
        else {
            fatalError("File Does Not Exists")
        }
        for (_, value) in  arraySubjects.enumerated() {
            Subjects.addSubjectToCoreData(value, dataManager)
        }
        guard let manager = dataManager else { return }
        do {
            try manager.getManagedObjectContext().save()
            onCompletion()
        }
        catch{
            print("\(error), \(error.localizedDescription)")
        }
    }
}

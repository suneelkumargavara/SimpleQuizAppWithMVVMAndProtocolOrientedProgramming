//
//  CoreDataManager.swift
//  SimpleQuiz
//
//  Created by Sunilkumar Gavara on 05/07/19.
//  Copyright © 2019 Sunilkumar Gavara. All rights reserved.
//

import CoreData
import Foundation

enum CoreDataManagerError: Error {
    case ResultsNotFound
    case InSufficientData
}
public class CoreDataManager {
    
    private let modelName: String
    
    /****************** Managed Object Mode *************************/
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError(CoreDataErrors.UnableToFindModel)
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError(CoreDataErrors.UnableToLoadData)
        }
        return managedObjectModel
    }()
    
    /**************** Persistant Store Coordinator ******************/
    
    private lazy var persistantStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let storeCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        return storeCoordinator
    }()
    
    /************** Private Managed Object Context **************/
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = self.persistantStoreCoordinator
        return managedObjectContext
    }()
    
    /************ Main Managed Object Context **********************/
    
    public private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.privateManagedObjectContext
        return managedObjectContext
    }()

    /************ Private Child Managed Object Context ************/
    
    private lazy var privateChildManagedObjectContext: NSManagedObjectContext = {
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        managedObjectContext.parent = self.mainManagedObjectContext
        
        return mainManagedObjectContext
    }()
    
    public init(_ modelName: String) {
        self.modelName = modelName
        setupCoreDataStack()
    }
    
    // MARK: Initializing the coredata stack in background
    private func setupCoreDataStack() {
        guard let persistantStoreCoordinator = mainManagedObjectContext.persistentStoreCoordinator else {
            fatalError("Unable to setup coredata stack")
        }
        self.addPersistanceStore(to: persistantStoreCoordinator)
    }
    private func addPersistanceStore(to persistanceCoordinator: NSPersistentStoreCoordinator) {
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistantStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        do {
            let options = [NSMigratePersistentStoresAutomaticallyOption: true,
                           NSInferMappingModelAutomaticallyOption: true]
            try persistanceCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                    configurationName: nil,
                                                    at: persistantStoreURL,
                                                    options: options)
        }
        catch {
            fatalError(CoreDataErrors.UnableToAddPersistantCoordinator)
        }
    }
    func getManagedObjectContext() -> NSManagedObjectContext {
        
        return self.privateChildManagedObjectContext
    }
    
    //MARK Perform Fetch Request
    
    public func performFetchRequest(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) throws ->  [NSManagedObject]?  {
        
        do {
           let results =  try privateChildManagedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
           guard let unWrappedResults = results else {
                throw CoreDataManagerError.ResultsNotFound
           }
           return unWrappedResults
        }
        catch {
            throw CoreDataManagerError.InSufficientData
        }
    }
    //MARK: Save Changes to main
    
    public func saveChanges(_ onSavingCompletion: (() -> ())?) {
        
        privateChildManagedObjectContext.performAndWait {
            do {
                if privateChildManagedObjectContext.hasChanges {
                    try privateChildManagedObjectContext.save()
                }
               }
                catch {
                    print("\(error), \(error.localizedDescription)")
                }
            }
        mainManagedObjectContext.performAndWait {
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            }
            catch {
                print("Unable to save Changes in main managed object context")
                print("\(error), \(error.localizedDescription)")
            }
        }
        privateManagedObjectContext.perform {
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                    print("All Items Saved SuccessFully")
                    onSavingCompletion?()
                }
            }
            catch {
                print("Unable to save changes in private managed object context")
                print("\(error), \(error.localizedDescription)")
            }
        }
    }
}


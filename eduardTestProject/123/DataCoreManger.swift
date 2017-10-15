//
//  DataCoreManger.swift
//  TestProject
//
//  Created by Novikov on 11.10.17.
//  Copyright © 2017 Novikov All rights reserved.
//

import Foundation
import CoreData

class DataCoreManger {
 
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    //модель бд которая в папке People.xmodel
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "People", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("People.sqlite")
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch (let error){
            NSLog("Unresolved error \(error)")
        }
        return coordinator
    }()

    
    func getAll() -> [People] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Man", in: self.managedObjectContext)
        
        fetchRequest.entity = entityDescription

        var array: [People] = []
        
        do {
            let fetchedArray = try self.managedObjectContext.fetch(fetchRequest)
            
            for man in fetchedArray as! [Man] {
                let yourMan = People()
                yourMan.email = man.email
                yourMan.name = man.name
                yourMan.birthday = man.birthDay
                array.append(yourMan)
            }
            
        } catch let error {
            print(error)
        }
        
        return array
    }

    
    func saveMan(man: People) {
        let managedMan = NSEntityDescription.insertNewObject(forEntityName: "Man", into: self.managedObjectContext) as! Man
        managedMan.name = man.name
        managedMan.email = man.email
        managedMan.birthDay = man.birthday
        self.save()
    }
    
    func save() {
        do {
            try managedObjectContext.save()
        } catch (let error) {
            print(error)
            return
        }
        print("Saved Succesfully")
    }
    
}


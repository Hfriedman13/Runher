//
//  CoreDataStack.swift
//  Runher
//
//  Created by Hannah Friedman on 12/28/20.
//

import CoreData

class CoreDataStack {
//MARK: - Core data stack
  static let persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Runher")
    container.loadPersistentStores { (_, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
    return container
  }()
  
  static var context: NSManagedObjectContext { return persistentContainer.viewContext }
  
//MARK: - Core data saving support
  class func saveContext () {
    let context = persistentContainer.viewContext
    
    guard context.hasChanges else {
      return
    }
    
    do {
      try context.save()
    } catch {
      let nserror = error as NSError
      fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
    }
  }
}


//
//  Persistence.swift
//  DigitalDetox
//
//  Created by George on 2024/11/8.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let user = User(context: viewContext)
        user.id = UUID()
        user.username = "Preview User"
        user.coralBalance = 1000
        user.createdAt = Date()
        user.lastLoginAt = Date()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "DigitalDetox")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension User {
    var dailyLimitValue: Int {
        get {
            return Int(dailyLimit)
        }
        set {
            dailyLimit = Int32(newValue)
        }
    }
}

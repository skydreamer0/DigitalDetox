//
//  Persistence.swift
//  DigitalDetox
//
//  Created by George on 2024/11/8.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    // 添加當前用戶屬性
    private(set) var currentUser: User?
    
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
        
        // 初始化時嘗試獲取或創建用戶
        setupCurrentUser()
    }
    
    // 設置當前用戶
    private func setupCurrentUser() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try context.fetch(fetchRequest)
            if let existingUser = users.first {
                currentUser = existingUser
            } else {
                // 創建新用戶
                let newUser = User(context: context)
                newUser.id = UUID()
                newUser.username = "Default User"
                newUser.createdAt = Date()
                newUser.coralBalance = 0
                
                try context.save()
                currentUser = newUser
            }
        } catch {
            print("Error setting up current user: \(error)")
        }
    }
    
    // 更新當前用戶
    func updateCurrentUser(_ user: User) {
        currentUser = user
        do {
            try container.viewContext.save()
        } catch {
            print("Error updating current user: \(error)")
        }
    }
    
    // 獲取當前用戶
    func getCurrentUser() -> User? {
        return currentUser
    }
}

// MARK: - Preview Helper
extension PersistenceController {
    @MainActor
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // 創建預覽用戶
        let previewUser = User(context: viewContext)
        previewUser.id = UUID()
        previewUser.username = "Preview User"
        previewUser.createdAt = Date()
        previewUser.coralBalance = 1000
        previewUser.lastLoginAt = Date()
        
        result.currentUser = previewUser
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
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

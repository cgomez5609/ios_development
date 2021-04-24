//
//  CoreDataSingle.swift
//  BudgetApp
//
//  Created by Chris Gomez on 4/7/21.
//

import Foundation
import CoreData

// viewContext in the persistentContainer is the temporary area where data is read, changed etc. until it is stored in persistent storage

class CoreDataManager {
    static let CDManager = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func createNewUser(username: String, password: Int16, amount: Double) {
        let context = persistentContainer.viewContext
        
        
        let checkDatabase = fetchUser(withUsername: username)
        
        if checkDatabase == nil {
            let newUser: User = User(context: context)
            
            newUser.username = username
            newUser.password = password
            
            
            let account : Account = Account(context: context)
            account.amount = amount
            newUser.account = account
            
            do {
                try context.save()
                print("User \(username) has successfully been saved")
                print("user has \(newUser.account?.amount ?? 0)")
            } catch let error {
                print("Failed to create new user: \(error)")
            }
        } else {
            print("User \(username) already in database")
        }
        

    }
    
    func fetchUser(withUsername username : String) -> User? {
        let context = persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)
        
        do {
            let user = try context.fetch(fetchRequest)
            return user.first
        } catch let error {
            print("Failed to fetch user \(error)")
        }
        
        return nil
    }
    
    func updateUser(withUsername username: String, newUsername: String, newPassword: Int16) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = fetchUser(withUsername: username)
        
        if let user = fetchRequest {
            user.setValue(newUsername, forKey: "username")
            user.setValue(newPassword, forKey: "password")
            
            do {
                try context.save()
                print("new user has been saved \(username) is not \(newUsername) with password \(newPassword)")
            }catch {
                print("could not update: \(error)")
            }
        }
    }
    
    func addPurchases(forUsername username: String, company: String, purchaseAmount: Double) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = fetchUser(withUsername: username)
        
        if let user = fetchRequest {
            let userAccount = user.account
            let purchase : Purchases = Purchases(context: context)
            purchase.company = company
            purchase.purchaseAmount = purchaseAmount
            
            
            if let account = userAccount {
                account.addToPurchase(purchase)
                
                do {
                    try context.save()
                    print("purchase added")
                    print(account.purchase)
                }catch {
                    print("could not update: \(error)")
                }
            }
        }
    }
    
    func checkPurchases(forUsername username: String) {
        let fetchRequest = fetchUser(withUsername: username)
        
        if let user = fetchRequest {
            if let userAccount = user.account {
                if let purchases = userAccount.purchase {
                    for item in purchases as! Set<Purchases> {
                        print(item.company, item.purchaseAmount)
                    }
            }            
        }
            
            
        } else {
            print("user not in system")
        }
    }
    
    
    
    func updateAmount(forUser username: String, increaseBy newAmount: Double) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = fetchUser(withUsername: username)
        
        if let user = fetchRequest {
            if let account = user.account {
                account.amount += newAmount
                do {
                    try context.save()
                    print("new user has updated his account amount with \(account.amount) from \(account.amount - newAmount)")
                }catch {
                    print("could not update: \(error)")
                }
            } else {
                print("user does not have an account")
            }
            
            
        }
    }
    
    func deleteUser(username: String) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = fetchUser(withUsername: username)
        
   
        if let user = fetchRequest {
            context.delete(user)
            
            do {
                try context.save()
                print("User \(username) was successfully deleted")
            }catch {
                print("could not update: \(error)")
            }
        } else {
            print("returned nil when fetching")
        }
     
    }
        
    
}

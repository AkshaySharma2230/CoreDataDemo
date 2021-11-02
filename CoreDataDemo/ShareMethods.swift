//
//  ShareMethods.swift
//  CoreDataDemo
//
//  Created by apple on 02/11/21.
//

import Foundation
import CoreData

class ShareMethods : NSObject {
    
    static let sharesInstance = ShareMethods()
    let context =  NSManagedObjectContext()
    
    var models = [User]()
    
    func getAllIteam(){
        do {
            models = try context.fetch(User.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        } catch  {
            // error
        }
        
    }
    
    func createIteam(name: String, email: String, password: String){
        let newIteam = User(context: context)
        newIteam.name = name
        newIteam.email = email
        newIteam.password = password
        
        do {
            try context.save()
            // getAllIteam()
        }
        catch {
        }
        
    }
    
    func deleteIteam(iteam: User){
        context.delete(iteam)
        do {
            try context.save()
            // getAllIteam()
        }
        catch {
            // error
        }
    }
    
    func updateIteam(iteam: User, name: String, email: String, password: String){
        iteam.name = name
        iteam.email = email
        iteam.password = password
        
        do {
            try context.save()
            // getAllIteam()
        }
        catch {
            // error
        }
    }
    
    
    
}

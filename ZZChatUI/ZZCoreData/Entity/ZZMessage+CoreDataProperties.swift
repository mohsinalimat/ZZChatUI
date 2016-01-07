//
//  ZZMessage+CoreDataProperties.swift
//  
//
//  Created by duzhe on 16/1/7.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ZZMessage {
    
    @NSManaged var id: NSNumber?
    @NSManaged var from: NSNumber?
    @NSManaged var userName: String?
    @NSManaged var time: NSDate?
    @NSManaged var headImage: NSData?

}

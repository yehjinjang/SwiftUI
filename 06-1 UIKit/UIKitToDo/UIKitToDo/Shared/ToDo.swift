//
//  ToDo.swift
//  UIKitToDo
//
//  Created by 장예진 on 5/24/24.
//

import Foundation


struct ToDo: Codable , Identifiable{
    var id = UUID()
    var title : String
    var isCompleted : Bool
    var isFavorite : Bool
    var dueDate : Date?
    var isRecurring : Bool // 주마다 반복할까 물어보는건데 왜알람이안뜨짘
    var isPending : Bool = false
    
}

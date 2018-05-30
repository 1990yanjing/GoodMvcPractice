//
//  ToDoStore.swift
//  ToDoMVC
//
//  Created by wangyan on 2018/5/29.
//  Copyright © 2018年 wangyan. All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

struct ToDoItem: Mappable {
    
    var id: String?
    var title: String?
    
    init(title: String) {
        self.id = "Default"
        self.title = title
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id      <- map["id"]
        title   <- map["title"]
    }
}

extension ToDoItem: Equatable {
    
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        
        return lhs.id == rhs.id
    }
}

extension ToDoItem: Hashable {
    
    var hashValue: Int {
        
        return title!.hashValue
    }
}

class ToDoStore {
    
    static let shared = ToDoStore()
    
    private(set) var items: [ToDoItem] = [] {
        
        didSet {
            
            NotificationCenter.default.post(
                name: NSNotification.Name(rawValue: "toDoStoreDidChangedNotification"),
                object: self,
                userInfo: nil
            )
        }
    }
    private init() {}
    
    func append(item: ToDoItem) {
        
        items.append(item)
    }
    
    func append(newItems: [ToDoItem]) {
        
        items.append(contentsOf: newItems)
    }
    
    func remove(item: ToDoItem) {
        
        guard let index = items.index(of: item) else { return }
        remove(at: index)
    }
    
    func remove(at index: Int) {
        
        items.remove(at: index)
    }
    
    func edit(original: ToDoItem, new: ToDoItem) {
        
        guard let index = items.index(of: original) else { return }
        items[index] = new
    }
    
    var count: Int {
        
        get {
            
            return items.count
        }
    }
    
    func item(at index: Int) -> ToDoItem {
        
        return items[index]
    }
    
    func getAlItems() -> Promise<[ToDoItem]> {
        
        return NetworkServie.shared.request(url: "https://leancloud.cn:443/1.1/classes/HXAPPNetworkMOCK?where={\"apiName\":\"items\"}").then(on: DispatchQueue.global()) { (bean) -> Promise<[ToDoItem]> in
            
            if let data = bean?.data, let items = Mapper<ToDoItem>().mapArray(JSONString: data) {
                
                self.append(newItems: items)
            }
            return Promise.value(self.items)
        }
    }
}

//
//  Queue.swift
//  Test
//
//  Created by Elene Akhvlediani on 2/11/19.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import Foundation
struct Queue<T> {
    fileprivate var array = [T]()
    
    public var count: Int {
        return array.count
    }
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    public mutating func dequeue() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    mutating func enqueue(array: [T]) {
        array.forEach { element in
            enqueue(element)
        }
    }
}

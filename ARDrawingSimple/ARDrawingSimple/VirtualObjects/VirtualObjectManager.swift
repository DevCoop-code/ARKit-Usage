//
//  VirtualObjectManager.swift
//  ARDrawingSimple
//
//  Created by HanGyo Jeong on 06/01/2019.
//  Copyright © 2019 HanGyoJeong. All rights reserved.
//

import Foundation
import ARKit

class VirtualObjectManager {
    
    var virtualObjects = [VirtualObject]()
    
    var lastUsedObject: VirtualObject?
    
    /// The queue with updates to the virtual objects are made on.
    var updateQueue: DispatchQueue
    
    init(updateQueue: DispatchQueue) {
        self.updateQueue = updateQueue
    }
}

protocol VirtualObjectManagerDelegate: class {
    //Definition protocol Function
}

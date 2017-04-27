//
//  AssociatedObject.swift
//  Papyrus
//
//  Created by Sergey Gorin on 30.03.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

import ObjectiveC

typealias AObj = AssociatedObject

struct AssociatedObject {
  
  static func get<V: Any>(_ object: Any!, key: UnsafeRawPointer!, initialiser: () -> V) -> V {
    guard let obj = objc_getAssociatedObject(object, key) as? V else {
      let value = initialiser()
      set(object, key: key, value: value)
      return value
    }
    return obj
  }
  
  static func set<V: Any>(_ object: Any!,
                  key: UnsafeRawPointer!,
                  value: V,
                  policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
    objc_setAssociatedObject(object, key, value, policy)
  }
  
  static func remove(_ object: Any!) {
    objc_removeAssociatedObjects(object)
  }
}

//
//  Papyrus.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 ToBox. All rights reserved.
//

import UIKit

public typealias CollectionView = UICollectionView
public typealias ScrollView = UIScrollView

public final class Papyrus<Type> {
  public let instance: Type
  public init( _ instance: Type) {
    self.instance = instance
  }
}

// To use `papyrus` as namespace
public protocol PapyrusCompatible {
  associatedtype CompatibleType
  var papyrus: CompatibleType { get }
}

extension PapyrusCompatible {
  public var papyrus: Papyrus<Self> {
    return Papyrus(self)
  }
}

extension CollectionView: PapyrusCompatible {}

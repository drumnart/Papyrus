//
//  Papyrus.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

import UIKit

public typealias CollectionView = UICollectionView
public typealias TableView = UITableView
public typealias ScrollView = UIScrollView

public final class Papyrus<BaseType> {
  public let base: BaseType
  public init( _ instance: BaseType) {
    self.base = instance
  }
}

// To use `pap` as namespace
public protocol PapyrusCompatible {
  associatedtype CompatibleType
  var pap: CompatibleType { get }
}

extension PapyrusCompatible {
  public var pap: Papyrus<Self> {
    return Papyrus(self)
  }
}

extension CollectionView: PapyrusCompatible {}
extension Papyrus: ReusableItemsManager {}
extension Papyrus: PullToRefreshable {
  public var refreshControlOwner: BaseType { return base }
}

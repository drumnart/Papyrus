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
  public init(_ base: BaseType) {
    self.base = base
  }
}

// To extend types by Papyrus
public protocol PapyrusCompatible {
  associatedtype CompatibleType
  var pap: CompatibleType { get } // `pap` used as namespace
}

public extension PapyrusCompatible {
  public var pap: Papyrus<Self> {
    return Papyrus(self)
  }
}

// Make `UICollectionView` compatible to Papyrus
extension CollectionView: PapyrusCompatible {
  // Papyrus instance with default (embeded) datasource and delegate
  public var pap: Papyrus<CollectionView> {
    return Papyrus(self)
      .setDataSource(.embeded)
      .setDelegate(.embeded)
  }
}

extension Papyrus: ReusableItemsManager {
  public var listView: BaseType { return base }
}
extension Papyrus: PullToRefreshable {
  public var refreshControlOwner: BaseType { return base }
}

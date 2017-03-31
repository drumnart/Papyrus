//
//  Reusable.swift
//  Papyrus
//
//  Created by Sergey Gorin on 31.03.17.
//  Copyright © 2017 ToBox. All rights reserved.
//

protocol Reusable: class {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: self)
  }
}

protocol NibReusable: Reusable, NibInstantiable {}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}

extension UICollectionView {
  
  // Use one of these methods to register collectionView's cell without using a UINib or
  // dequeue cell without using string literals in reuseIdentifiers.
  // Every method uses class's name as an identifier and a nibName.
  
  /// Register class-based UICollectioniewCell
  /// Example: collectionView.registerCell(CustomCollectionViewCell.self)
  @discardableResult func registerCell<T: UICollectionViewCell>(_: T.Type) -> Self  where T: Reusable {
    register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register nib-based UICollectioniewCell
  /// Example: collectionView.registerCell(CustomCollectionViewCell.self)
  @discardableResult func registerCell<T: UICollectionViewCell>(_: T.Type) -> Self where T: NibReusable  {
    register(T.nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register a bunch of nib-based or class-based cells of type/subtype UICollectionViewCell
  /// - Parameters: types - array of cells' classes
  /// - Returns: UICollectionView.self
  /// - Example: collectionView.registerCells([CustomCollectionViewCell.self])
  @discardableResult func registerCells<T: UICollectionViewCell>(_ types: [T.Type]) -> Self where T: Reusable {
    types.forEach {
      if let cellClass = $0 as? NibReusable.Type {
        register(cellClass.nib, forCellWithReuseIdentifier: $0.reuseIdentifier)
      } else {
        register($0.self, forCellWithReuseIdentifier: $0.reuseIdentifier)
      }
    }
    return self
  }
  
  /// Dequeue custom UICollectionViewCell
  /// Example: let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
  func dequeueCell<T: UICollectionViewCell>(_: T.Type = T.self, for indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue cell with reuse identifier \(T.reuseIdentifier). Verify id in XIB/Storyboard.")
    }
    return cell
  }
  
  /// Register class-based UICollectionReusableView
  @discardableResult func registerView<T: UICollectionReusableView>(_: T.Type, kind: String) -> Self where T: Reusable {
    register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register nib-based UICollectionReusableView
  @discardableResult func registerView<T: UICollectionReusableView>(_: T.Type, kind: String) -> Self where T: NibReusable {
    register(T.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register a bunch of nib-based and/or class-based reusable views subclassed from UICollectionReusableView
  @discardableResult func registerViews<T: UICollectionReusableView>(_ types: [T.Type], kind: String) -> Self
    where T: Reusable {
      types.forEach {
        if let cellClass = $0 as? NibReusable.Type {
          register(cellClass.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: $0.reuseIdentifier)
        } else {
          register($0.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: $0.reuseIdentifier)
        }
      }
      return self
  }
  
  /// Dequeue custom UICollectionReusableView instance
  func dequeueView<T: UICollectionReusableView>(_: T.Type = T.self, kind: String,
                   for indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier,
                                                      for: indexPath) as? T else {
                                                        fatalError("Failed to dequeue supplementary view with reuse identifier \(T.reuseIdentifier). Verify id in XIB/Storyboard.")
    }
    return cell
  }
  
  /// Get cell by indexPath through subscript
  subscript(indexPath: IndexPath) -> UICollectionViewCell? {
    return cellForItem(at: indexPath)
  }
}

extension UITableView {
  
  // Use one of these methods to register tableView's cell without using a UINib or
  // dequeue cell without using string literals in reuseIdentifiers.
  // Every method uses class's name as an identifier and a nibName.
  
  /// Register class-based UITableViewCell
  /// Example: tableView.registerCell(CustomTableViewCell)
  @discardableResult func registerCell<T: UITableViewCell>(_: T.Type) -> Self where T: Reusable {
    register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register nib-based UITableViewCell
  /// Example: tableView.registerCell(CustomTableViewCell)
  @discardableResult func registerCell<T: UITableViewCell>(_: T.Type) -> Self where T: NibReusable {
    register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register a bunch of nib-based or class-based cells of type UITableViewCell
  /// - Parameters: types - array of cells' classes
  /// - Returns: UITableViewView.self
  /// - Example: tableView.registerCells([CustomCollectionViewCell.self])
  @discardableResult func registerCells<T: UITableViewCell>(_ types: [T.Type]) -> Self where T: Reusable {
    types.forEach {
      if let cellClass = $0 as? NibReusable.Type {
        register(cellClass.nib, forCellReuseIdentifier: $0.reuseIdentifier)
      } else {
        register($0.self, forCellReuseIdentifier: $0.reuseIdentifier)
      }
    }
    return self
  }
  
  /// Dequeue custom UITableViewCell
  /// Example: let cell: CustomTableViewCell = tableView.dequeueReusableCell(for: indexPath)
  func dequeueCell<T: UITableViewCell>(_: T.Type = T.self, for indexPath: IndexPath) -> T where T: Reusable {
    guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
      fatalError("Failed to dequeue cell with reuse identifier \(T.reuseIdentifier). Verify id in XIB/Storyboard.")
    }
    return cell
  }
  
  /// Register class-based UITableViewHeaderFooterView class
  @discardableResult func registerView<T: UITableViewHeaderFooterView>(_: T.Type) -> Self where T: Reusable {
    register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register nib-based UITableViewHeaderFooterView class
  @discardableResult func registerView<T: UITableViewHeaderFooterView>(_: T.Type) -> Self where T: NibReusable {
    register(T.nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    return self
  }
  
  /// Register a bunch of nib-based and/or class-based views subclassed from UITableViewHeaderFooterView
  @discardableResult func registerViews<T: UITableViewHeaderFooterView>(_ types: [T.Type]) -> Self where T: Reusable {
    types.forEach {
      if let cellClass = $0 as? NibReusable.Type {
        register(cellClass.nib, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
      } else {
        register($0.self, forHeaderFooterViewReuseIdentifier: $0.reuseIdentifier)
      }
    }
    return self
  }
  
  /// Dequeue custom UITableViewHeaderFooterView instance
  func dequeueView<T: UITableViewHeaderFooterView>(_: T.Type = T.self) -> T? where T: Reusable {
    guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T? else {
      fatalError("Failed to dequeue reusable view with reuse identifier \(T.reuseIdentifier). Verify id in XIB/Storyboard.")
    }
    return cell
  }
  
  /// Get cell by indexPath through subscript
  subscript(indexPath: IndexPath) -> UITableViewCell? {
    return cellForRow(at: indexPath)
  }
}

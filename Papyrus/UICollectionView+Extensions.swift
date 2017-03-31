//
//  UICollectionView+Extensions.swift
//  Papyrus
//
//  Created by Sergey Gorin on 30.03.17.
//  Copyright © 2017 ToBox. All rights reserved.
//

// MARK: - Common `UICollectionView` extensions

extension UICollectionView {
  public var flowLayout: UICollectionViewFlowLayout? {
    return collectionViewLayout as? UICollectionViewFlowLayout
  }
  
  public var scrollDirection: UICollectionViewScrollDirection {
    get {
      return flowLayout?.scrollDirection ?? .vertical
    }
    set {
      flowLayout?.scrollDirection = newValue
    }
  }
  
  public var interItemSpacing: CGFloat {
    return flowLayout?.minimumInteritemSpacing ?? 0
  }
  
  public var itemSize: CGSize {
    return flowLayout?.itemSize ?? .zero
  }
  
  @nonobjc @discardableResult func setBackgroundView(_ backgroundView: UIView?) -> Self {
    self.backgroundView = backgroundView
    return self
  }
  
  @nonobjc @discardableResult public func setScrollDirection(_ direction: UICollectionViewScrollDirection) -> Self {
    flowLayout?.scrollDirection = direction
    return self
  }
  
  @discardableResult public func setItemSize(_ itemSize: CGSize) -> Self {
    flowLayout?.itemSize = itemSize
    return self
  }
  
  @discardableResult public func setInteritemSpacing(_ spacing: CGFloat) -> Self {
    flowLayout?.minimumInteritemSpacing = spacing
    return self
  }
}

extension UICollectionView {
  
  /// Freeze collection view sections' header / footer to visible bounds where layout is UICollectionViewFlowLayout
  @discardableResult public func sectionElements(_ kinds: SectionElementKindSet, shouldPinToVisibleBounds value: Bool) -> Self {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
      print("Couldn't pin header/footer to visible bounds because current layout is not of type UICollectionViewFlowLayout.")
      return self
    }
    if #available(iOS 9.0, *) {
      if kinds.contains(.header) {
        flowLayout.sectionHeadersPinToVisibleBounds = value
      }
      if kinds.contains(.footer) {
        flowLayout.sectionFootersPinToVisibleBounds = value
      }
    }
    return self
  }
}

public enum SectionElementKind {
  case header
  case footer
  case any(String)
  
  static let Header = UICollectionElementKindSectionHeader
  static let Footer = UICollectionElementKindSectionFooter
  
  init(_ rawValue: String) {
    switch rawValue {
    case SectionElementKind.Header: self = .header
    case SectionElementKind.Footer: self = .footer
    default: self = .any(rawValue)
    }
  }
  
  var value: String {
    switch self {
    case .header: return SectionElementKind.Header
    case .footer: return SectionElementKind.Footer
    case .any(let rawValue): return rawValue
    }
  }
}

public struct SectionElementKindSet: OptionSet {
  public init(rawValue: UInt) {
    self.rawValue = rawValue
  }
  public fileprivate(set) var rawValue: UInt
  
  static let header = SectionElementKindSet(rawValue: 1)
  static let footer = SectionElementKindSet(rawValue: 2)
}

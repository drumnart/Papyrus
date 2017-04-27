//
//  UICollectionView+Extensions.swift
//  Papyrus
//
//  Created by Sergey Gorin on 30.03.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

// MARK: - Common `UICollectionView` extensions
extension CollectionView {
  
  public enum SectionElementKind {
    case header
    case footer
    case any(String)
    
    static let Header = UICollectionElementKindSectionHeader
    static let Footer = UICollectionElementKindSectionFooter
    
    public init(_ rawValue: String) {
      switch rawValue {
      case SectionElementKind.Header: self = .header
      case SectionElementKind.Footer: self = .footer
      default: self = .any(rawValue)
      }
    }
    
    public var value: String {
      switch self {
      case .header: return SectionElementKind.Header
      case .footer: return SectionElementKind.Footer
      case .any(let rawValue): return rawValue
      }
    }
  }
  
  /// Freeze collection view sections' header / footer to visible bounds where layout is UICollectionViewFlowLayout
  @discardableResult func sectionElements(_ kinds: SectionElementKindSet, shouldPinToVisibleBounds value: Bool) -> Self {
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

/// Option Set of keys of section parts
public struct SectionElementKindSet: OptionSet {
  public init(rawValue: UInt) {
    self.rawValue = rawValue
  }
  public fileprivate(set) var rawValue: UInt
  
  static let header = SectionElementKindSet(rawValue: 1)
  static let footer = SectionElementKindSet(rawValue: 2)
}

// MARK: - Helpers

/// Next group of methods have effect only if layout is `UICollectionViewFlowLayout`
extension CollectionView {
  
  /// Returns `UICollectionViewFlowLayout` instance if default layout is used or nil, otherwise
  var flowLayout: UICollectionViewFlowLayout? {
    return collectionViewLayout as? UICollectionViewFlowLayout
  }
  
  @discardableResult func setScrollDirection(_ direction: UICollectionViewScrollDirection) -> Self {
    flowLayout?.scrollDirection = direction
    return self
  }
  
  @discardableResult func setItemSize(_ itemSize: CGSize) -> Self {
    flowLayout?.itemSize = itemSize
    return self
  }
  
  @discardableResult func setMinInteritemSpacing(_ spacing: CGFloat) -> Self {
    flowLayout?.minimumInteritemSpacing = spacing
    return self
  }
  
  @discardableResult func setMinLineSpacing(_ spacing: CGFloat) -> Self {
    flowLayout?.minimumLineSpacing = spacing
    return self
  }
}

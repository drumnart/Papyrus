//
//  UIScrollView+Papyrus.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

// MARK: - `UIScrollView` + Common extensions
extension ScrollView {
  
  public enum DecelerationRate {
    case normal
    case fast
    case value(CGFloat)
    
    var rawValue: CGFloat {
      switch self {
      case .normal: return UIScrollViewDecelerationRateNormal
      case .fast: return UIScrollViewDecelerationRateFast
      case .value(let value): return value
      }
    }
  }
  
  public func translation(in view: UIView? = nil) -> CGPoint {
    return panGestureRecognizer.translation(in: view ?? self)
  }
  
  @discardableResult open func set(contentInset: UIEdgeInsets) -> Self {
    self.contentInset = contentInset
    return self
  }
  
  @discardableResult open func set(contentOffset: CGPoint, animated: Bool) -> Self {
    self.setContentOffset(contentOffset, animated: animated)
    return self
  }
  
  @discardableResult open func scrollsToTop(_ boolValue: Bool) -> Self {
    self.scrollsToTop = boolValue
    return self
  }
  
  @discardableResult open func decelerated(_ rate: DecelerationRate) -> Self {
    self.decelerationRate = rate.rawValue
    return self
  }
}

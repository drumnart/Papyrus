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
}

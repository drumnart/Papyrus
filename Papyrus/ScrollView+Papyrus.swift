//
//  ScrollView+Papyrus.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

import Foundation

// MARK: - `UIScrollView` + Papyrus
extension Papyrus where BaseType: ScrollView {
  
  /// Returns translation result by panGestureRecognizer in scrollView
  public func translation(in view: UIView?) -> CGPoint {
    return base.translation(in: view)
  }
  
  @discardableResult public func setContentInset(_ contentInset: UIEdgeInsets) -> Self {
    base.contentInset = contentInset
    return self
  }
  
  @discardableResult public func setContentOffset(_ contentOffset: CGPoint, animated: Bool) -> Self {
    base.setContentOffset(contentOffset, animated: animated)
    return self
  }
}

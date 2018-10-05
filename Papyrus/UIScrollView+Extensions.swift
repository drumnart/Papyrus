//
//  UIScrollView+Papyrus.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

// MARK: - `UIScrollView` + Common extensions
extension ScrollView {
  
  public func translation(in view: UIView? = nil) -> CGPoint {
    return panGestureRecognizer.translation(in: view ?? self)
  }
  
  public func velocity(in view: UIView? = nil) -> CGPoint {
    return panGestureRecognizer.velocity(in: view ?? self)
  }
}

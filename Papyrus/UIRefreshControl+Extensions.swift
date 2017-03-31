//
//  UIRefreshControl+Extensions.swift
//  Papyrus
//
//  Created by Sergey Gorin on 31.03.17.
//  Copyright © 2017 ToBox. All rights reserved.
//

extension UIRefreshControl {
  
  @nonobjc public func setTintColor(_ tintColor: UIColor) -> Self {
    self.tintColor = tintColor
    return self
  }
  
  @nonobjc public func setAttributedTitle(_ attributedTitle: NSAttributedString) -> Self {
    self.attributedTitle = attributedTitle
    return self
  }
}

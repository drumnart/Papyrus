//
//  UIRefreshControl+Extensions.swift
//  Papyrus
//
//  Created by Sergey Gorin on 31.03.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

extension UIRefreshControl {
  
  public func withTintColor(_ tintColor: UIColor) -> Self {
    self.tintColor = tintColor
    return self
  }
  
  public func withAttributedTitle(_ attributedTitle: NSAttributedString) -> Self {
    self.attributedTitle = attributedTitle
    return self
  }
}

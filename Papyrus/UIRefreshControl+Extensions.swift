//
//  UIRefreshControl+Extensions.swift
//  Papyrus
//
//  Created by Sergey Gorin on 31.03.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

extension UIRefreshControl {
  
  open func withTintColor(_ tintColor: UIColor) -> Self {
    self.tintColor = tintColor
    return self
  }
  
  open func withAttributedTitle(_ attributedTitle: NSAttributedString) -> Self {
    self.attributedTitle = attributedTitle
    return self
  }
}

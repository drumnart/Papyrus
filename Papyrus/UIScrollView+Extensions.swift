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

// MARK: - `UIScrollView` + PullToRefresh
extension ScrollView {
  
  public typealias PullToRefreshCallback = (_ sender: UIRefreshControl) -> ()
  
  fileprivate struct AssociatedKey {
    static var pullToRefresh = "pullToRefreshKey"
  }
  
  /// Another name for `refreshControl`
  public var refreshView: UIRefreshControl? {
    return _refreshControl
  }
  
  /// Refresh Status
  public var isRefreshing: Bool {
    return _refreshControl?.isRefreshing ?? false
  }
  
  /// Can be used to add and cofigure custom refreshControl if needed.
  @discardableResult public func setupRefreshControl(_ closure: () -> UIRefreshControl) -> Self {
    let refreshControl = closure()
    refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    if #available(iOS 10.0, *) {
      self.refreshControl = refreshControl
    } else {
      addSubview(refreshControl)
    }
    return self
  }
  
  /// Used to add and cofigure refreshControl (just another way using @autoclosure).
  @discardableResult public func addRefreshControl(_ closure: @autoclosure () -> UIRefreshControl) -> Self {
    return setupRefreshControl(closure)
  }
  
  /// Used for handling PullToRefresh action. Creates instance of UIRefreshControl if it doesn't already exist.
  @discardableResult public func onPullToRefresh(_ closure: @escaping PullToRefreshCallback) -> Self {
    if _refreshControl == nil { addRefreshControl(UIRefreshControl()) }
    pullToRefreshCallback = closure
    return self
  }
  
  /// Starts animating `refreshControl`
  public func beginRefreshing() {
    _refreshControl?.beginRefreshing()
  }
  
  /// Stops animating `refreshControl`
  public func endRefreshing() {
    _refreshControl?.endRefreshing()
  }
  
  private var pullToRefreshCallback: PullToRefreshCallback {
    get { return AObj.get(self, key: &AssociatedKey.pullToRefresh) { return { _ in } } }
    set { AObj.set(self, key: &AssociatedKey.pullToRefresh, value: newValue) }
  }
  
  @objc private func pullToRefresh(_ sender: UIRefreshControl) {
    pullToRefreshCallback(sender)
  }
  
  private var _refreshControl: UIRefreshControl? {
    if #available(iOS 10.0, *) {
      return refreshControl
    } else {
      return subviews.filter { $0 is UIRefreshControl }.first as? UIRefreshControl
    }
  }
}

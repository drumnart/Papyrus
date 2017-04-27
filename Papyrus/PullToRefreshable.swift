//
//  PullToRefreshable.swift
//  Papyrus
//
//  Created by Sergey Gorin on 27.04.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

import Foundation

public protocol PullToRefreshable {
  associatedtype RefreshControlOwner
  var refreshControlOwner: RefreshControlOwner { get }
}

// MARK: - `UIScrollView` + PullToRefresh
extension PullToRefreshable where RefreshControlOwner: ScrollView {
  
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
    refreshControl.addTarget(self, action: #selector(refreshControlOwner.pullToRefresh(_:)), for: .valueChanged)
    if #available(iOS 10.0, *) {
      refreshControlOwner.refreshControl = refreshControl
    } else {
      refreshControlOwner.addSubview(refreshControl)
    }
    return self
  }
  
  /// Used to add and cofigure refreshControl (just another way using @autoclosure).
  @discardableResult public func addRefreshControl(_ closure: @autoclosure () -> UIRefreshControl) -> Self {
    return setupRefreshControl(closure)
  }
  
  /// Used for handling PullToRefresh action. Creates instance of UIRefreshControl if it doesn't already exist.
  @discardableResult public func onPullToRefresh(_ closure: @escaping ScrollView.PullToRefreshCallback) -> Self {
    if _refreshControl == nil { addRefreshControl(UIRefreshControl()) }
    refreshControlOwner.pullToRefreshCallback = closure
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
  
  private var _refreshControl: UIRefreshControl? {
    if #available(iOS 10.0, *) {
      return refreshControlOwner.refreshControl
    } else {
      return refreshControlOwner.subviews.filter { $0 is UIRefreshControl }.first as? UIRefreshControl
    }
  }
}

extension ScrollView: PullToRefreshable {
  
  public var refreshControlOwner: ScrollView { return self }
  
  fileprivate struct AssociatedKey {
    static var pullToRefresh = "pullToRefreshKey"
  }
  
  public typealias PullToRefreshCallback = (_ sender: UIRefreshControl) -> ()
  
  @objc fileprivate func pullToRefresh(_ sender: UIRefreshControl) {
    pullToRefreshCallback(sender)
  }
  
  fileprivate var pullToRefreshCallback: PullToRefreshCallback {
    get { return AObj.get(self, key: &AssociatedKey.pullToRefresh) { return { _ in } } }
    set { AObj.set(self, key: &AssociatedKey.pullToRefresh, value: newValue) }
  }
}

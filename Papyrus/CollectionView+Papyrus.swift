//
//  SequentialCollection .swift
//  Papyrus
//
//  Created by Sergey Gorin on 30.03.17.
//  Copyright © 2017 Drumnart. All rights reserved.
//

public enum CollectionDataSource {
  case embeded
  case custom(UICollectionViewDataSource)
}

public enum CollectionDelegate {
  case embeded
  case custom(UICollectionViewDelegate)
}

fileprivate struct AssociatedKey {
  static var proxy = "proxyKey"
}

extension Papyrus where BaseType: CollectionView {
  
  public typealias NumberOfSectionsRetriever = (
    _ collectionView: UICollectionView) -> Int
  
  public typealias NumberOfItemsRetriever = (
    _ collectionView: UICollectionView,
    _ section: Int) -> Int
  
  public typealias CellRetriever = (
    _ collectionView: UICollectionView,
    _ indexPath: IndexPath) -> UICollectionViewCell
  
  public typealias ReusableViewRetriever = (
    _ collectionView: UICollectionView,
    _ kind: BaseType.SectionElementKind,
    _ indexPath: IndexPath) -> UICollectionReusableView
  
  public typealias WillDisplayCellHandler = (
    _ collectionView: UICollectionView,
    _ cell: UICollectionViewCell,
    _ indexPath: IndexPath) -> Void
  
  public typealias DidEndDisplayingCellHandler = (
    _ collectionView: UICollectionView,
    _ cell: UICollectionViewCell,
    _ indexPath: IndexPath) -> Void
  
  public typealias SelectionHandler = (
    _ collectionView: UICollectionView,
    _ indexPath: IndexPath) -> Void
  
  public typealias ItemSizeRetriever = (
    _ collectionView: UICollectionView,
    _ collectionViewLayout: UICollectionViewFlowLayout,
    _ indexPath: IndexPath) -> CGSize
  
  public typealias SectionInsetsRetriever = (
    _ collectionView: UICollectionView,
    _ collectionViewLayout: UICollectionViewFlowLayout,
    _ section: Int) -> UIEdgeInsets
  
  public typealias SpacingRetriever = (
    _ collectionView: UICollectionView,
    _ collectionViewLayout: UICollectionViewFlowLayout,
    _ section: Int) -> CGFloat
  
  public typealias ReusableViewSizeRetriever = (
    _ collectionView: UICollectionView,
    _ collectionViewLayout: UICollectionViewFlowLayout,
    _ section: Int) -> CGSize
  
  public typealias CommonScrollHandler = (
    _ scrollView: UIScrollView) -> Void
  
  public typealias WillEndDraggingHandler = (
    _ scrollView: UIScrollView,
    _ velocity: CGPoint,
    _ targetContentOffset: UnsafeMutablePointer<CGPoint>) -> Void
  
  public typealias DidEndDraggingHandler = (
    _ scrollView: UIScrollView,
    _ decelerate: Bool) -> Void
  
  fileprivate var proxy: Proxy {
    get {
      return AObj.get(base, key: &AssociatedKey.proxy) { return Proxy(CollectionViewHooksHolder()) }
    }
    set { AObj.set(base, key: &AssociatedKey.proxy, value: newValue) }
  }
  
  public var hooksHolder: CollectionViewHooksHolder {
    return proxy.hooksHolder
  }
  
  /// Associates collection's datasource calls with corresponding clossures or uses external dataSource, instead
  @discardableResult public func setDataSource(_ dataSource: CollectionDataSource) -> Self {
    switch dataSource {
    case .embeded: base.dataSource = proxy
    case .custom(let value): base.dataSource = value
    }
    return self
  }
  
  /// Associates collection's delegate calls with corresponding clossures or uses external delegate, instead
  @discardableResult public func setDelegate(_ delegate: CollectionDelegate) -> Self {
    switch delegate {
    case .embeded: base.delegate = proxy
    case .custom(let value): base.delegate = value
    }
    return self
  }
  
  @discardableResult public func retrieveNumberOfSections(_ retriever: @escaping NumberOfSectionsRetriever) -> Self {
    hooksHolder.numberOfSectionsRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveNumberOfItems(_ retriever: @escaping NumberOfItemsRetriever) -> Self {
    hooksHolder.numberOfItemsRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveCell(_ retriever: @escaping CellRetriever) -> Self {
    hooksHolder.cellRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveReusableView(_ retriever: @escaping ReusableViewRetriever) -> Self {
    hooksHolder.reusableViewRetriever = retriever
    return self
  }
  
  @discardableResult public func onWillDisplayCell(_ handler: @escaping WillDisplayCellHandler) -> Self {
    hooksHolder.willDisplayCellHandler = handler
    return self
  }
  
  @discardableResult public func onDidEndDisplayingCell(_ handler: @escaping DidEndDisplayingCellHandler) -> Self {
    hooksHolder.didEndDisplayingCellHandler = handler
    return self
  }
  
  @discardableResult public func onDidSelectItem(_ handler: @escaping SelectionHandler) -> Self {
    hooksHolder.selectionHandler = handler
    return self
  }
  
  @discardableResult public func retrieveItemSize(_ retriever: @escaping ItemSizeRetriever) -> Self {
    hooksHolder.itemSizeRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveLineSpacing(_ retriever: @escaping SpacingRetriever) -> Self {
    hooksHolder.lineSpacingRetiever = retriever
    return self
  }
  
  @discardableResult public func retrieveInteritemSpacing(_ retriever: @escaping SpacingRetriever) -> Self {
    hooksHolder.interitemSpacingRetiever = retriever
    return self
  }
  
  @discardableResult public func retrieveSectionInsets(_ retriever: @escaping SectionInsetsRetriever) -> Self {
    hooksHolder.sectionInsetsRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveSectionHeaderSize(_ retriever: @escaping ReusableViewSizeRetriever) -> Self {
    hooksHolder.sectionHeaderSizeRetriever = retriever
    return self
  }
  
  @discardableResult public func retrieveSectionFooterSize(_ retriever: @escaping ReusableViewSizeRetriever) -> Self {
    hooksHolder.sectionFooterSizeRetriever = retriever
    return self
  }
  
  @discardableResult public func onWillEndDragging(_ handler: WillEndDraggingHandler?) -> Self {
    hooksHolder.willEndDraggingHandler = handler
    return self
  }
  
  @discardableResult public func onWillBeginDragging(_ handler: CommonScrollHandler?) -> Self {
    hooksHolder.willBeginDraggingHandler = handler
    return self
  }
  
  @discardableResult public func onDidEndDragging(_ handler: DidEndDraggingHandler?) -> Self {
    hooksHolder.didEndDraggingHandler = handler
    return self
  }
  
  @discardableResult public func onDidScroll(_ handler: CommonScrollHandler?) -> Self {
    hooksHolder.didScrollHandler = handler
    return self
  }
  
  @discardableResult public func onDidEndDecelerating(_ handler: CommonScrollHandler?) -> Self {
    hooksHolder.didEndDeceleratingHandler = handler
    return self
  }
  
  @discardableResult public func onDidEndScrollingAnimation(_ handler: CommonScrollHandler?) -> Self {
    hooksHolder.didEndScrollingAnimationHandler = handler
    return self
  }
}

/// Container of callbacks to configure different aspects of collection view
public class CollectionViewHooksHolder {
  fileprivate(set) lazy var numberOfSectionsRetriever: Papyrus.NumberOfSectionsRetriever = { _ in return 1 }
  fileprivate(set) lazy var numberOfItemsRetriever: Papyrus.NumberOfItemsRetriever = { _,_  in return 1 }
  fileprivate(set) lazy var cellRetriever: Papyrus.CellRetriever = { _,_  in return UICollectionViewCell() }
  fileprivate(set) lazy var reusableViewRetriever: Papyrus.ReusableViewRetriever = { _,_,_  in return UICollectionReusableView() }
  
  fileprivate(set) lazy var willDisplayCellHandler: Papyrus.WillDisplayCellHandler = { _,_,_  in }
  fileprivate(set) lazy var didEndDisplayingCellHandler: Papyrus.DidEndDisplayingCellHandler = { _,_,_  in }
  fileprivate(set) lazy var selectionHandler: Papyrus.SelectionHandler = { _,_  in }
  
  fileprivate(set) lazy var itemSizeRetriever: Papyrus.ItemSizeRetriever = { (_, layout, _) in return layout.itemSize }
  fileprivate(set) lazy var sectionInsetsRetriever: Papyrus.SectionInsetsRetriever = { (_, layout, _) in return layout.sectionInset }
  fileprivate(set) lazy var lineSpacingRetiever: Papyrus.SpacingRetriever = { (_, layout, _) in return layout.minimumLineSpacing }
  fileprivate(set) lazy var interitemSpacingRetiever: Papyrus.SpacingRetriever = { (_, layout, _) in return layout.minimumInteritemSpacing }
  fileprivate(set) lazy var sectionHeaderSizeRetriever: Papyrus.ReusableViewSizeRetriever = { (_, layout, _) in return layout.headerReferenceSize }
  fileprivate(set) lazy var sectionFooterSizeRetriever: Papyrus.ReusableViewSizeRetriever = { (_, layout, _) in return layout.footerReferenceSize }
  
  fileprivate(set) lazy var willBeginDraggingHandler: Papyrus.CommonScrollHandler? = nil
  fileprivate(set) lazy var willEndDraggingHandler: Papyrus.WillEndDraggingHandler? = nil
  fileprivate(set) lazy var didEndDraggingHandler: Papyrus.DidEndDraggingHandler? = nil
  fileprivate(set) lazy var didScrollHandler: Papyrus.CommonScrollHandler? = nil
  fileprivate(set) lazy var didEndDeceleratingHandler: Papyrus.CommonScrollHandler? = nil
  fileprivate(set) lazy var didEndScrollingAnimationHandler: Papyrus.CommonScrollHandler? = nil
}

/// `Proxy` traps calls as `UICollectionViewDataSource`, `UICollectionViewDelegate` and `UIScrollViewDelegate` and
/// interconnects them with callbacks retained by instance of `CollectionViewHooksHolder`.
fileprivate class Proxy: NSObject {
  fileprivate let hooksHolder: CollectionViewHooksHolder
  
  init(_ hooksHolder: CollectionViewHooksHolder) {
    self.hooksHolder = hooksHolder
  }
}

// MARK: - UICollectionViewDataSource
extension Proxy: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return hooksHolder.numberOfSectionsRetriever(collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return hooksHolder.numberOfItemsRetriever(collectionView, section)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return hooksHolder.cellRetriever(collectionView, indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    return hooksHolder.reusableViewRetriever(collectionView, UICollectionView.SectionElementKind(kind), indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension Proxy: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    hooksHolder.willDisplayCellHandler(collectionView, cell, indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    hooksHolder.didEndDisplayingCellHandler(collectionView, cell, indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    hooksHolder.selectionHandler(collectionView, indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    return hooksHolder.itemSizeRetriever(collectionView, flowLayout, indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    return hooksHolder.sectionInsetsRetriever(collectionView, flowLayout, section)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      referenceSizeForHeaderInSection section: Int) -> CGSize {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    return hooksHolder.sectionHeaderSizeRetriever(collectionView, flowLayout, section)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
    return hooksHolder.sectionFooterSizeRetriever(collectionView, flowLayout, section)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
    return hooksHolder.lineSpacingRetiever(collectionView, flowLayout, section)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
    return hooksHolder.interitemSpacingRetiever(collectionView, flowLayout, section)
  }
}

// MARK: - UIScrollViewDelegate
extension Proxy: UIScrollViewDelegate {
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    hooksHolder.willBeginDraggingHandler?(scrollView)
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint,
                                 targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    hooksHolder.willEndDraggingHandler?(scrollView, velocity, targetContentOffset)
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    hooksHolder.didEndDraggingHandler?(scrollView, decelerate)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    hooksHolder.didScrollHandler?(scrollView)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    hooksHolder.didEndDeceleratingHandler?(scrollView)
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    hooksHolder.didEndScrollingAnimationHandler?(scrollView)
  }
}

// MARK: - CollectionView + Helper methods
extension Papyrus where BaseType: CollectionView {
  
  @discardableResult public func reloadData() -> Self {
    base.reloadData()
    return self
  }
  
  @discardableResult public func setBackgroundView(_ backgroundView: UIView?) -> Self {
    base.backgroundView = backgroundView
    return self
  }
}

/// Next group of methods have effect only if layout is `UICollectionViewFlowLayout`
extension Papyrus where BaseType: CollectionView {
  
  @discardableResult public func setScrollDirection(_ direction: UICollectionViewScrollDirection) -> Self {
    base.flowLayout?.scrollDirection = direction
    return self
  }
  
  @discardableResult public func setItemSize(_ itemSize: CGSize) -> Self {
    base.flowLayout?.itemSize = itemSize
    return self
  }
  
  @discardableResult public func setEstimatedItemSize(_ estimatedItemSize: CGSize) -> Self {
    base.flowLayout?.estimatedItemSize = estimatedItemSize
    return self
  }
  
  @discardableResult public func setMinInteritemSpacing(_ spacing: CGFloat) -> Self {
    base.flowLayout?.minimumInteritemSpacing = spacing
    return self
  }
  
  @discardableResult public func setMinLineSpacing(_ spacing: CGFloat) -> Self {
    base.flowLayout?.minimumLineSpacing = spacing
    return self
  }
  
  @discardableResult public func setHeaderReferenceSize(_ size: CGSize) -> Self {
    base.flowLayout?.headerReferenceSize = size
    return self
  }
  
  @discardableResult public func setFooterReferenceSize(_ size: CGSize) -> Self {
    base.flowLayout?.footerReferenceSize = size
    return self
  }
}

//
//  SequentialCollection .swift
//  Papyrus
//
//  Created by Sergey Gorin on 30.03.17.
//  Copyright © 2017 ToBox. All rights reserved.
//

public enum CollectionDataSource {
  case embeded
  case custom(UICollectionViewDataSource)
}

public enum CollectionDelegate {
  case embeded
  case custom(UICollectionViewDelegate)
}

public protocol SequentialCollection {
  
  associatedtype OwnerType
  
  @discardableResult func setDataSource(_ dataSource: CollectionDataSource) -> OwnerType
  @discardableResult func setDelegate(_ delegate: CollectionDelegate) -> OwnerType
  @discardableResult func retrieveNumberOfSections(_ retriever: NumberOfSectionsRetriever) -> OwnerType
  @discardableResult func retrieveNumberOfItems(_ retriever: NumberOfItemsRetriever) -> OwnerType
  @discardableResult func retrieveCell(_ retriever: CellRetriever) -> OwnerType
  @discardableResult func retrieveReusableView(_ retiever: ReusableViewRetriever) -> OwnerType
  @discardableResult func onDidSelectItem(_ handler: SelectionHandler) -> OwnerType
  
  @discardableResult func retrieveItemSize(_ retriever: ItemSizeRetriever) -> OwnerType
  @discardableResult func retrieveLineSpacing(_ retriever: SpacingRetriever) -> OwnerType
  @discardableResult func retrieveInteritemSpacing(_ retriever: SpacingRetriever) -> OwnerType
  @discardableResult func retrieveSectionInsets(_ retriever: SectionInsetsRetriever) -> OwnerType
  @discardableResult func retrieveSectionHeaderSize(_ retriever: ReusableViewSizeRetriever) -> OwnerType
  @discardableResult func retrieveSectionFooterSize(_ retriever: ReusableViewSizeRetriever) -> OwnerType
  
  @discardableResult func onDidEndDragging(_ handler: DidEndDraggingHandler?) -> OwnerType
  @discardableResult func onDidScroll(_ handler: CommonScrollHandler?) -> OwnerType
  @discardableResult func onDidEndDecelerating(_ handler: CommonScrollHandler?) -> OwnerType
}

fileprivate struct AssociatedKey {
  static var proxy = "proxyKey"
}

extension SequentialCollection where Self: UICollectionView {
  
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
    _ kind: SectionElementKind,
    _ indexPath: IndexPath) -> UICollectionReusableView
  
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
  
  public typealias DidEndDraggingHandler = (
    _ scrollView: UIScrollView,
    _ decelerate: Bool) -> Void
  
  fileprivate var proxy: Proxy {
    get {
      return AObj.get(self, key: &AssociatedKey.proxy) { return Proxy(CollectionViewHooksHolder()) }
    }
    set { AObj.set(self, key: &AssociatedKey.proxy, value: newValue) }
  }
  
  public var hooksHolder: CollectionViewHooksHolder {
    return proxy.hooksHolder
  }
  
  /// Associates collection's datasource calls with corresponding clossures or uses external dataSource, instead
  @discardableResult public func setDataSource(_ dataSource: CollectionDataSource) -> Self {
    switch dataSource {
    case .embeded: self.dataSource = proxy
    case .custom(let value): self.dataSource = value
    }
    return self
  }
  
  /// Associates collection's delegate calls with corresponding clossures or uses external delegate, instead
  @discardableResult public func setDelegate(_ delegate: CollectionDelegate) -> Self {
    switch delegate {
    case .embeded: self.delegate = proxy
    case .custom(let value): self.delegate = value
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
}

/// Container of callbacks to configure different aspects of collection view
public class CollectionViewHooksHolder {
  fileprivate(set) lazy var numberOfSectionsRetriever: SequentialCollection.NumberOfSectionsRetriever = { _ in return 1 }
  fileprivate(set) lazy var numberOfItemsRetriever: SequentialCollection.NumberOfItemsRetriever = { _ in return 1 }
  fileprivate(set) lazy var cellRetriever: SequentialCollection.CellRetriever = { _ in return UICollectionViewCell() }
  fileprivate(set) lazy var reusableViewRetriever: SequentialCollection.ReusableViewRetriever = { _ in return UICollectionReusableView() }
  fileprivate(set) lazy var selectionHandler: SequentialCollection.SelectionHandler = { _ in }
  
  fileprivate(set) lazy var itemSizeRetriever: SequentialCollection.ItemSizeRetriever = { (_, layout, _) in return layout.itemSize }
  fileprivate(set) lazy var sectionInsetsRetriever: SequentialCollection.SectionInsetsRetriever = { (_, layout, _) in return layout.sectionInset }
  fileprivate(set) lazy var lineSpacingRetiever: SequentialCollection.SpacingRetriever = { (_, layout, _) in return layout.minimumLineSpacing }
  fileprivate(set) lazy var interitemSpacingRetiever: SequentialCollection.SpacingRetriever = { (_, layout, _) in return layout.minimumInteritemSpacing }
  fileprivate(set) lazy var sectionHeaderSizeRetriever: SequentialCollection.ReusableViewSizeRetriever = { (_, layout, _) in return layout.headerReferenceSize }
  fileprivate(set) lazy var sectionFooterSizeRetriever: SequentialCollection.ReusableViewSizeRetriever = { (_, layout, _) in return layout.footerReferenceSize }
  
  fileprivate(set) lazy var didEndDraggingHandler: SequentialCollection.DidEndDraggingHandler? = nil
  fileprivate(set) lazy var didScrollHandler: SequentialCollection.CommonScrollHandler? = nil
  fileprivate(set) lazy var didEndDeceleratingHandler: SequentialCollection.CommonScrollHandler? = nil
}

/// `Proxy` traps calls as `UICollectionViewDataSource`, `UICollectionViewDelegate` and `UIScrollViewDelegate` and
/// interconnects them with callbacks retained by instance of `CollectionViewHooksHolder`.
fileprivate class Proxy: NSObject {
  fileprivate var hooksHolder: CollectionViewHooksHolder
  
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
    return hooksHolder.reusableViewRetriever(collectionView, SectionElementKind(kind), indexPath)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension Proxy: UICollectionViewDelegateFlowLayout {
  
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
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    hooksHolder.didEndDraggingHandler?(scrollView, decelerate)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    hooksHolder.didScrollHandler?(scrollView)
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    hooksHolder.didEndDeceleratingHandler?(scrollView)
  }
}

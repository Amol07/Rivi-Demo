//
//  UIView+Ext.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit
import Foundation

protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

public protocol NibLoadable: class {
    static var nib: UINib { get }
}

public extension NibLoadable {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

extension UITableView {
    
    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UITableViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(headerFooterViewType.nib, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    final func register<T: UITableViewHeaderFooterView>(headerFooterViewType: T.Type)
        where T: Reusable {
            self.register(headerFooterViewType.self, forHeaderFooterViewReuseIdentifier: headerFooterViewType.reuseIdentifier)
    }
    
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type = T.self) -> T?
        where T: Reusable {
            guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
                fatalError(
                    "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the header/footer beforehand"
                )
            }
            return view
    }
}

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable & NibLoadable {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T: Reusable {
            self.register(cellType.self, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            let bareCell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath)
            guard let cell = bareCell as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable & NibLoadable {
            self.register(
                supplementaryViewType.nib,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String)
        where T: Reusable {
            self.register(
                supplementaryViewType.self,
                forSupplementaryViewOfKind: elementKind,
                withReuseIdentifier: supplementaryViewType.reuseIdentifier
            )
    }
    
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>
        (ofKind elementKind: String, for indexPath: IndexPath, viewType: T.Type = T.self) -> T
        where T: Reusable {
            let view = self.dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: viewType.reuseIdentifier,
                for: indexPath
            )
            guard let typedView = view as? T else {
                fatalError(
                    "Failed to dequeue a supplementary view with identifier \(viewType.reuseIdentifier) "
                        + "matching type \(viewType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the supplementary view beforehand"
                )
            }
            return typedView
    }
}

extension UIApplication {
    var statusBarOrientation: UIInterfaceOrientation? {
        get {
            guard let orientation = self.windows.first?.windowScene?.interfaceOrientation else {
                return nil
            }
            return orientation
        }
    }
}

typealias UIAlertControllerHandler = ( _ alertController: UIAlertController, _ selectedIndex: Int ) -> Void

extension UIViewController {
    func showAlert(title: String, message: String, buttonTitles: [String] = ["OK"], handler: UIAlertControllerHandler?) {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let actionHandler = { action  -> Void in
            handler?( controller, controller.actions.firstIndex(of: action ) ?? -1 )
        }
        for title in buttonTitles[ 0..<buttonTitles.count ] {
            controller.addAction( UIAlertAction( title: title, style: .default, handler: actionHandler))
        }
        self.present(controller, animated: true, completion: nil)
    }
}

import SDWebImage
extension UIImageView {
    
    static var placeHolderImage: UIImage = #imageLiteral(resourceName: "Placeholder")
    
    func setImage(with url: String?, placeHolder: UIImage? = nil, completed: (() -> Void)? = nil) {
        if let urlString = url {
            self.sd_setImage(with: URL(string: urlString), placeholderImage: placeHolder) { (_, _, _, _) in
                completed?()
            }
        } else {
            self.image = placeHolder
        }
    }
}

extension NSAttributedString {

    var trailingNewlineChopped: NSAttributedString {
        if string.hasSuffix("\n") {
            return self.attributedSubstring(from: NSRange(location: 0, length: length - 1))
        } else {
            return self
        }
    }
}

func getAttributedString(fromStringList stringList: [String],
                         font: UIFont,
                         bullet: String = "\u{2022}",
                         indentation: CGFloat = 10,
                         lineSpacing: CGFloat = 1,
                         paragraphSpacing: CGFloat = 0,
                         textColor: UIColor = .gray,
                         bulletColor: UIColor = .black) -> NSAttributedString {
    
    let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: textColor]
    let bulletAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: bulletColor]
    
    let paragraphStyle = NSMutableParagraphStyle()
    let nonOptions = [NSTextTab.OptionKey: Any]()
    paragraphStyle.tabStops = [
        NSTextTab(textAlignment: .left, location: indentation, options: nonOptions)]
    paragraphStyle.defaultTabInterval = indentation
    paragraphStyle.lineSpacing = lineSpacing
    paragraphStyle.paragraphSpacing = paragraphSpacing
    paragraphStyle.headIndent = indentation
    
    let bulletList = NSMutableAttributedString()
    for (num, string) in stringList.enumerated() {
        let formattedString = "\(num+1)\t\(string)\n"
        let attributedString = NSMutableAttributedString(string: formattedString)
        
        attributedString.addAttributes(
            [NSAttributedString.Key.paragraphStyle : paragraphStyle],
            range: NSMakeRange(0, attributedString.length))
        
        attributedString.addAttributes(
            textAttributes,
            range: NSMakeRange(0, attributedString.length))
        
        let string: NSString = NSString(string: formattedString)
        let rangeForBullet: NSRange = string.range(of: "\(num+1)")
        attributedString.addAttributes(bulletAttributes, range: rangeForBullet)
        bulletList.append(attributedString)
    }
    return bulletList.trailingNewlineChopped
}

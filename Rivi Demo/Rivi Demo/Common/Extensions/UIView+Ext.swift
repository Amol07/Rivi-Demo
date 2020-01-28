//
//  UIView+Ext.swift
//  Rivi Demo
//
//  Created by Amol Prakash on 28/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import UIKit

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

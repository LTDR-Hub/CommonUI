//
//  Layout.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

public protocol Layoutable {
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    
    var heightAnchor: NSLayoutDimension { get }
    var widthAnchor: NSLayoutDimension { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Layoutable {}
extension UILayoutGuide: Layoutable {}

//
//  Configure.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

public protocol Configurable {}

public extension Configurable where Self: UIView {

    func configureView() -> Self {
        configure { _ in }
    }
    
    func configure(_ configuration: (Self) -> Void) -> Self {
        
        configuration(self)
        return self
    }
    
    func configureView(_ configuration: (Self) -> Void) -> Self {
        
        translatesAutoresizingMaskIntoConstraints = false
        configuration(self)
        
        return self
    }
}

extension UIView: Configurable {}

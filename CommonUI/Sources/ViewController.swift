//
//  ViewController.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

open class ViewController<T: View>: UIViewController {

    public var contentView: T {
        
        view as! T
    }
    
    public init() {

        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    override open func loadView() {

        view = T()
    }
}

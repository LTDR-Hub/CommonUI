//
//  View.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

open class View: UIView {

    // MARK: - Lifecycle

    public required init() {
        super.init(frame: .zero)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open override func updateConstraints() {
        if needsDefineLayout {
            needsDefineLayout = false
            defineLayout()
        }
        super.updateConstraints()
    }

    open func setup() { }
    open func defineLayout() {}

    // MARK: - Private
    
    private var needsDefineLayout = true
}

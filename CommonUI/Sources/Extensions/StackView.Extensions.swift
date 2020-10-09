//
//  StackView.Extensions.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

public func stackView(_ axis: NSLayoutConstraint.Axis,
                      spacing: CGFloat = 0,
                      distribution: UIStackView.Distribution = .fill,
                      alignment: UIStackView.Alignment = .fill) -> (UIView...) -> UIStackView {
    
    { (views: UIView...) -> UIStackView in
        
        createStackView(
            axis,
            spacing: spacing,
            distribution: distribution,
            alignment: alignment,
            subviews: views
        )
    }
}

public func stackView(_ axis: NSLayoutConstraint.Axis,
                      spacing: CGFloat = 0,
                      distribution: UIStackView.Distribution = .fill,
                      alignment: UIStackView.Alignment = .fill) -> ([UIView]) -> UIStackView {
    
    { (views: [UIView]) -> UIStackView in
        
        createStackView(
            axis,
            spacing: spacing,
            distribution: distribution,
            alignment: alignment,
            subviews: views
        )
    }
}

private func createStackView(_ axis: NSLayoutConstraint.Axis,
                             spacing: CGFloat = 0,
                             distribution: UIStackView.Distribution = .fill,
                             alignment: UIStackView.Alignment = .fill,
                             subviews: [UIView]) -> UIStackView {
    
    let stack = UIStackView(arrangedSubviews: subviews)
    
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = axis
    stack.spacing = spacing
    stack.distribution = distribution
    stack.alignment = alignment
    
    return stack
}

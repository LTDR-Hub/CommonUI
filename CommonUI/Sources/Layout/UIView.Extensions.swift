//
//  NSLayoutConstraints.Extensions.swift
//  CommonUI
//
//  Created by Yurii Dukhovnyi on 09.10.2020.
//

import UIKit

public extension UIView {
    
    struct Edge: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let leading = Edge(rawValue: 1 << 0)
        public static let trailing = Edge(rawValue: 1 << 1)
        public static let top = Edge(rawValue: 1 << 2)
        public static let bottom = Edge(rawValue: 1 << 3)
        
        public static let greaterThanLeading = Edge(rawValue: 1 << 4)
        public static let lessThanTrailing = Edge(rawValue: 1 << 5)
        public static let greaterThanTop = Edge(rawValue: 1 << 6)
        public static let lessThanBottom = Edge(rawValue: 1 << 7)
        
        public static let horizontal: Edge = [.leading, .trailing]
        public static let vertical: Edge = [.top, .bottom]
        public static let all: Edge = [.horizontal, .vertical]
    }
    
    struct Dimension: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let width = Dimension(rawValue: 1 << 0)
        public static let height = Dimension(rawValue: 1 << 1)
        
        public static let all: Dimension = [.width, .height]
    }
    
    struct Align: OptionSet {
        
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let horizontal = Align(rawValue: 1 << 0)
        public static let vertical = Align(rawValue: 1 << 1)
        public static let center: Align = [.horizontal, .vertical]
    }
    
    func layoutInCenterSuperview(edges: Align = .center,
                                 xOffset: CGFloat = 0.0,
                                 yOffset: CGFloat = 0.0) -> [NSLayoutConstraint] {
        
        guard let superview = superview else {
            assertionFailure("Can't layout view due to it is not added to any view hierarcy.")
            return []
        }
        
        return layoutInCenter(superview, edges: edges, xOffset: xOffset, yOffset: yOffset)
    }
    
    func layoutInCenter(_ guide: Layoutable,
                        edges: Align = .center,
                        xOffset: CGFloat = 0.0,
                        yOffset: CGFloat = 0.0) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        if edges.contains(.horizontal) {
            constraints += centerXAnchor.constraint(equalTo: guide.centerXAnchor, constant: xOffset)
        }
        
        if edges.contains(.vertical) {
            constraints += centerYAnchor.constraint(equalTo: guide.centerYAnchor, constant: yOffset)
        }
        
        return constraints
    }
    
    func layoutInSuperview(edges: Edge = .all,
                           insets: UIEdgeInsets = .zero,
                           priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        guard let superview = superview else {
            assertionFailure("Can't layout view due to it is not added to any view hierarcy.")
            return [NSLayoutConstraint]()
        }
        
        return layoutIn(superview, edges: edges, insets: insets, priority: priority)
    }
    
    func layoutIn(_ guide: Layoutable,
                  edges: Edge = .all,
                  insets: UIEdgeInsets = .zero,
                  priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        
        let directionalInsets = NSDirectionalEdgeInsets(
            top: insets.top,
            leading: insets.left,
            bottom: insets.bottom,
            trailing: insets.right
        )
        
        let (leading, trailing, top, bottom): (CGFloat, CGFloat, CGFloat, CGFloat) = (
            directionalInsets.leading,
            directionalInsets.trailing,
            directionalInsets.top,
            directionalInsets.bottom
        )
        
        var constraints = [NSLayoutConstraint]()
        
        if edges.contains(.leading) || edges.contains(.horizontal){
            constraints.append(
                leadingAnchor.constraint(
                    equalTo: guide.leadingAnchor,
                    constant: leading
                )
                .priority(priority)
                .identifier(.leading)
            )
        }
        
        if edges.contains(.top) || edges.contains(.vertical) {
            constraints.append(
                topAnchor.constraint(
                    equalTo: guide.topAnchor,
                    constant: top
                )
                .priority(priority)
                .identifier(.top)
            )
        }
        
        if edges.contains(.trailing) || edges.contains(.horizontal) {
            constraints.append(
                trailingAnchor.constraint(
                    equalTo: guide.trailingAnchor,
                    constant: trailing
                )
                .priority(priority)
                .identifier(.trailing)
            )
        }
        
        if edges.contains(.bottom) || edges.contains(.vertical) {
            
            constraints.append(
                bottomAnchor.constraint(
                    equalTo: guide.bottomAnchor,
                    constant: bottom
                )
                .priority(priority)
                .identifier(.bottom)
            )
        }
        
        if edges.contains(.greaterThanTop) {
            
            constraints.append(
                topAnchor.constraint(greaterThanOrEqualTo: guide.topAnchor)
                    .priority(priority)
                    .identifier(.greaterThanTop)
            )
        }
        
        if edges.contains(.lessThanBottom) {
            
            constraints.append(
                bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
                    .priority(priority)
                    .identifier(.lessThanBottom)
            )
        }
        
        return constraints
    }
    
    func match(_ dimension: Dimension = .all,
               value: CGFloat,
               priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        var constraints = [NSLayoutConstraint]()
        
        if dimension.contains(.height) {
            
            constraints += heightAnchor.constraint(equalToConstant: value)
                .priority(priority)
                .identifier(.height)
        }
        
        if dimension.contains(.width) {
            
            constraints += widthAnchor.constraint(equalToConstant: value)
                .priority(priority)
                .identifier(.width)
        }
        
        return constraints
    }
}

public extension Array where Element == NSLayoutConstraint {
    
    func activate() {
        
        NSLayoutConstraint.activate(self)
    }
    
    func deactivate() {
        
        NSLayoutConstraint.deactivate(self)
    }
    
    static func +=(destination: inout [NSLayoutConstraint],
                   newConstraint: NSLayoutConstraint) {
        
        destination.append(newConstraint)
    }
    
    func constraints(with id: NSLayoutConstraint.Identifier) -> [NSLayoutConstraint] {
        
        filter { $0.identifier == id.rawValue }
    }
}

extension NSLayoutConstraint {
    
    public enum Identifier: String {
        
        case leading, top, trailing, bottom, width, height, greaterThanTop, lessThanBottom
    }
    
    func priority(_ newValue: UILayoutPriority) -> Self {
        
        priority = newValue
        return self
    }
    
    func identifier(_ id: Identifier) -> Self {
        
        identifier = id.rawValue
        return self
    }
}

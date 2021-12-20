//
//  UIView+.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 17/12/21.
//

import UIKit
extension UIView {
    @discardableResult
    func alignAllCorners(_ edges: UIEdgeInsets? = nil) -> Self {
        let edges = edges.strong
        return fixLeft(edges.left)
            .fixRight(edges.right)
            .fixTop(edges.top)
            .fixBottom(edges.bottom)
    }
    @discardableResult
    func fixAtCenter() -> Self {
        return fixXCenter()
            .fixYCenter()
    }
    @discardableResult
    func clearConstraints() -> Self {
        if let toRemove = superview?.constraints.filter ( {($0.firstItem as? UIView) == self} ) {
            superview?.removeConstraints(toRemove)
        }
        if let toRemove = superview?.constraints.filter ( {($0.secondItem as? UIView) == self} ) {
            superview?.removeConstraints(toRemove)
        }
        removeConstraints(constraints)
        translatesAutoresizingMaskIntoConstraints = true
        return self
    }
    @discardableResult
    func fixXCenter(value: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: value).isActive = true
        return self
    }
    @discardableResult
    func fixYCenter(value: CGFloat = 0) -> Self {
        guard let superview = superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: value).isActive = true
        return self
    }
    @discardableResult
    func setHeight(_ value: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    @discardableResult
    func setWidth(_ value: CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    @discardableResult
    func fixLeft(to view: UIView? = nil, _ value: CGFloat) -> Self {
        guard let view = view ?? superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: value).isActive = true
        return self
    }
    @discardableResult
    func fixRight(to view: UIView? = nil, _ value: CGFloat) -> Self {
        guard let view = view ?? superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: value).isActive = true
        return self
    }
    @discardableResult
    func fixBottom(to view: UIView? = nil, _ value: CGFloat, _ priority: UILayoutPriority = .defaultHigh) -> Self {
        guard let view = view ?? superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        let constraimt = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: value)
        constraimt.priority = priority
        constraimt.isActive = true
        return self
    }
    @discardableResult
    func fixTop(to view: UIView? = nil, _ value: CGFloat) -> Self {
        guard let view = view ?? superview else {
            return self
        }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor, constant: value).isActive = true
        return self
    }
    func addShadow(
        ofColor color: UIColor = UIColor.lightGray,
        radius: CGFloat = 6,
        offset: CGSize = .zero,
        opacity: Float = 0.5) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        
        layer.masksToBounds = false
    }
    
    func round(size: CGSize? = nil, corners: UIRectCorner, radius: CGFloat) {
        let size = size ?? bounds.size
        let path = UIBezierPath(roundedRect: .init(origin: .zero, size: size), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

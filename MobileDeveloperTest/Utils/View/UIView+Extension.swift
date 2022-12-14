//
//  UIView+Extension.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit

extension UIView {
    // MARK: - Constraints

    func addAutoLayout(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }

    func addAllEdgesConstraint(to view: UIView, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
    }

    func addAllEdgesConstraint(to view: UIView, constant: (top: CGFloat, bottom: CGFloat, trailing: CGFloat, leading: CGFloat)) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant.bottom).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant.trailing).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant.leading).isActive = true
    }

    func aspectRatioConstraint(_ ratio: CGFloat = 1) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self,
                                  attribute: .height,
                                  relatedBy: .equal,
                                  toItem: self,
                                  attribute: .width,
                                  multiplier: ratio,
                                  constant: 0)
    }
}

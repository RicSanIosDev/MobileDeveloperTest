//
//  UIView+Style.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit

extension UIView {

  //MARK: - Rounded

  func rounded() {
      self.clipsToBounds = true
      DispatchQueue.main.async { self.layer.cornerRadius = self.frame.height/2 }
  }

  func rounded(radius: CGFloat) {
      self.clipsToBounds = true
      DispatchQueue.main.async { self.layer.cornerRadius = radius }
  }
}

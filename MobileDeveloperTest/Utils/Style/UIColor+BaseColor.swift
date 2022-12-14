//
//  UIColor+BaseColor.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit

// MARK: - Base
extension UIColor {

    struct Base {
        public static var primary: UIColor {
            return UIColor(red: 47/255, green: 107/255, blue: 46/255, alpha: 1)
        }

        public static var background: UIColor {
            return .white
        }
    }
}

// MARK: - NavBar
extension UIColor {

    struct NavBar {
        public static var background: UIColor {
            return .white
        }

        public static var items: UIColor {
            return .black
        }
    }
}

// MARK: - TabBar
extension UIColor {

    struct TabBar {
        public static var background: UIColor {
            return UIColor(red: 47/255, green: 107/255, blue: 46/255, alpha: 1)
        }

        public static var selectedItem: UIColor {
            return .white
        }
    }
}

// MARK: - Font
extension UIColor {

    struct Font {
        public static var primary: UIColor {
            return Base.primary
        }

        public static var secundary: UIColor {
            return .white
        }

        public static var description: UIColor {
            return .lightGray
        }
    }
}

//
//  App+Appearance.swift
//  MobileDeveloperTest
//
//  Created by Ricardo Sanchez on 7/9/22.
//

import UIKit

struct AppStyle {

    static func applyAppearance() {
        navigationAppearance()
    }

    static func navigationAppearance() {
        // UINavigationBar appearance
        let attributesTitles = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.NavBar.items
        UINavigationBar.appearance().isTranslucent = true

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.NavBar.background
        appearance.titleTextAttributes = attributesTitles
        appearance.largeTitleTextAttributes = attributesTitles

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
      }
}

//
//  CineNavigationController.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import Foundation
import UIKit

class CineNavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        self.setViewControllers([rootViewController], animated: true)
        navigationBarAppearance()
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    private func navigationBarAppearance() {
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.white,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = attribute
            appearance.shadowColor = .clear
            
            UINavigationBar.appearance().tintColor = .black
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
            return
        }
        
        let appearance = UINavigationBar.appearance()
        appearance.setBackgroundImage(UIImage(), for: .default)
        appearance.tintColor = .white
        appearance.barTintColor = .black
        appearance.titleTextAttributes = attribute
        appearance.shadowImage = UIImage()
        appearance.isTranslucent = false
        
    }
    
}

extension CineNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.extendedLayoutIncludesOpaqueBars = true
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: String(), style: .plain, target: nil, action: nil)
    }
    
}


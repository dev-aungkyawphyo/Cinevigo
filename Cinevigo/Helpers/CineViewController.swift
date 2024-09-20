//
//  CineViewController.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 18/09/2024.
//

import UIKit

class CineViewController: UIViewController, Storyboarded {

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
    }
    
    /// Start Loading ...
    func startLoading() {
        CineActivityIndicator.loading.showUniversalLoadingView(true)
    }
    
    /// Stop Loading ...
    func stopLoading() {
        CineActivityIndicator.loading.showUniversalLoadingView(false)
    }

}

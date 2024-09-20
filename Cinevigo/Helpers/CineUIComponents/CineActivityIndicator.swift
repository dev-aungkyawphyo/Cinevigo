//
//  CineActivityIndicator.swift
//  Cinevigo
//
//  Created by Aung Kyaw Phyo on 19/09/2024.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CineActivityIndicator {
    
    static let loading = CineActivityIndicator()
    
    func showUniversalLoadingView(_ show: Bool) {
        let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
        if show {
            if existingView != nil { return }
            let loadingView = self.makeLoadingView(withFrame: UIScreen.main.bounds)
            loadingView?.tag = 1200
            UIApplication.shared.windows[0].addSubview(loadingView!)
        } else {
            existingView?.removeFromSuperview()
        }
    }
    
    private func makeLoadingView(withFrame frame: CGRect) -> UIView? {
        let container: UIView = UIView(frame: frame)
        let loadingView: UIView = UIView()
        let activityIndicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        container.backgroundColor = .clear
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        loadingView.center = container.center
        loadingView.backgroundColor = .white.withAlphaComponent(0.4)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 12
        
        activityIndicator.color = UIColor(red: 16/255, green: 33/255, blue: 62/255, alpha: 1)
        activityIndicator.type = .ballRotateChase
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        activityIndicator.startAnimating()
        
        return container
    }
    
}

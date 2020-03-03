//
//  StatusBarColorUtils.swift
//  
//  Created by Will Taylor on 3/3/20.
//

import UIKit

internal class StatusBarColorUtils {
    internal static func setStatusBarBackgroundColor(on view: UIView, color: UIColor) {
        let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        view.addSubview(statusbarView)
        
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: view.topAnchor).isActive = true
        statusbarView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

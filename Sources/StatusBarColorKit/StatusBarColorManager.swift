//
//  StatusBarColorManager.swift
//
//  Created by Will Taylor on 3/3/20.
//

import Foundation
import Combine
import SwiftUI

public class StatusBarColorManager: UIHostingController<AnyView> {
    private var publishers: Set<AnyCancellable> = Set()
        
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return StatusBarColorManager.statusBarStyleSubject.value
    }
    
    public override init(rootView: AnyView) {
        super.init(rootView: rootView)
        
        let statusBarStylePublisher = StatusBarColorManager.statusBarStyleSubject.sink { style in
            self.setNeedsStatusBarAppearanceUpdate()
        }
        let statusBarBackgroundColorPublisher = StatusBarColorManager.statusBarBackgroundColorSubject.sink { backgroundColor in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                // Delay setting the color for just a moment to allow the view time to load.
                StatusBarColorUtils.setStatusBarBackgroundColor(on: self.view, color: backgroundColor)
            }
        }
        publishers.insert(statusBarStylePublisher)
        publishers.insert(statusBarBackgroundColorPublisher)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusBarColorManager {
    private static let statusBarStyleSubject: CurrentValueSubject<UIStatusBarStyle, Never> = CurrentValueSubject(.default)
    private static let statusBarBackgroundColorSubject: CurrentValueSubject<UIColor, Never> = CurrentValueSubject(UIColor.clear)
    
    /// The current status bar style of the application.
    public static var statusBarStyle: UIStatusBarStyle {
        get {
            return statusBarStyleSubject.value
        }
        set {
            statusBarStyleSubject.send(newValue)
        }
    }
    
    /// The color of the status bar's background.
    public static var statusBarBackgroundColor: UIColor {
        get {
            return statusBarBackgroundColorSubject.value
        }
        set {
            statusBarBackgroundColorSubject.send(newValue)
        }
    }
}

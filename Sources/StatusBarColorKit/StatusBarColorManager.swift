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
            StatusBarColorUtils.setStatusBarBackgroundColor(on: self.view, color: backgroundColor.uiColor)
        }
        publishers.insert(statusBarStylePublisher)
        publishers.insert(statusBarBackgroundColorPublisher)
        
//        // Initialize the status bar to have the color.
//        // We have to set this slightly after initialization since when this function is called, the status bar is not
//        // yet initialized.
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now(), execute: {
//            StatusBarColorUtils.setStatusBarBackgroundColor(on: self.view, color: backgroundColor.uiColor)
//        })
//        
//        // Run it again in half a second just in case it didn't work the first time.
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
//            self.onReceiveNewStatusBarBackgroundColor()
//        })
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusBarColorManager {
    private static let statusBarStyleSubject: CurrentValueSubject<UIStatusBarStyle, Never> = CurrentValueSubject(.default)
    private static let statusBarBackgroundColorSubject: CurrentValueSubject<Color, Never> = CurrentValueSubject(Color.clear)
    
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

//
//  ContentView.swift
//  StatusBarColorTest
//
//  Created by Will Taylor on 3/3/20.
//  Copyright © 2020 Will Taylor. All rights reserved.
//

import SwiftUI
import StatusBarColorKit

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var lightMode = false

    var body: some View {
        Text("Hello, World!")
        .onReceive(timer) { input in
            self.lightMode.toggle()
            
            if self.lightMode {
                StatusBarColorManager.statusBarBackgroundColor = .blue
                StatusBarColorManager.statusBarStyle = .lightContent
            } else {
                StatusBarColorManager.statusBarBackgroundColor = .cyan
                StatusBarColorManager.statusBarStyle = .darkContent
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

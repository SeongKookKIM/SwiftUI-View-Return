//
//  ContentView.swift
//  DemoContentView
//
//  Created by SeongKook on 4/17/24.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: buttonPressed) {
                Text("Click Me")
            }
        }
    }
    
    func buttonPressed() {
        print("Click")
    }
}



#Preview {
    ContentView()
}

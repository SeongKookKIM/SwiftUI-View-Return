//
//  ContentView.swift
//  DemoContentView
//
//  Created by SeongKook on 4/17/24.
//

import SwiftUI

struct MyStack<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 10) {
            content()
        }
        .font(.largeTitle)
    }
}



struct ContentView: View {
    var body: some View {
        MyStack {
            Text("Text Item 01")
            Text("Text Item 02")
            Text("Text Item 03")
            HStack {
                Image(systemName: "star.fill")
                Image(systemName: "star.fill")
                Image(systemName: "star")
            }
        }

    }
}



#Preview {
    ContentView()
}

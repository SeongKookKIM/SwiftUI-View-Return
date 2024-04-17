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
            VStack{
                Text("Text1")
                Text("Text2")
                MyHStackView()
            }
        }
    }
}

struct MyHStackView: View {
    var body: some View {
        HStack {
            Text("Text3")
            Text("Text4")
        }
    }
}

#Preview {
    ContentView()
}

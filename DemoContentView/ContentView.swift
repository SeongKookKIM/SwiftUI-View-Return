//
//  ContentView.swift
//  DemoContentView
//
//  Created by SeongKook on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var fileOpen: Bool = true
    var body: some View {
        var myString: String = "File closed"
        if(fileOpen) {
            myString = "File open"
        }
        return VStack {
            HStack {
                Text(myString)
                    .padding()
                Text("Goodbye, Wordl")
            }
        }
    }
}

#Preview {
    ContentView()
}

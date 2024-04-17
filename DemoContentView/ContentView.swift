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
            Text("Sample Text")
                .font(.custom("Copperplate", size: 70))
                .padding(20)
                .border(Color.black)
            
        }
    }
}



#Preview {
    ContentView()
}

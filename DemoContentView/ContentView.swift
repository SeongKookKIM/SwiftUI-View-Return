

import SwiftUI

struct ContentView: View {
  
    var body: some View {
        HStack {
            Image(systemName: "airplane")
            Text("Flight times:")
            Text("London")
        }
        .font(.largeTitle)
        .frame(width: 300)
        .lineLimit(1)
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
    }
}



#Preview {
    ContentView()
}

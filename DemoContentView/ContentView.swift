

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Hello Wordl, How are you?")
                    .padding()
                    .font(.largeTitle)
                    .border(Color.black)
                //  .frame(minWidth: 100, maxWidth: 300, minHeight: 100, maxHeight: 100, alignment: .center)
                    .frame(minWidth: 0, maxWidth: geometry.size.width / 2, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .ignoresSafeArea(.all)
        }
    }
}



#Preview {
    ContentView()
}

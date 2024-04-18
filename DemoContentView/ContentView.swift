

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        HStack {
            Text("Hello Wordl, How are you?")
                .padding()
                .font(.largeTitle)
                .border(Color.black)
            //  .frame(minWidth: 100, maxWidth: 300, minHeight: 100, maxHeight: 100, alignment: .center)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        }
        .ignoresSafeArea(.all)
    }
}



#Preview {
    ContentView()
}

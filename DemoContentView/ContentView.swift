

import SwiftUI




struct ContentView: View {
    @State private var rotation : Double = 0
    @State private var text : String = "Welcome"
    
    var body: some View {
        VStack{
            Text("Hello, World")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.purple)
                .rotationEffect(.degrees(rotation))
                .animation(.easeInOut(duration: 5), value: rotation)
            
            TextField("Enter Text Here", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Slider(value: $rotation, in: 0...360,step: 0.1)
            
            
        }
    }
}




#Preview {
    ContentView()
}

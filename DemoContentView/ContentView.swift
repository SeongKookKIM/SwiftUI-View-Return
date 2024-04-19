

import SwiftUI


class DemoData: ObservableObject {
    @Published var userCount = 0
    
    func increament() {
        userCount += 1
    }
}

struct ContentView: View {
    // ObservedObject StateObject는 차이가 있음
    @ObservedObject var demoData: DemoData = DemoData()
    
    var body: some View {
        VStack{
            Text("you are user number \(demoData.userCount)")
            
            Button(action:{
                demoData.increament()
            }) {
                Text("Increament")
                    .font(.largeTitle)
            }
        }
    }
}




#Preview {
    ContentView()
}

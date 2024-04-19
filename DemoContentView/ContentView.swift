

import SwiftUI


class DemoData: ObservableObject {
    @Published var userCount = 0
    @Published var currentUser = ""
    
    init() {
        updateData()
    }
    
    func updateData() {
        
    }
}

struct ContentView: View {
    // ObservedObject StateObject는 차이가 있음
    @ObservedObject var demoData: DemoData = DemoData()
    
    var body: some View {
        VStack{
            Text("\(demoData.currentUser), you are user number \(demoData.userCount)")
        }
    }
}




#Preview {
    ContentView()
}

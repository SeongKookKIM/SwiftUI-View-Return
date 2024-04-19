

import SwiftUI

struct ContentView: View {
    @State private var wifiEnabled = true
    @State private var userName = ""
    var body: some View {
        VStack{
            Toggle(isOn: $wifiEnabled) {
                Text("Enable WiFi")
            }
            TextField("Enter user name", text: $userName)
                .border(Color.black)
            Text(userName)
            WifiImageView(wifiEnabled: $wifiEnabled)
        }
    }
}

struct WifiImageView: View {
    @Binding var wifiEnabled: Bool
    var body: some View {
        Image(systemName: wifiEnabled ? "wifi" : "wifi.slash")
            .font(.largeTitle)
    }
}


#Preview {
    ContentView()
}

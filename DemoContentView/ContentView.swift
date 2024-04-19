

import SwiftUI

struct Repository: Codable, Identifiable {
    let id: Int
    let name:String
    let description: String?

}


struct ContentView: View {
    @State private var username = "SK"
    @State private var repositories: [Repository] = []
    
    var body: some View {
        VStack{
         TextField("Github userName:", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Fetch Data") {
                Task {
                    do {
                        async let fetchRepositoris = fetchReopsitories(username: username)
                        
                        repositories = try await fetchRepositoris
                        
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            
            List(repositories) {repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    
                    Text(repo.description ?? "No description")
                        .font(.subheadline)
                    
                }
            }
        }
    }
    
    func fetchReopsitories(username:String) async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([Repository].self, from: data)
    }
}




#Preview {
    ContentView()
}

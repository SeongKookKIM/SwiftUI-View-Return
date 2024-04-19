

import SwiftUI

struct Repository: Codable, Identifiable {
    let id: Int
    let name:String
    let description: String?
}

struct User: Codable {
    let avatar_url: URL
    let login: String
}


// Class 사용자와 다른 참조값 - 비동기 처리로 한 개씩 처리를 해줌 즉 -> 비동기를 스택 안에서 동기식으로 처리
actor GithubService {
    
    func fetchUser(username: String) async throws -> User {
        let url = URL(string: "https://api.github.com/users/\(username)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(User.self, from: data)
    }
    
    func fetchReopsitories(username:String) async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/\(username)/repos")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        return try JSONDecoder().decode([Repository].self, from: data)
    }
}

@MainActor
class GithubViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var repositories: [Repository] = []
    @Published var error: Error?
    @Published var status = "Fetch Data"
    
    let githubService = GithubService()
    
    func fetchData(username: String) async {
        do {
            error = nil
            
            status = "Loading"
            async let fetchUser = githubService.fetchUser(username: username)
            async let fetchRepositoris = githubService.fetchReopsitories(username: username)
            
            user = try await fetchUser
            repositories = try await fetchRepositoris
            status = "Fetch Data"
            
        } catch {
            self.error = error
            print("Error: \(error)")
        }
    }
    
}


struct ContentView: View {

    @StateObject private var viewModel = GithubViewModel()
    @State private var username = "SeongKookKIM"
    

    
    var body: some View {
        VStack{
            TextField("Github userName:", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(viewModel.status) {
                Task {
                    await viewModel.fetchData(username:username)
                }
            }
            if let error = viewModel.error {
                Text("Error: \(error.localizedDescription)")
            }
            
            if let user = viewModel.user {
                AsyncImage(url: user.avatar_url) {image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                
                Text(user.login)
                    .font(.title)
            }
            
            
            
            List(viewModel.repositories) {repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    
                    Text(repo.description ?? "No description")
                        .font(.subheadline)
                    
                }
            }
            
        }
    }
    
    
}




#Preview {
    ContentView()
}

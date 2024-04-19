

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


struct ContentView: View {
    @State private var username = "SeongKookKIM"
    @State private var user: User?
    @State private var repositories: [Repository] = []
    @State private var status = "Fetch Data"
    
    let githubService = GithubService()
    
    var body: some View {
        VStack{
         TextField("Github userName:", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(status) {
                Task {
                    do {
                        status = "Loading"
                        async let fetchUser = githubService.fetchUser(username: username)
                        async let fetchRepositoris = githubService.fetchReopsitories(username: username)
                        
                        user = try await fetchUser
                        repositories = try await fetchRepositoris
                        status = "Fetch Data"
                        
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
            
            if let user = user {
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
            
            if(repositories.count != 0) {
                Text("\(repositories.count)개")
            }
            
            
            List(repositories) {repo in
                VStack(alignment: .leading) {
                    Text(repo.name)
                        .font(.headline)
                    
                    Text(repo.description ?? "No description")
                        .font(.subheadline)
                    
                }
            }
            
            Button("Fetch Data in Background") {
                Task.detached {
                    do {
                        let service = GithubService()
                        try await withThrowingTaskGroup(of: Void.self) { group in
                            group.addTask{
                                repositories = try await service.fetchReopsitories(username: username)
                            }
                            group.addTask{
                                user = try await service.fetchUser(username: username)
                            }
                            try await group.waitForAll()
                        }
                        
                      
                    } catch {
                        DispatchQueue.main.async {
                            print("\(error)")
                        }
                    }
                }
            }
            
        }
    }
    
  
}




#Preview {
    ContentView()
}

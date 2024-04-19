

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        VStack{
            Button(action:{
                doSomething()
            }) {
                Text("Do something")
            }
        }
    }
    func doSomething() {
        print("Start \(Date())")
        // detached 작업을 분리하는 작업
        let detachedTask = Task.detached(priority: .background) {
            let parentIndex: Int = 3
             async let result = takesTooLong(index: parentIndex)
            print("Date result: \(await result)")
        }
        
        /*
         Task.detached를 사용하여 생성된 Task는 주로 부모 Task와 별개로 실행되는 독립적인 작업에 사용됩니다. 이 작업은 부모 Task의 취소 여부와 상관없이 실행됩니다. 때문에 detachedTask.isCancelled이 true가 되는 경우는 없습니다.
         만약 Task를 생성하고 즉시 취소하고자 한다면, 이를 위해서는 취소 가능한 Task를 생성하고 cancel 메서드를 호출해야 합니다.
         */
        if(!detachedTask.isCancelled) {
            detachedTask.cancel()
        }
        
        print("End \(Date())")
    }
    
    func takesTooLong(index: Int) async -> Date {
        print("tasksTooLong Start")
        sleep(5)
        print("Async task completed at \(index)")
        return Date()
    }
}




#Preview {
    ContentView()
}

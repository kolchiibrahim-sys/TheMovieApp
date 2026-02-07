import Foundation

final class ActorViewModel {
    var items = [ActorResult]()
    
    private let manager = ActorManager()
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getActorList() {
        manager.getPopularActorList { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items = data.results ?? []
                self.success?()
            }
        }
    }
}

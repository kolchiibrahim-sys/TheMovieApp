import Foundation

class ActorManager {
    
    private let manager = CoreManager()
    
    func getPopularActorList(page: Int,
                             completion: @escaping ((Actor?, String?) -> Void)) {
        
        let endpoint = "\(ActorEndpoint.popularActor.rawValue)?page=\(page)"
        
        manager.request(model: Actor.self,
                        endpoint: endpoint,
                        completion: completion)
    }
}



import Foundation

class ActorManager {
    private let manager = CoreManager()
    
    func getPopularActorList(completion: @escaping((Actor?, String?) -> Void)) {
        manager.request(model: Actor.self,
                        endpoint: ActorEndpoint.popularActor.rawValue,
                        completion: completion)
    }
}

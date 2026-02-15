import Foundation

final class ActorManager {

    private let manager = CoreManager()

    func getPopularActorList(page: Int = 1,
                             completion: @escaping ((Actor?, String?) -> Void)) {

        let endpoint = "\(ActorEndpoint.popularActor.rawValue)?page=\(page)"

        manager.request(model: Actor.self,
                        endpoint: endpoint,
                        completion: completion)
    }

    func searchActors(query: String,
                      completion: @escaping ((Actor?, String?) -> Void)) {

        let endpoint = "/search/person?query=\(query)"

        manager.request(model: Actor.self,
                        endpoint: endpoint,
                        completion: completion)
    }
}

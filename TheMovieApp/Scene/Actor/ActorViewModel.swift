import Foundation

final class ActorViewModel {
    var items = [ActorResult]()
    
    private let manager = ActorManager()
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    
    func getActorList() {
        guard !isLoading else { return }
        guard currentPage <= totalPages else { return }
        
        isLoading = true
        
        manager.getPopularActorList(page: currentPage) { [weak self] data, errorMessage in
            guard let self = self else { return }
            self.isLoading = false
            
            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.totalPages = data.totalPages ?? 1
                self.items.append(contentsOf: data.results ?? [])
                self.currentPage += 1
                self.success?()
            }
        }
    }
}

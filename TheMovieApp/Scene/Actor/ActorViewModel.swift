import Foundation

final class ActorViewModel {

    var items: [ActorResult] = []

    private let manager = ActorManager()

    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    private var isSearching = false

    var success: (() -> Void)?
    var error: ((String) -> Void)?

    func getActorList() {
        guard !isLoading else { return }
        guard currentPage <= totalPages else { return }
        guard !isSearching else { return }

        isLoading = true

        manager.getPopularActorList(page: currentPage) { [weak self] data, errorMessage in
            guard let self else { return }
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

    func searchActors(query: String) {
        isSearching = true

        manager.searchActors(query: query) { [weak self] data, errorMessage in
            guard let self else { return }

            if let errorMessage {
                self.error?(errorMessage)
            } else if let data {
                self.items = data.results ?? []
                self.success?()
            }
        }
    }

    func resetSearch() {
        isSearching = false
        currentPage = 1
        totalPages = 1
        items.removeAll()
        getActorList()
    }
}

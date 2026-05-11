import Foundation

@MainActor
class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage = ""

    private let service: PostService

    init(service: PostService = PostService()) {
        self.service = service
    }

    func loadPosts() async {
        isLoading = true
        errorMessage = ""

        do {
            posts = try await service.fetchPosts()
        } catch let apiError as PostAPIError {
            errorMessage = apiError.message
        } catch {
            errorMessage = "Something went wrong. Please try again."
        }

        isLoading = false
    }
}

import SwiftUI

struct PostsListView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.posts.isEmpty {
                    ProgressView("Loading posts...")
                } else if viewModel.errorMessage.isEmpty == false {
                    ErrorStateView(
                        message: viewModel.errorMessage,
                        retryAction: {
                            Task {
                                await viewModel.loadPosts()
                            }
                        }
                    )
                } else {
                    List(viewModel.posts) { post in
                        NavigationLink {
                            PostDetailView(post: post)
                        } label: {
                            PostRowView(post: post)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reload") {
                        Task {
                            await viewModel.loadPosts()
                        }
                    }
                }
            }
            .task {
                if viewModel.posts.isEmpty {
                    await viewModel.loadPosts()
                }
            }
        }
    }
}

struct PostRowView: View {
    let post: Post

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(post.title.capitalized)
                .font(.headline)

            Text("User \(post.userId)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(post.body)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineLimit(2)
        }
        .padding(.vertical, 6)
    }
}

struct PostDetailView: View {
    let post: Post

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(post.title.capitalized)
                    .font(.title2)
                    .bold()

                Text("Post \(post.id) by user \(post.userId)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Divider()

                Text(post.body)
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ErrorStateView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Text(message)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)

            Button("Try Again") {
                retryAction()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

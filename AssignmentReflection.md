# Assignment Reflection

## What is MVVM?

MVVM stands for Model, View, and ViewModel. The Model represents the data, the View shows the user interface, and the ViewModel sits between them. The ViewModel gets data, stores screen state, and prepares information for the View.

## How do we implement MVVM in a SwiftUI project?

In this project, `Post` is the Model because it matches the data returned by the API. `PostsListView` and its smaller views are the Views because they draw the screen. `PostsViewModel` is the ViewModel because it asks `PostService` for posts, tracks loading state, stores posts, and exposes error messages to the View.

## What is an enum in Swift?

An enum is a type that defines a group of related possible values. In this project, `PostAPIError` is an enum used for error handling. Each case represents a different kind of API problem, such as an invalid URL, failed request, bad status code, or decoding failure.

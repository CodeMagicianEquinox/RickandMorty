# Assignment Reflection

## What is MVVM?

MVVM stands for Model, View, and ViewModel. The Model represents the data, the View shows the user interface, and the ViewModel sits between them. The ViewModel gets data, stores screen state, and prepares information for the View.

## How do we implement MVVM in a SwiftUI project?

In this project, `RMCharacter` is the Model because it matches the character data returned by the Rick and Morty API. `CharactersListView` and `CharacterDetailView` are the Views because they draw the screens. `CharactersViewModel` is the ViewModel because it asks `RMAPIService` for characters, tracks loading state, stores characters, and exposes error messages to the View. The API logic is separated into `RMAPIService` so the View does not do the network request directly.

## What is an enum in Swift?

An enum is a type that defines a group of related possible values. In this project, `RMAPIError` is an enum used for error handling. Each case represents a different kind of API problem, such as an invalid URL, failed request, bad status code, no results, or decoding failure.

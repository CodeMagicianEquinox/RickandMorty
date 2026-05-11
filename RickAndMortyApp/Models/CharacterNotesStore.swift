//
//  saves.swift
//  RickAndMortyApp
//
//  Created by Arturo Martinez on 1/16/26.
//


import Foundation

// This class saves and loads notes using UserDefaults.
// Notes are stored per character id.
class CharacterNotesStore {

    private let userDefaults: UserDefaults = UserDefaults.standard

    // We create a unique key per character.
    private func makeKey(characterId: Int) -> String {
        return "character_note_\(characterId)"
    }

    func loadNote(characterId: Int) -> String {
        let key: String = makeKey(characterId: characterId)
        let savedNote: String? = userDefaults.string(forKey: key)

        if let note: String = savedNote {
            return note
        } else {
            return ""
        }
    }

    func saveNote(characterId: Int, note: String) {
        let key: String = makeKey(characterId: characterId)
        userDefaults.set(note, forKey: key)
    }

    func clearNote(characterId: Int) {
        let key: String = makeKey(characterId: characterId)
        userDefaults.removeObject(forKey: key)
    }
}

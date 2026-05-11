//
//  RMResource.swift
//  RickAndMortyApp
//
//  Created by Arturo Martinez on 1/20/26.
//


import Foundation

// This enum represents which API section the user is browsing.
enum RMResource: String, CaseIterable, Identifiable {
    case characters = "Characters"
    case episodes = "Episodes"
    case locations = "Locations"

    var id: String {
        return self.rawValue
    }

    func apiPath() -> String {
        if self == .characters {
            return "character"
        } else if self == .episodes {
            return "episode"
        } else {
            return "location"
        }
    }
}

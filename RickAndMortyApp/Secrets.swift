//
//  SecretsDecode.swift
//  RickAndMortyApp
//
//  Created by Arturo Martinez on 1/16/26.
//

import Foundation

enum Secrets{
    
    static var weatherAPIKey:String {
        guard let key  = Bundle.main.infoDictionary?["RM_API_KEY"] as? String else{
            fatalError("Couldnt read API key ")
        }
        return key
    }
    
}

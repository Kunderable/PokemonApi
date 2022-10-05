//
//  PokemonModel.swift
//  Pokemon
//
//  Created by Илья Сутормин on 29.09.2022.
//

import Foundation

struct Pokemon: Codable {
    var count: Int
    var results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    let name: String
    let url: String
}

struct PokemonSelection: Codable {
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let baseExperience: Int
    let types: [TypeElement]
    let abilities: [Ability]?
    let order: Int

    enum CodingKeys: String, CodingKey {
        case name, height, weight, sprites, types, abilities, order
        case baseExperience = "base_experience"
    }
}

struct PokemonSprites: Codable {
    let frontDefault: String


    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: Species
}

struct Species: Codable {
    let name: String
}

struct Ability: Codable {
    let ability: Species
}




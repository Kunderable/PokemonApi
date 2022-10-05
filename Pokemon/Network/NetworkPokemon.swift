//
//  NetworkPokemon.swift
//  Pokemon
//
//  Created by Илья Сутормин on 29.09.2022.
//

import UIKit

class NetworkPokemon {
    static func araayPokemon(url: String, completion: @escaping ([PokemonEntry]) -> ()) {
        guard let url = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(Pokemon.self, from: data).results
                completion(models)
            } catch {
                print("Error")
            }
        }.resume()
    }
    
    static func dataPokemon(url: String, compelion:  @escaping (PokemonSelection) -> ()) {
        guard let url =  URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let models = try decoder.decode(PokemonSelection.self, from: data)
                compelion(models)
            } catch {
                print("error")
            }
        }.resume()
    }
}

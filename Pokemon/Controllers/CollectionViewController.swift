//
//  CollectionViewController.swift
//  Pokemon
//
//  Created by Илья Сутормин on 29.09.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet var colletionView: UICollectionView!
    
    var namePokemon: String?
    var arrayPoke  = [PokemonSelection]()
    var filtredPokemons = [PokemonSelection]()
    let pokemonUrl = "https://pokeapi.co/api/v2/pokemon"
    let searchBar = UISearchController(searchResultsController: nil)
    var timer: Timer?
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        
        navigationItem.searchController = searchBar
        searchBar.searchBar.delegate = self
        searchBar.searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.obscuresBackgroundDuringPresentation = false
        
        let logo = UIImageView(image: #imageLiteral(resourceName: "pokeapi"))
        logo.contentMode = .scaleAspectFit
        navigationItem.titleView = logo

    }

    private func fetch() {
        NetworkPokemon.araayPokemon(url: pokemonUrl) { [weak self] poke in
            self?.fetcSelection(array: poke)
        }
    }
    
    private func fetcSelection(array: [PokemonEntry]) {
        for pokemon in array {
            NetworkPokemon.dataPokemon(url: pokemon.url) { [weak self] poke in
                self?.arrayPoke.append(poke)
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
    
    
    private func configureCell(cell: CollectionViewCell, for indexPath: IndexPath) {
        cell.titlePokemon.text = self.arrayPoke[indexPath.row].name
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: self.arrayPoke[indexPath.row].sprites.frontDefault) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.imagePokemon.image = UIImage(data: imageData)
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = arrayPoke[indexPath.row]
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC") as? ViewController else { return }
        
        vc.pokemon = poke
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filtredPokemons.count
        } else {
            return arrayPoke.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            let poke: PokemonSelection!
            
            if inSearchMode {
                poke = filtredPokemons[indexPath.row]
            } else  {
                poke = arrayPoke[indexPath.row]
            }
            
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth  = 1
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            configureCell(cell: cell as! CollectionViewCell, for: indexPath)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

extension CollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            
            view.endEditing(true)
            
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            
            filtredPokemons = arrayPoke.filter({$0.name.range(of: lower) != nil})
        }
        collectionView.reloadData()
    }
}

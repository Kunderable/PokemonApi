//
//  ViewController.swift
//  Pokemon
//
//  Created by Илья Сутормин on 29.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    var pokemon: PokemonSelection!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weigthLAbel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            guard let imageURL = URL(string: self.pokemon.sprites.frontDefault) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async { [self] in
                self.nameLabel.text = pokemon.name
                self.heightLabel.text = String(pokemon.height)
                self.weigthLAbel.text = String(pokemon.weight)
                self.typeLabel.text = pokemon.types[0].type.name
                self.baseLabel.text = String(pokemon.baseExperience)
                self.abilitiesLabel.text = pokemon.abilities![0].ability.name
                self.imageLabel.image = UIImage(data: imageData)
                
            }
            
        }
    }
}

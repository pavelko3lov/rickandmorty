//
//  CharacterCell.swift
//  rickandmorty
//
//  Created by Pavel Kozlov on 11.02.2021.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet weak var characterImage: UIImageView!
    
    func configure(character: Character, completion: @escaping BoolCompletion) -> Self {
        //    MARK: - TODO
        let url = URL(string: character.image)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data: Data?, response, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let data = data else {
                debugPrint(NSError(domain: "not found", code: -1, userInfo: nil))
                return
            }
            
            DispatchQueue.main.async {
                self.characterImage.image = UIImage(data: data)
                completion(true)
            }
        })
        task.resume()
        return self
    }
}

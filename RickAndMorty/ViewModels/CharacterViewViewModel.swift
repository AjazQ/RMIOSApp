//
//  CharacterViewViewModel.swift
//  RickAndMorty
//
//  Created by PS19Developer on 04/04/2023.
//

import UIKit

final class CharacterListViewViewModel: NSObject {
    
    public func fetchCharacters(){
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self){ result in
            switch result {
            case .success(let model):
                print("Total Pages:" + String(model.info.pages))
                print("Total result Count:" + String(model.results.count))
            case .failure(let error):
                print(String(String(describing: error)))
            }
        }
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemGreen
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
}

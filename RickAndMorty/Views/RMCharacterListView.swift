//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by PS19Developer on 04/04/2023.
//

//Cmd + Shif + A for dark mode
import UIKit
protocol RMCharacterListViewDelegate: AnyObject{
    /// Whenever a character is clicked we will call this delegate to notify
    /// - Parameters:
    ///   - characterListView: Current List view
    ///   - character: character on which item is clicked
    func rmCharacterListView(
        _ characterListView: RMCharacterListView,
        didSelectCharacter character: RMCharacter
    )
}
/// View that handles showing list of characters, loader, etc.
final class RMCharacterListView: UIView {
    /// Delegate to send events like click etc.
    public weak var delegate: RMCharacterListViewDelegate?
    
    private let viewModel = RMCharacterListViewViewModel()
    
    private let spinner: UIActivityIndicatorView  = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    private let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        
        return collectionView
    }()
    //MARK: -Init
    
    override init(frame: CGRect){
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(collectionView, spinner)
        //backgroundColor = .systemPink
        addContraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchCharacters()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    private func addContraints(){
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant:  100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),

            collectionView.topAnchor.constraint(equalTo:  topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    func setupCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel

    }
}

extension RMCharacterListView : RMCharacterListViewViewModelDelegate{
    func didSelectCharacter(_ character: RMCharacter){
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
    func didLoadInitialCharacters(){
        collectionView.reloadData()
        
        spinner.stopAnimating()
        collectionView.isHidden = false
        UIView.animate(withDuration: 0.4){
            self.collectionView.alpha = 1
        }

    }
}

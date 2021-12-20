//
//  PokemonCollectionViewCell.swift
//  Pokemonium
//
//  Created by Ivailo Kanev on 19/12/21.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thumbnailView, labelTitle] )
        stack.spacing = 4
        stack.axis = .vertical
        contentView.addSubview(stack)
        stack.fixTop(4).fixLeft(4).fixRight(4).fixBottom(4, .defaultLow).setHeight(120)
        return stack
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.textColor = .init(named: "titleColor")
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        return label
    }()
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private var model: PokemonViewModel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainStack.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(model: PokemonViewModel) {
        self.model = model
        labelTitle.text = model.name
        thumbnailView.image = model.thumbnail
        thumbnailView.toggleActivityIndicator(thumbnailView.image == nil)
    }
    
    func loadThumbnail(indexPath: IndexPath, completion: @escaping (IndexPath) -> Void) {
        guard let model = model, model.thumbnail == nil else {
            return
        }
        model.loadThumbnail { image, error in
            completion(indexPath)
        }
    }
}

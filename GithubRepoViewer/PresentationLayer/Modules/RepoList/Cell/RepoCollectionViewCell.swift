//
//  RepoCollectionViewCell.swift
//  GithubRepoViewer
//
//  Created by Denis Zhukov on 07.11.2020.
//

import UIKit

class RepoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        clipsToBounds = true
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 30).isActive = true
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        backgroundColor = .gray
    }
    
    func configureCell(item: Repo){
        nameLabel.text = item.name
        descriptionLabel.text = item.description
        idLabel.text = item.id?.description
        ownerLabel.text = item.owner?.login
    }
}

//
//  UserTableViewCell.swift
//  Instegram-followers
//
//  Created by Mdo on 21/02/2021.
//

import Foundation
import UIKit

class UserTableViewCell:UITableViewCell{
    
    //MARK: - properties
    
    static let reuseIdentifier = String(describing: UserTableViewCell.self)
    
    var followers:Bool = false {
        didSet{
            if !followers{
                followButton.setTitle("Following", for: .normal)
            }else{
                followButton.setTitle("Remove", for: .normal)
            }
        }
    }
    
    let profileImageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var followButton:UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        

        
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 3
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    
        return button
    }()
    
    lazy var userNameLabel:UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 15)
        lable.text = "Username"
        return lable
    }()
    
   
    
    
    //MARK: - Cell life cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - config ui
    
    private func configUI(){
        
        addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 20).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        
        profileImageView.layer.cornerRadius = 48 / 2
        
        addSubview(userNameLabel)
        
        userNameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor,constant: 15).isActive = true
        userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(followButton)
        followButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        followButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        followButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    
}

//
//  SearchTableViewCell.swift
//  Instegram-followers
//
//  Created by Mdo on 20/02/2021.
//

import Foundation
import UIKit

class SearchTableViewCell:UITableViewHeaderFooterView, UITextFieldDelegate, UISearchTextFieldDelegate
{
    
    //MARK: - properties & vars
    
    static let reuseIdentifier = String(describing: SearchTableViewCell.self)
    
    lazy var searchTextField:UISearchTextField = {
       let searchTextField = UISearchTextField()
        searchTextField.text = "Search"
        searchTextField.textColor = .lightGray
        
        return searchTextField
    }()
    let textField = UITextField()
    
    
    //MARK: - cell life cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - config ui
    
    private func configUI(){
        contentView.addSubview(searchTextField)
        
        searchTextField.delegate = self
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.leftAnchor.constraint(equalTo: leftAnchor,constant: 8).isActive = true
        searchTextField.topAnchor.constraint(equalTo: topAnchor,constant: 8).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: rightAnchor,constant: -8).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -8).isActive = true
        
        
        
    }

    
    
}

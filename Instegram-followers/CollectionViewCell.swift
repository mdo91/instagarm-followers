//
//  CollectionViewCell.swift
//  Instegram-followers
//
//  Created by Mdo on 17/02/2021.
//

import Foundation
import UIKit

class CollectionViewCell:UICollectionViewCell, UITextFieldDelegate{
    
    //MARK: - properties
    
    static let reuseIndentifier = String(describing: CollectionViewCell.self)
    
    var following = ["spaceX","bbc","nasa"]
    var followers = ["rosy","Alex","latania"]
    var usersType: String?
        
    lazy var tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - cell life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        self.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI(){
        addSubview(tableView)
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
  
        
        
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.reuseIdentifier)
        tableView.register(SearchTableViewCell.self, forHeaderFooterViewReuseIdentifier: SearchTableViewCell.reuseIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
    }
    
    
}
extension CollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return following.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.reuseIdentifier, for: indexPath) as? UserTableViewCell else{
            fatalError("could not init \(UserTableViewCell.self)")
        }
        
        if let usersType = usersType{
            
            if usersType == "followers"{
                cell.profileImageView.image =  UIImage(named: followers[indexPath.row ])!
                cell.userNameLabel.text = followers[indexPath.row]
                cell.followers = true
            }else{
                cell.followers = false
                cell.userNameLabel.text = following[indexPath.row]
                cell.profileImageView.image =  UIImage(named: following[indexPath.row ])!
            }
        }

        cell.selectionStyle = .none
        return cell

 
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SearchTableViewCell.reuseIdentifier) as? SearchTableViewCell else{
            fatalError("could not init \(SearchTableViewCell.self)")
        }
        header.contentView.backgroundColor = .white
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }

}

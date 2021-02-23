//
//  ViewController.swift
//  Instegram-followers
//
//  Created by Mdo on 17/02/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK: - properties
    
    lazy var segmentedButtonsView:SegmentedButtonsView = {
        
       let segmentedButtonsView = SegmentedButtonsView()
        
        segmentedButtonsView.setLabelsTitles(titles: ["Followers", "Following"])
        segmentedButtonsView.translatesAutoresizingMaskIntoConstraints = false
        segmentedButtonsView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        segmentedButtonsView.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        segmentedButtonsView.layer.borderWidth = 0.5
        
        return segmentedButtonsView
        
    }()
    
    lazy var collectionView:UICollectionView = {
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionViewFlowLayout.minimumInteritemSpacing = 1
        collectionViewFlowLayout.minimumLineSpacing = 1
     
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        
      
        collectionView.isPagingEnabled = true
        
   
        collectionView.indicatorStyle = .white
        return collectionView
    }()
    
    let allUsers = ["followers","following"]
    
    
    weak var delegate: CollectionViewDidScrollDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
  
        configCollectionView()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configNavigationItem()
    }
 
    
    
    private func configCollectionView(){
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseIndentifier)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        segmentedButtonsView.segmentedControlDelegate = self
        view.addSubview(segmentedButtonsView)
        
        segmentedButtonsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        segmentedButtonsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        segmentedButtonsView.topAnchor.constraint(equalTo: view.topAnchor,constant: 86).isActive = true

        segmentedButtonsView.heightAnchor.constraint(equalToConstant: 40).isActive = true

       
        
        self.view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: segmentedButtonsView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.backgroundColor = .white
        
        
        
    }
    
    private func configNavigationItem(){
        //remove bottom-border of nav bar
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //set nav bar title "userName"
        self.navigationItem.title = "Mdo91"
        
    }
    

}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    //MARK: - collectionView Delegate
    
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allUsers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIndentifier, for: indexPath) as? CollectionViewCell else{
            fatalError("could not load \(CollectionViewCell.self)") }
        cell.usersType = allUsers[indexPath.row]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height -  150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        delegate = segmentedButtonsView
        delegate?.collectionViewDidScroll(for: scrollView.contentOffset.x / 2)
    }
    
    func scrollToFrame(scrollOffset : CGFloat) {
                guard scrollOffset <= collectionView.contentSize.width - collectionView.bounds.size.width else { return }
                guard scrollOffset >= 0 else { return }
        collectionView.setContentOffset(CGPoint(x: scrollOffset, y: collectionView.contentOffset.y), animated: true)
        
    }
}
extension MainViewController: SegmentedControlDelegate{

    //MARK: - segmented Controller delegate
    
    func didIndexChanged(at index: Int) {

       
        if index == 0 {
            // scroll forward
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x - collectionBounds.size.width))
            self.moveToFrame(contentOffset: contentOffset)
            
        }else if index == 1 {
            // scroll backward
            let collectionBounds = self.collectionView.bounds
            let contentOffset = CGFloat(floor(self.collectionView.contentOffset.x + collectionBounds.size.width))
            self.moveToFrame(contentOffset: contentOffset)
        }
    }
    
    func moveToFrame(contentOffset : CGFloat) {

        let frame: CGRect = CGRect(x : contentOffset ,y : self.collectionView.contentOffset.y ,width : self.collectionView.frame.width,height : self.collectionView.frame.height)
        self.collectionView.scrollRectToVisible(frame, animated: true)
    }
   
}


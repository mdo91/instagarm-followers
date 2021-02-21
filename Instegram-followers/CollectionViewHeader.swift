//
//  collectionViewHeader.swift
//  Instegram-followers
//
//  Created by Mdo on 17/02/2021.
//

import Foundation
import UIKit

protocol CollectionViewDidScrollDelegate:class {
    func collectionViewDidScroll(for x: CGFloat)
    
}
protocol SegmentedControlDelegate:class{
    func didIndexChanged(at index: Int)
}

class CollectionViewHeader:UIView, CollectionViewDidScrollDelegate{
 
  
   
    
    //MARK: - properties
    
    lazy var selectorView = UIView()
    lazy var lables = [UILabel]()
    private var titles: [String]!
    var textColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    public private(set) var selectedIndex: Int = 0

    
    weak var delegate: CollectionViewDidScrollDelegate?
    weak var segmentedControlDelegate: SegmentedControlDelegate?
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame:frame)
        self.titles = titles
    }
    

    
    
    //MARK: - config selected Tap
    
    private func configSelectedTap(){
        let selectorWidth = self.frame.width / 2
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.8, width: selectorWidth, height: 0.5))
        selectorView.backgroundColor = .black
        addSubview(selectorView)
    }
    
    //MARK: - updateView
    
    private func updateView(){
        createLables()
        configSelectedTap()
        configStackView()
    }
    
    //MARK: - draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    //MARK: - create lables
    
    private func createLables(){
        
        lables.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for lableTitle in titles{
            
            let lable = UILabel()
            lable.font = UIFont.systemFont(ofSize: 18)
            lable.text = lableTitle
            let tapGestureRecognizor = UITapGestureRecognizer(target: self, action: #selector(lableActionHandler(sender:)))
            tapGestureRecognizor.numberOfTapsRequired = 1
            lable.addGestureRecognizer(tapGestureRecognizor)
            lable.isUserInteractionEnabled = true
            
            lable.textColor = textColor
            lable.textAlignment = .center
            lables.append(lable)
        }
        lables[0].textColor = selectorTextColor
    }
    
    //MARK: - set lables titles
    
    func setLablesTitles(titles:[String]){
        
        self.titles = titles
        self.updateView()
        
    }
    
    //MARK: - config stackView
    
    private func configStackView(){
        let stackView = UIStackView(arrangedSubviews: lables)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
       // stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    

    //MARK: - handler
    
    @objc private func lableActionHandler(sender:UITapGestureRecognizer){
        
     
        for (lableIndex, lbl) in lables.enumerated() {
            
       
            if lbl == sender.view{
                let selectorPosition = frame.width / CGFloat(titles.count) * CGFloat(lableIndex)
                selectedIndex = lableIndex
                //todo set delegate
                segmentedControlDelegate?.didIndexChanged(at: selectedIndex)
                UIView.animate(withDuration: 0.1) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
             
                
            }
        }
        
    }

}
extension CollectionViewHeader{
    
    func collectionViewDidScroll(for x: CGFloat) {
        
       
        UIView.animate(withDuration: 0.1) { [self] in
            self.selectorView.frame.origin.x = x
            
           
            for (_,view)in subviews.enumerated(){
                
       
                if view is UIStackView{
                   
                    guard let stack = view as? UIStackView else { return }
                    
              
                    for (_,lable) in stack.arrangedSubviews.enumerated(){
                   
                        guard let lable = lable as? UILabel else {
                            print("Error ")
                            return
                        }
                        
                        if  (lable.frame.width / 2  >= self.selectorView.frame.origin.x && titles[0] == lable.text! || lable.frame.width / 2  <= self.selectorView.frame.origin.x && titles[1] == lable.text! ) {
                            
                            lable.textColor = selectorTextColor
                        }else{
                            lable.textColor = textColor
                        }
                        
                    }
                    
                }
            }
    
        }
    }
    
    func didIndexChanged(at index: Int) {
        
    }
}

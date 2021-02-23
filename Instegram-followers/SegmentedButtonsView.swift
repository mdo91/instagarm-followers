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

class SegmentedButtonsView:UIView, CollectionViewDidScrollDelegate{

    //MARK: - properties
    
    lazy var selectorView = UIView()
    lazy var labels = [UILabel]()
    private var titles: [String]!
    var textColor = UIColor.lightGray
    var selectorTextColor = UIColor.black
    public private(set) var selectedIndex: Int = 0

    weak var segmentedControlDelegate: SegmentedControlDelegate?
    
    convenience init(frame: CGRect, titles: [String]) {
        self.init(frame:frame)
        self.titles = titles
    }
    

    //MARK: - config selected Tap
    
    private func configSelectedTap(){
        let segmentsCount = CGFloat(titles.count)
        let selectorWidth = self.frame.width / segmentsCount
        selectorView = UIView(frame: CGRect(x: 0, y: self.frame.height - 0.8, width: selectorWidth, height: 0.5))
        selectorView.backgroundColor = .black
        addSubview(selectorView)
    }
    
    //MARK: - updateView
    
    private func updateView(){
        createLabels()
        configSelectedTap()
        configStackView()
    }
    
    //MARK: - draw
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        updateView()
    }
    
    //MARK: - create labels
    
    private func createLabels(){
        
        labels.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for labelTitle in titles{
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = labelTitle
            let tapGestureRecognizor = UITapGestureRecognizer(target: self, action: #selector(labelActionHandler(sender:)))
            tapGestureRecognizor.numberOfTapsRequired = 1
            label.addGestureRecognizer(tapGestureRecognizor)
            label.isUserInteractionEnabled = true
            
            label.textColor = textColor
            label.textAlignment = .center
            labels.append(label)
        }
        labels[0].textColor = selectorTextColor
    }
    
    //MARK: - set labels titles
    
    func setLabelsTitles(titles:[String]){
        
        self.titles = titles
        self.updateView()
        
    }
    
    //MARK: - config stackView
    
    private func configStackView(){
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    

    //MARK: - handler
    
    @objc private func labelActionHandler(sender:UITapGestureRecognizer){
        
     
        for (labelIndex, lbl) in labels.enumerated() {
            
       
            if lbl == sender.view{
                let selectorPosition = frame.width / CGFloat(titles.count) * CGFloat(labelIndex)
                selectedIndex = labelIndex
                //todo set delegate
                segmentedControlDelegate?.didIndexChanged(at: selectedIndex)
                UIView.animate(withDuration: 0.1) {
                    self.selectorView.frame.origin.x = selectorPosition
                }
            }
        }
    }
}
extension SegmentedButtonsView{
    
    func collectionViewDidScroll(for x: CGFloat) {

        UIView.animate(withDuration: 0.1) { [self] in
            self.selectorView.frame.origin.x = x
            
           
            for (_,view)in subviews.enumerated(){
                
       
                if view is UIStackView{
                   
                    guard let stack = view as? UIStackView else { return }
                    
              
                    for (_,label) in stack.arrangedSubviews.enumerated(){
                   
                        guard let label = label as? UILabel else {
                            print("Error ")
                            return
                        }
                        
                        if  (label.frame.width / 2  >= self.selectorView.frame.origin.x && titles[0] == label.text! || label.frame.width / 2  <= self.selectorView.frame.origin.x && titles[1] == label.text! ) {
                            
                            label.textColor = selectorTextColor
                            
                        }else{
                            
                            label.textColor = textColor
                        }
                        
                    }
                }
            }
    
        }
    }
    
    func didIndexChanged(at index: Int) {
        
    }
}

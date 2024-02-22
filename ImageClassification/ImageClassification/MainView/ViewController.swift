//
//  ViewController.swift
//  ImageClassification
//
//  Created by Kaua Miguel on 22/02/24.
//

import UIKit

class ViewController: UIViewController {

    var buttonImage : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "img1"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var category : UILabel = {
       let categ = UILabel()
        categ.text = "Category"
        categ.textColor = .black
        categ.translatesAutoresizingMaskIntoConstraints = false
        categ.font = .systemFont(ofSize: 18)
        return categ
    }()
    
    let model = Resnet50()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        configureView()
        
    }
    
    @objc func buttonTapped(){
        guard let imageToAnalyse = buttonImage.imageView?.image else {return}
        
        let result = sceneLabel(forImage: imageToAnalyse)
        self.category.text = result
    }
    
    
    func sceneLabel (forImage image : UIImage) -> String?{
        
        if let pixelImage = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
            guard let scene = try? model.prediction(image: pixelImage) else{fatalError()}
            return scene.classLabel
        }
        
        
        return nil
    }
    
    func configureView(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(buttonImage)
        self.view.addSubview(category)
        
        buttonImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        category.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        category.topAnchor.constraint(equalTo: buttonImage.bottomAnchor, constant: 20).isActive = true
    }
    


}


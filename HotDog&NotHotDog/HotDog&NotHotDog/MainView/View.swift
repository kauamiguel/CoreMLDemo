//
//  View.swift
//  HotDog&NotHotDog
//
//  Created by Kaua Miguel on 22/02/24.
//

import UIKit

class View{
    var takePictureButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Take Picture", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.zPosition = 2
        return button
    }()
    
    var imageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.zPosition = 1
        return imgView
    }()
    
    var hotDogFeedBack : UIImageView = {
        let image = UIImageView(image: UIImage(named: "hotDogImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.zPosition = 4
        return image
    }()
    
    var notHotDogFeedBack : UIImageView = {
        let image = UIImageView(image: UIImage(named: "notHotDogImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.zPosition = 4
        return image
    }()
    
    
    func setupView(view : UIView){
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(takePictureButton)
        
        takePictureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePictureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 600).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        imageView.trailingAnchor.constraint(equalTo : view.trailingAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: takePictureButton.topAnchor, constant: -10).isActive = true
        
        imageView.backgroundColor = .gray
    }
}

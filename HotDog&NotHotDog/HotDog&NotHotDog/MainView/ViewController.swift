//
//  ViewController.swift
//  HotDog&NotHotDog
//
//  Created by Kaua Miguel on 22/02/24.
//

import UIKit

class ViewController: UIViewController {
    
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
    
    var hotDog : UIImageView = {
        let image = UIImageView(image: UIImage(named: "hotDogImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.zPosition = 4
        return image
    }()
    
    var notHotDog : UIImageView = {
        let image = UIImageView(image: UIImage(named: "notHotDogImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.zPosition = 4
        return image
    }()
    
    var model = HotDogModel()
    
    var isHotDog : Bool = false
    
    var image : UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        takePictureButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        setupView()
    }
    
    
    @objc func didTapButton(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func setupView(){
        self.view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(takePictureButton)
        
        takePictureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        takePictureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo : view.trailingAnchor, constant: -20).isActive = true
        imageView.bottomAnchor.constraint(equalTo: takePictureButton.topAnchor, constant: -10).isActive = true
        
        imageView.backgroundColor = .gray
    }
    
    
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //Function that controll when cancel the picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //This functions gets the image photo that was taken
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        //get the image taken
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        self.image = image
        let result = coreMLResult(forImage: image)
        if result == "hotdog"{
            self.isHotDog = true
        }else{
            self.isHotDog = false
        }
        configureResult()
        imageView.image = image
    }
    
    func coreMLResult(forImage image : UIImage) -> String{
        
        if let pixelImage = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
            guard let scene = try? model.prediction(image: pixelImage) else {fatalError()}
            return scene.target
        }
        
        return ""
    }
    
    func configureResult(){
        if isHotDog{
            self.view.addSubview(hotDog)
            hotDog.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            hotDog.widthAnchor.constraint(equalToConstant: 350).isActive = true
            hotDog.heightAnchor.constraint(equalToConstant: 150).isActive = true
            hotDog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            
        }else{
            self.view.addSubview(notHotDog)
            notHotDog.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            notHotDog.widthAnchor.constraint(equalToConstant: 350).isActive = true
            notHotDog.heightAnchor.constraint(equalToConstant: 150).isActive = true
            notHotDog.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
    }
    
}


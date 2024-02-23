//
//  ViewController.swift
//  HotDog&NotHotDog
//
//  Created by Kaua Miguel on 22/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    let viewReference = View()
    
    var model = HotDogModel()
    
    var isHotDog : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewReference.setupView(view: self.view)
        viewReference.takePictureButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    
    @objc func didTapButton(){
        
        //Remove the view of result of the scene
        viewReference.hotDogFeedBack.removeFromSuperview()
        viewReference.notHotDogFeedBack.removeFromSuperview()
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true)
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
        
        guard let result = coreMLResult(forImage: image) else {return}
        if result == "hotdog"{
            self.isHotDog = true
        }else{
            self.isHotDog = false
        }
        displayResult()
        viewReference.imageView.image = image
    }
    
    func coreMLResult(forImage image : UIImage) -> String?{
        
        if let pixelImage = ImageProcessor.pixelBuffer(forImage: image.cgImage!){
            guard let scene = try? model.prediction(image: pixelImage) else {fatalError()}
            return scene.target
        }
        
        return nil
    }
    
    func displayResult(){
        if isHotDog{
            self.view.addSubview(viewReference.hotDogFeedBack)
            viewReference.hotDogFeedBack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            viewReference.hotDogFeedBack.widthAnchor.constraint(equalToConstant: 350).isActive = true
            viewReference.hotDogFeedBack.heightAnchor.constraint(equalToConstant: 150).isActive = true
            viewReference.hotDogFeedBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            
        }else{
            self.view.addSubview(viewReference.notHotDogFeedBack)
            viewReference.notHotDogFeedBack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            viewReference.notHotDogFeedBack.widthAnchor.constraint(equalToConstant: 350).isActive = true
            viewReference.notHotDogFeedBack.heightAnchor.constraint(equalToConstant: 150).isActive = true
            viewReference.notHotDogFeedBack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        }
        
    }
    
}


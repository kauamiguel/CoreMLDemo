//
//  GameController.swift
//  RockPapperScissorsGame
//
//  Created by Kaua Miguel on 26/02/24.
//

import UIKit

class GameController : UIViewController{
    
    let gameView = GameView()
    
    let coreMlResult = CoreMLResult()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameView.setupView(view: self.view)
        gameView.takePictureButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction(){
        var picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.cameraFlashMode = .off
        picker.cameraCaptureMode = .photo
        present(picker, animated: true)
        takePicture()
    }
    
}

extension GameController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //Function that get the picture taken
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        
        guard let result = coreMlResult.result(image: image) else { return }
        
    }
    
    //Function that create a dountDown to take an automatic picture
    func takePicture(){
        var timeLeft = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in

            if timeLeft == 0{
                
                timer.invalidate()
                return
            }
            
            print(timeLeft)
            timeLeft -= 1
        }
    }
}

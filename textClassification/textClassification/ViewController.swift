//
//  ViewController.swift
//  textClassification
//
//  Created by Kaua Miguel on 28/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    let textField : UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.placeholder = "Placeholder"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 25)
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        textField.delegate = self
        self.view.addSubview(textField)
        configConstraints()
    }
    
    private func configConstraints(){
        
        NSLayoutConstraint.activate([self.textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor), self.textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor), self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20), self.textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)])
    }
}


extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text{
            coreMlProcess(for: text)
        }
        return true
    }
    
    func coreMlProcess(for text : String){
        let model = try? textClassificationModel(configuration: .init())
        let input = textClassificationModelInput(text: text)
        
        guard let output = try? model?.prediction(input: input) else { return }
        print(output.label)
    }
}

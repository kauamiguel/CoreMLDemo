//
//  ViewController.swift
//  CoreMLObjectDetection
//
//  Created by Kaua Miguel on 21/02/24.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    override func viewDidLoad() {

        super.viewDidLoad()
        
        getCamera()
        
    }

    func getCamera(){
        //Start camera
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let inputData = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        captureSession.addInput(inputData)
        
        captureSession.startRunning()
        
        //Add the previewLayer to see the camera on the UIView
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.frame
        self.view.layer.addSublayer(previewLayer)
        
        //This object will monitor what is happanning every time the frame is being caputure in the frame camera
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "VideoQueue"))
        captureSession.addOutput(dataOutput)
        
        
    }
    
    //Function that get the new frame of the camera

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer : CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        guard let coremlModel = try? VNCoreMLModel(for: SqueezeNet().model) else { return }
        
        let request = VNCoreMLRequest(model: coremlModel) { vnRequest, error in
            
            // get the results of the classification
            guard let results = vnRequest.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            print(firstObservation.identifier)
        }
        
        //This VNImageRequestHandler is responsible for analysing the image through the image property
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer).perform([request])
        
    }
    
}


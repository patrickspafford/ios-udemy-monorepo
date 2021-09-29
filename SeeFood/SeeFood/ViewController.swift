//
//  ViewController.swift
//  SeeFood
//
//  Created by Patrick Spafford on 8/30/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let shownImage = image {
            imageView.image = shownImage
            guard let ciImage = CIImage(image: shownImage) else {
                fatalError("Could not convert to CIImage")
            }
            detect(image: ciImage)
            
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: config).model) else {
            fatalError("Could not load model")
        }
        let request = VNCoreMLRequest(model: model) {(req, error) in
            guard let results = req.results as? [VNClassificationObservation] else {
                fatalError("Could not convert results into observations")
            }
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "Hotdog"
                } else {
                    self.navigationItem.title = "Not Hotdog"
                }
            }
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch  {
            print(error)
        }
    }
    
}


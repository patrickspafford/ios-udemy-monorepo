//
//  ViewController.swift
//  WhatFlower
//
//  Created by Patrick Spafford on 9/1/21.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let picker = UIImagePickerController()
    var wikiManager = WikiManager()

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        wikiManager.delegate = self
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        picker.cameraCaptureMode = .photo
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("Not able to grab edited image")
            self.picker.dismiss(animated: true, completion: nil)
            return
        }
        imageView.image = image
        guard let ciImage = CIImage(image: image) else {
            fatalError("Could not convert to CIImage")
        }
        self.detectFlower(ciImage)
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func detectFlower(_ ciImage: CIImage) {
        let config = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: config).model) else {
            fatalError("Could not create model")
        }
        let request = VNCoreMLRequest(model: model) {(req, err) in
            guard let results = req.results as? [VNClassificationObservation] else {
                fatalError("Could not get results from model")
            }
            if let title = results.first?.identifier.capitalized {
                self.navigationItem.title = title
                let urlFriendlyTitle = title.replacingOccurrences(of: " ", with: "%20")
                self.wikiManager.search(query: urlFriendlyTitle)
            } else {
                self.navigationItem.title = "Unknown"
            }
        }
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            fatalError("Request to model failed.")
        }
    }
    
}

extension ViewController: WikiManagerDelegate {
    func didReceiveError(err: String) {
        print("Did receive Wiki error: \(err)")
    }
    
    func didReceiveArticle(article: WikiArticle) {
        print("Did receive article: \(article)")
    }
}




//
//  DataConfigureViewController.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import Foundation
import UIKit
import Vision

class DataEditViewController:UIViewController{
    
    let dataEditModel = DataEditModel()
    let util = Util()
    
    var image:UIImage? = nil
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setNavigationBarButton()
        dateLabel.text = util.dateFormatter.string(from: dataEditModel.date)
        if image != nil {
            imageView.image = image
            runRecognizeText()
        }
    }
    
    func setNavigationTitle(){
        navigationItem.title = "講義タイトル※要編集"//styt
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setNavigationBarButton(){
        let rightButtonActionSelector: Selector = #selector(saveRecord)
        let rightBarButton = UIBarButtonItem(image:UIImage(systemName: "square.and.arrow.down"),style: .plain, target: self, action: rightButtonActionSelector)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func saveRecord(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func runRecognizeText(){
        guard let cgImage = image?.cgImage else { return }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest(completionHandler: recognizesTextHandler)
        request.recognitionLanguages = ["ja-JP"]
        do{
            try requestHandler.perform([request])
        }catch{
            print("Unable to perform the requests:\(error).")
        }
    }
    
    func recognizesTextHandler(request: VNRequest, error: Error?){
        guard let observations = request.results as? [VNRecognizedTextObservation] else{return}
        let recognizedStrings = observations.compactMap{ observation in
            return observation.topCandidates(1).first?.string
        }
        let joinedStrings = recognizedStrings.joined(separator: "\n")
        textView.text = joinedStrings
    }
    
}

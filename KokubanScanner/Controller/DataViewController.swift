//
//  DataViewController.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import Foundation
import UIKit

class DataViewController:UIViewController{
    
    let dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setNavigationBarButton()
    }
    
    func setNavigationTitle(){
        navigationItem.title = "講義名タイトル※要編集"//styt
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setNavigationBarButton(){
        let rightButtonActionSelector: Selector = #selector(showEditView)
        let rightBarButton = UIBarButtonItem(image:UIImage(systemName: "pencil"),style: .plain, target: self, action: rightButtonActionSelector)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func showEditView(){
        let storyboard = UIStoryboard(name: "DataEditView", bundle: nil)
        guard let dataEditViewController = storyboard.instantiateViewController(withIdentifier: "DataEditViewController") as? DataEditViewController else{return}
        navigationController?.pushViewController(dataEditViewController, animated: true)
    }
}

//
//  LectureViewController.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import Foundation
import UIKit

class LectureViewController:UIViewController{
    
    let lectureModel = LectureModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lectureTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setNavigationBarButton()
        lectureTableView.delegate = self
        lectureTableView.dataSource = self
        searchBar.delegate = self
        configureAddButton()
    }
    
    func setNavigationTitle(){
        navigationItem.title = "講義一覧"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func setNavigationBarButton(){
        let rightButtonActionSelector: Selector = #selector(showMemberView)
        let rightBarButton = UIBarButtonItem(image:UIImage(systemName: "person"),style: .plain, target: self, action: rightButtonActionSelector)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func showMemberView(){
        let storyboard = UIStoryboard(name: "LectureView", bundle: nil)
        guard let memberViewController = storyboard.instantiateViewController(withIdentifier: "MemberViewController") as? MemberViewController else{return}
        self.navigationController?.pushViewController(memberViewController, animated: true)
    }
    
    @IBAction func addButton(_ sender: UIButton) {
        let alert: UIAlertController = UIAlertController(title: "画像選択", message: "画像の読み取り方法を選択してください。", preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "カメラで撮影する", style: .default, handler: {(action) -> Void in
            self.activeCamera()
        })
        let picture = UIAlertAction(title: "写真から読み込む", style: .default, handler: {(action) -> Void in
            self.activePicture()
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: {(action) -> Void in
            return
        })
        
        
        alert.addAction(camera)
        alert.addAction(picture)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func activeCamera(){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    private func activePicture(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.mediaTypes = ["public.image"]
        present(picker, animated:true)
    }
    
    func configureAddButton(){
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
}

extension LectureViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DataView", bundle: nil)
        guard let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as? DataViewController else{return}
        navigationController?.pushViewController(dataViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension LectureViewController:UISearchBarDelegate{
    
    var toolbar: UIToolbar{
        let toolbarRect = CGRect(x: 0,y: 0, width:view.frame.size.width,height: 35)
        let toolbar = UIToolbar(frame: toolbarRect)
        let doneItem = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(didTapFinishButton))
        toolbar.setItems([doneItem], animated: modalPresentationCapturesStatusBarAppearance)
        return toolbar
    }
    
    @objc func didTapFinishButton(){
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        if let word = searchBar.text {
            print(word)
        }
    }
    
    func configureSearchBar(){
        searchBar.inputAccessoryView = toolbar
        searchBar.placeholder = "過去の日記の検索"
        searchBar.keyboardType = .asciiCapable
    }
}

extension LectureViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as! UIImage
        
        let storyboard = UIStoryboard(name: "DataEditView", bundle: nil)
        guard let dataEditViewController = storyboard.instantiateViewController(withIdentifier: "DataEditViewController") as? DataEditViewController else{return}
        navigationController?.pushViewController(dataEditViewController, animated: true)
        
        dataEditViewController.image = image
        
        
        self.dismiss(animated: true, completion: nil)
    }
}

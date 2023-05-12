//
//  GroupViewController.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import Foundation
import UIKit

class GroupViewController:UIViewController{
    
    let groupModel = GroupModel()
    
    @IBOutlet weak var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        
        groupTableView.delegate = self
        groupTableView.dataSource = self
    }
    
    func setNavigationTitle(){
        navigationItem.title = "参加グループ一覧"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}

extension GroupViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "LectureView", bundle: nil)
        guard let lectureViewController = storyboard.instantiateViewController(withIdentifier: "LectureViewController") as? LectureViewController else{return}
        self.navigationController?.pushViewController(lectureViewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


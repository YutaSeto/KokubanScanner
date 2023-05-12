//
//  ViewController.swift
//  KokubanScaner
//
//  Created by setoon on 2023/05/11.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginModel = LoginModel()

    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwardTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var makeAccountButton: UIButton!
    @IBOutlet weak var foregetPasswardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
    }

    @IBAction func loginButton(_ sender: UIButton) {
        pushLoginButton()
    }
    
    private func pushLoginButton(){
        let storyboard = UIStoryboard(name: "GroupView", bundle: nil)
        guard let groupViewController = storyboard.instantiateViewController(withIdentifier: "GroupViewController") as? GroupViewController else{return}
        navigationController?.pushViewController(groupViewController, animated: true)
    }
    
    
    func setNavigationTitle(){
        navigationItem.title = "ログイン"
        navigationController?.navigationBar.barStyle = .default
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


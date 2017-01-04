//
//  ViewController.swift
//  Chat
//
//  Created by MacBookPro on 2017. 1. 3..
//  Copyright © 2017년 EDCAN. All rights reserved.
//

import UIKit
import Firebase

class SignViewController: UIViewController, UITextFieldDelegate {
    let defaultPadding : CGFloat = 16
    
    var loginButton = UIButton()
    var registerButton = UIButton()
    var emailField = UITextField()
    var passwordField = UITextField()
    var confirmAlertAction = UIAlertAction(
        title: "승인",
        style: UIAlertActionStyle.default,
        handler: nil
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Chat Sign"
        
        loginButton.frame = CGRect(
            x: defaultPadding,
            y: self.view.frame.height - 64 - defaultPadding - 32,
            width: self.view.frame.width - defaultPadding - defaultPadding,
            height: 32
        )
        registerButton.frame = CGRect(
            x : defaultPadding,
            y : self.view.frame.height - 64,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 32
        )
        
        emailField.frame = CGRect(
            x : defaultPadding,
            y : self.view.frame.height / 2 - 32 - defaultPadding,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 32
        )
        passwordField.frame = CGRect(
            x : defaultPadding,
            y : self.view.frame.height / 2,
            width : self.view.frame.width - defaultPadding - defaultPadding,
            height : 32
        )
        
        loginButton.setTitle(
            "Email 로그인",
            for: UIControlState.normal
        )
        loginButton.addTarget(self, action: #selector(loginButtonDidSelect), for: .touchUpInside)
        loginButton.backgroundColor = .black
        registerButton.setTitle(
            "Email 가입",
            for: UIControlState.normal
        )
        registerButton.addTarget(self, action: #selector(registerButtonDidSelect), for: .touchUpInside)
        registerButton.backgroundColor = .black
        
        emailField.placeholder = "Email"
        emailField.borderStyle = .roundedRect
        passwordField.placeholder = "Password"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        emailField.delegate = self
        passwordField.delegate = self
        
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
    }
    
    func size(for string : String, width : CGFloat, font : UIFont) -> CGSize {
        let rect = string.boundingRect(
            with: CGSize(width : width, height : 0),
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [NSFontAttributeName : font],
            context: nil
        )
        
        return rect.size
    }
    
    func loginButtonDidSelect(){
        guard
            let textEmail = self.emailField.text,
            let textPassword = self.passwordField.text
        else { return }
        
        
        FIRAuth.auth()?.signIn(withEmail : textEmail, password : textPassword){ (user, error) in
            if let error = error{
                let alertController = UIAlertController(
                    title : "로그인 에러",
                    message : error.localizedDescription,
                    preferredStyle : .alert
                )
                alertController.addAction(self.confirmAlertAction)
                
                self.present(alertController, animated : true, completion : nil)
            }else{
                guard let user = user else{ return }
                
                let alertController = UIAlertController(
                    title : "로그인 성공",
                    message : user.email,
                    preferredStyle : .alert
                )
                alertController.addAction(self.confirmAlertAction)
                
                self.present(alertController, animated : true, completion : nil)
                
            }
        }
    }
    
    func registerButtonDidSelect(){
        let alertController = UIAlertController(
            title : "Email 가입",
            message : "Email계정을 새로 생성합니다",
            preferredStyle : .alert
        )
        alertController.addTextField { (textField) in
            textField.placeholder = "Email"
        }
        alertController.addTextField{ (textField) in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        alertController.addTextField{ (textField) in
            textField.placeholder = "Password Check"
            textField.isSecureTextEntry = true
        }
        alertController.addAction(
            UIAlertAction(
                title: "가입",
                style: .default,
                handler: { (alertAction) in
                    guard
                        let emailField = alertController.textFields?[0],
                        let passwordField = alertController.textFields?[1],
                        let passwordCheckField = alertController.textFields?[2],
                        let textEmail = emailField.text,
                        let textPassword = passwordField.text,
                        let textCheckPassword = passwordCheckField.text
                    else { return }
                    
                    if textPassword != textCheckPassword{
                        let alertController = UIAlertController(
                            title : "가입 에러",
                            message : "비밀 번호를 다시 확인해주세요",
                            preferredStyle : .alert
                        )
                        alertController.addAction(self.confirmAlertAction)
                        
                        self.present(alertController, animated : true, completion : nil)
                        return
                    }  //비밀 번호 확인 불일치
                    
                    FIRAuth.auth()?.createUser(withEmail: textEmail, password : textPassword){ (user, error) in
                        if let error = error{
                            let alertController = UIAlertController(
                                title : "가입 에러",
                                message : error.localizedDescription,
                                preferredStyle : .alert
                            )
                            alertController.addAction(self.confirmAlertAction)
                            
                            self.present(alertController, animated : true, completion : nil)
                        }else{
                            self.emailField.text = textEmail
                            self.passwordField.text = textPassword
                            self.loginButtonDidSelect()
                        }
                    }
                }
            )
        )
        alertController.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel,
                handler: nil
            )
        )
        
        self.present(alertController, animated : true, completion : nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}


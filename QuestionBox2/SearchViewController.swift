//
//  SearchViewController.swift
//  QuestionBox2
//
//  Created by 水野 隆夫 on 2018/05/13.
//  Copyright © 2018年 pad1053. All rights reserved.
//

import UIKit
import  Firebase

class SearchViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

  var fontSize = 14
  
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var textView: UITextView!
  
  var label = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    textField.delegate = self
    textView.delegate  = self
    
    textView.layer.borderWidth = 10
    textView.layer.borderColor = UIColor.blue.cgColor
    textView.textContainerInset = UIEdgeInsetsMake(20, 10, 10, 10)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func updateQuestion() {
    let params: [String:Any] = ["question": textView.text, "font": fontSize]
    let userRef = Firestore.firestore()
    userRef.collection("UserName").document(textField.text!).updateData(params)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if textView.becomeFirstResponder() {
        textView.resignFirstResponder()
    }
    if textField.becomeFirstResponder() {
      textField.resignFirstResponder()
    }
  }
  
  @IBAction func plus(_ sender: Any) {
    fontSize = fontSize + 1
    textView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
  }
  
  @IBAction func minus(_ sender: Any) {
    fontSize = fontSize - 1
    textView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
  }

  @IBAction func back(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func post(_ sender: Any) {
    updateQuestion()
  }
  
  
}

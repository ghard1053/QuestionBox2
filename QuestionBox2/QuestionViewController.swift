//
//  QuestionViewController.swift
//  QuestionBox2
//
//  Created by 水野 隆夫 on 2018/05/12.
//  Copyright © 2018年 pad1053. All rights reserved.
//

import UIKit
import Firebase
import TwitterKit

class QuestionViewController: UIViewController, UITextViewDelegate, TWTRComposerViewControllerDelegate {

  var username = String()
  
  @IBOutlet weak var questionTextView: UITextView!
  @IBOutlet weak var answerTextView: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var postImageView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    answerTextView.delegate = self
    answerTextView.layer.borderWidth = 10
    answerTextView.layer.borderColor = UIColor.blue.cgColor
    answerTextView.textContainerInset = UIEdgeInsetsMake(20.0, 10.0, 10.0, 10.0)

    questionTextView.delegate = self
    questionTextView.layer.borderWidth = 10
    questionTextView.layer.borderColor = UIColor.blue.cgColor
    questionTextView.textContainerInset = UIEdgeInsetsMake(20.0, 10.0, 10.0, 10.0)
    
    titleLabel.text = username
    
    //ユーザーのnameをfirebaseから取ってくる
    readUserNames()
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    answerTextView.resignFirstResponder()
  }
  
  func getScreenShot() {
    let rect = questionTextView.bounds
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    let context = UIGraphicsGetCurrentContext()!
    questionTextView.layer.render(in: context)
    let caputureImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    postImageView.image = caputureImage
  }
  
  @IBAction func reload(_ sender: Any) {
    readUserNames()
  }
  
  @IBAction func postTwitter(_ sender: Any) {
    getScreenShot()
    
    let composer = TWTRComposer()
    composer.setText(answerTextView.text)
    composer.setImage(postImageView.image)
    composer.setURL(URL(string: "https://critiq.jp/"))
    composer.show(from: self, completion: nil)
  }
  
  
  func readUserNames() {
    let db = Firestore.firestore()
    db.collection("UserName").whereField("name", isEqualTo: username).getDocuments { (snapshot, error) in
      if error != nil {
        
      } else {
        for document in (snapshot?.documents)! {
          if let question = document.data()["question"] as? String {
            self.questionTextView.text = question
            if let font = document.data()["font"] as? CGFloat {
              self.questionTextView.font = UIFont.systemFont(ofSize: font)
            }
          }
        }
      }
    }
  }

}

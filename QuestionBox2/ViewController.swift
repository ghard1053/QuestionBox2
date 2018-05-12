//
//  ViewController.swift
//  QuestionBox2
//
//  Created by 水野 隆夫 on 2018/05/12.
//  Copyright © 2018年 pad1053. All rights reserved.
//

import UIKit
import TwitterKit
import Firebase

class ViewController: UIViewController {

  var username = String()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func login(_ sender: Any) {
    TWTRTwitter.sharedInstance().logIn { (session, error) in
      if let sess = session {
        self.username = sess.userName
      }
      
      let okorNot = UserDefaults.standard.string(forKey: "OK")
      if okorNot == nil {
        //Firebaseにusernameを飛ばす
        self.postUserName()
        UserDefaults.standard.set("OK", forKey: "OK")

      } else {
        
      }
      
      self.performSegue(withIdentifier: "next", sender: nil)
      
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let questionVC = segue.destination as! QuestionViewController
    questionVC.username = self.username
  }
  
  func postUserName() {
    let username = self.username
    let params: [String:Any] = ["name": username, "question": ""]
    
    let userRef = Firestore.firestore()
    userRef.collection("UserName").document(username).setData(params)
  }
  

}


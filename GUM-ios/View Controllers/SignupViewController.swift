import UIKit
import Firebase

class SignupViewController: UIViewController {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var emailTextView: UITextField!
    @IBOutlet weak var passwordTextView: UITextField!
    let db = Firestore.firestore()
    var emailinfo: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailTextView.becomeFirstResponder()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var isExpand: Bool = false
    @objc func keyboardAppear () {
        if !isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height + 300)
            isExpand = true
        }
    }
    
    @objc func keyboardDisappear () {
        if isExpand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.scrollView.frame.height - 300)
            isExpand = false
        }
    }

    @IBAction func createAccount(_ sender: Any) {
        self.view.endEditing(true)
        let email = emailTextView.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordTextView.text?.trimmingCharacters(in: .whitespaces)
      // checks if email / password is valid then adds user
        if(email != "" && isValidEmail(emailID: email!) && password != "") {

            let docRef = db.collection("Users").document(email!)

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {

                    let alert = UIAlertController(title: "Error", message: "Email already exists", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                } else {
                    // add email and password
                    self.db.collection("Users").document(self.emailTextView.text!).setData([
                        "Password": password!,
                        "Points": 0,
                        "Score": 0,
                        "FitnessLvl": " ",
                        "AvatarUrl": "orange_avatar.png",
                        "UnlockedAvatars": ["orange_avatar.png"],
                        "Schedule": ["9:00 AM", "10:00 AM", "11:00 AM", "2:00 PM", "3:00 PM", "4:00 PM"],
                        "Groups": [],
                    ]) { (err) in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            let doc = self.db.collection("Users").document(email!)
                            doc.getDocument {(document, error) in
                                if let document = document, document.exists {
                                    self.emailinfo = email!
                                    print(document)
                                    self.performSegue(withIdentifier: "introVideo", sender: document)
                                }
                           }
                }
            }

        }
            }
        }
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "introVideo"){
            let destinationVC = segue.destination as! DemoVideosViewController
            destinationVC.email = emailinfo
        }
    }
}

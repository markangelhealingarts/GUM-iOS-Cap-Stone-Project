import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    let db = Firestore.firestore()

    var emailInfo: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        overrideUserInterfaceStyle = .light
    }

    @IBAction func login(_ sender: Any) {
        self.view.endEditing(true)
        var email = emailTextField.text?.trimmingCharacters(in: .whitespaces)
        var password = passwordTextField.text?.trimmingCharacters(in: .whitespaces)
        
//----------------------------------------------------
// HARDCODED LOGIN -- COMMENT OUT BEFORE PUBLISHING
// COMMENT OUT LINES 49-59
// for development to skip login
//        class Test {
//            var email: String?
//            var password: String?
//        }
//
//        let test = Test()
//        test.email = "test0@gmail.com"
//        test.password = "12345"
//
//        email = test.email
//        password = test.password
//-----------------------------------------------------
        

        if(email != "" && isValidEmail(emailID: email!) && password != ""){

            let docRef = db.collection("Users").document(email!)
            

            docRef.getDocument { (document, error) in
                if let document = document, document.exists {

                    self.emailInfo = email! //send this info to MainViewController
                    let data = document.data() //access the data
                    let passwordStored = data?["Password"] //get password

                    if(password == passwordStored as? String){
                        self.performSegue(withIdentifier: "loginToMain", sender: document)

                    }else{
                        let alert = UIAlertController(title: "Error", message: "Password is not correct", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }

                } else {

                    let alert = UIAlertController(title: "Error", message: "Email doesn't exist", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
            }



        } else {
            if(email == "" || password == ""){
                let alert = UIAlertController(title: "Error", message: "Email/Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "Not valid email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if(segue.identifier == "loginToMain"){
            let destinationVC = (segue.destination as! UINavigationController).topViewController as! MainPageViewController

            destinationVC.email = emailInfo
        }

    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

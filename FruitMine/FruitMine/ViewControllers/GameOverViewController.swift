//
//  GameOverViewController.swift
//  FruitMine
//
//  Created by AlexKotov on 22.03.22.
//

import UIKit

protocol GameOverViewControllerDelegate: AnyObject {
    func goHome()
}

class GameOverViewController: UIViewController {
    weak var delegate: GameOverViewControllerDelegate?
    
    var score: Int?

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "\(score ?? 0)"
        addKeyboardObservers()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.95)
        nameTextField.delegate = self
    }
    
    func saveScore() {
        var scores = Storage.shared.scores
        let newScore: Score = Score(playerName: nameTextField.text ?? "Player", score: score ?? 0)
        scores.append(newScore)
        Storage.shared.scores = scores
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        saveScore()
        self.view.window?.rootViewController?.dismiss(animated: false) {
            self.delegate?.goHome()
        }
    }
    
}

extension GameOverViewController {
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIApplication.keyboardWillHideNotification, object: nil)
        hideKeyboardOnTap()
    }
    
    @objc func keyboardWillAppear(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = keyboardFrame.height
            let rect = self.homeButton.convert(self.homeButton.frame, to: self.stackView)
            self.scrollView.scrollRectToVisible(rect, animated: false)
        }

    }
    
    @objc func keyboardWillDisappear(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.3
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = 0
        }
    }
    
    func hideKeyboardOnTap() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func tap() {
        view.endEditing(true)
    }
}

extension GameOverViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 12
    }
}

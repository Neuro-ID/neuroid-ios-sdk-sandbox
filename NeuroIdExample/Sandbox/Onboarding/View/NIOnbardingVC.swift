//
//  NIOnbardingVC.swift
//  NeuroIdExample
//
//  Created by jose perez on 12/05/22.
//
import UIKit
import NeuroID
final class NIOnbardingVC: UIViewController {
    @IBOutlet weak var sessionidlbl: UITextField!
    @IBOutlet weak var firstNamelbl: UITextField!
    @IBOutlet weak var lastNamelbl: UITextField!
    @IBOutlet weak var dateBirthlbl: UITextField!
    @IBOutlet weak var emaillbl: UITextField!
    @IBOutlet weak var homeCitylbl: UITextField!
    @IBOutlet weak var homeZipCodelbl: UITextField!
    @IBOutlet weak var phoneNumberlbl: UITextField!
    @IBOutlet weak var employerlbl: UITextField!
    @IBOutlet weak var employerAddresslbl: UITextField!
    @IBOutlet weak var employerPhoneNumberlbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarImage()
        setupDateBirthPicker()
    }
    /// Create and setup the date picker as the input for date birth
    private func setupDateBirthPicker() {
        // Create Data picker and add to the input view
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: view.frame.width,
                                                    height: 216))
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        self.dateBirthlbl.inputView = datePicker
        // Create Toolbar to select date and add to the input accessory view
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.width,
                                              height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction)),
                          UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                          UIBarButtonItem(barButtonSystemItem: .done, target: self, action:  #selector(doneAction))],
                         animated: true)
        self.dateBirthlbl.inputAccessoryView = toolBar
    }
    /// Setup navigation bar image with logo
    private func setupNavBarImage() {
        self.navigationController?.isNavigationBarHidden = false
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFill
        let image = UIImage(named: "NeuroID_logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    /// Hide the date picker
    @objc func cancelAction() {
        self.dateBirthlbl.resignFirstResponder()
    }
    /// Transform date into text and show it
    @objc func doneAction() {
        if let datePickerView = self.dateBirthlbl.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let dateString = dateFormatter.string(from: datePickerView.date)
            self.dateBirthlbl.text = dateString
            self.dateBirthlbl.resignFirstResponder()
        }
    }
    @IBAction func continueAction(_ sender: Any) {
        let vc = NILoanOptionsVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

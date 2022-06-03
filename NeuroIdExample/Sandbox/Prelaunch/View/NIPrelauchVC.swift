//
//  NIPrelauchVC.swift
//  NeuroIdExample
//
//  Created by jose perez on 12/05/22.
//
import UIKit
import Neuro_ID
final class NIPrelauchVC: UIViewController {
    @IBOutlet weak var versionLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLbl.text = NeuroID.getSDKVersion()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    @IBAction func ContinueAction(_ sender: Any) {
        let vc = NIOnbardingVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

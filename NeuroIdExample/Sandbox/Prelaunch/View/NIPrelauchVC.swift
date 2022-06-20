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
        versionLbl.text = getCurrentVersion()
    }
    ///
    private func getCurrentVersion() -> String {
        var config: [String: Any]?
        if let infoPlistPath = Bundle.main.url(forResource: "Info", withExtension: "plist") {
            do {
                let infoPlistData = try Data(contentsOf: infoPlistPath)
                if let dict = try PropertyListSerialization.propertyList(from: infoPlistData, options: [], format: nil) as? [String: Any] {
                    config = dict
                }
            } catch {
                print(error)
            }
        }
        if let version = config?["InternalCurrentVersion"] as? String {
            return version
        }
        return NeuroID.getSDKVersion() ?? "1.0.0"
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

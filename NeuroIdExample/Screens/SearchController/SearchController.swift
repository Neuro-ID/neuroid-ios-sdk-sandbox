import UIKit
import CoreMotion
import CoreML

class SearchController: UIViewController {
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var hotelNameTextField: UITextField!
    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var filterView: UIView!

    var selectedCity: City? {
        didSet {
            cityLabel.text = selectedCity?.city_name
        }
    }
    var filterOption: FilterOption?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let motion = CMMotionManager()
        // Begin test
        let ped = CMPedometer()

        if (CMPedometer.isStepCountingAvailable()) {
            print("here")
        }
//        GYRO
//         Read the most recent gyroscope value
//        motion.gyroData?.rotationRate.x
//        motion.gyroData?.rotationRate.y
//        motion.gyroData?.rotationRate.z

//         How frequently to read gyroscope updates,
//         in seconds
        motion.gyroUpdateInterval = 0.1

        // Start receiving gyroscope updates
        // on a specific thread
        motion.startGyroUpdates(to: .main) { (data, error) in
            // Handle rotation update
            if let data = motion.gyroData {
                let x = data.rotationRate.x
               let y = data.rotationRate.y
               let z = data.rotationRate.z
//               print("GYRO x: \(x), y:\(y), z\(z)")
            }
        }
        if motion.isAccelerometerAvailable {
              motion.accelerometerUpdateInterval = 1.0 / 60.0  // 60 Hz
              motion.startAccelerometerUpdates()

              // Configure a timer to fetch the data.
              var timer = Timer(fire: Date(), interval: (1.0/60.0),
                    repeats: true, block: { (timer) in
                 // Get the accelerometer data.
                 if let data = motion.accelerometerData {
                    let x = data.acceleration.x
                    let y = data.acceleration.y
                    let z = data.acceleration.z
//                    print("ACCELEROMETER x: \(x), y:\(y), z\(z)")
                 }
              })
            

              // Add the timer to the current run loop.
            RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
           }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }


    func setupView() {
        hotelNameTextField.id = "hotelNameTextField"
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        searchButton.setTitleColor(Colors.colorTextAlt, for: .normal)
        searchButton.titleLabel?.font = .boldSystemFont(ofSize: 15)
        searchButton.backgroundColor = Colors.colorPrimary

        cityLabel.font = .systemFont(ofSize: 13)
        cityLabel.textColor = Colors.colorText
        locationView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openDestination)))

        hotelNameTextField.font = .systemFont(ofSize: 13)
        hotelNameTextField.textColor = Colors.colorText

        filterLabel.font = .systemFont(ofSize: 13)
        filterLabel.textColor = Colors.colorText
        filterView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openSearchFilter)))

    }

    // MARK: Actions

    @objc func hideKeyboard() {
        view.endEditing(true)
    }

    @objc func openDestination() {
        let vc = UIStoryboard(name: "SearchCityController", bundle: nil).instantiateViewController(withIdentifier: "SearchCityController") as! SearchCityController
        vc.selectCityAction = { [weak self] city in
            self?.selectedCity = city
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func openSearchFilter() {
        let vc = UIStoryboard(name: "FilterController", bundle: nil).instantiateViewController(withIdentifier: "FilterController") as! FilterController
        vc.didSelectOption = { [weak self] option in
            self?.filterOption = option
            if let filters = option {
                let stars = "Stars: " + filters.stars.sorted().map { return "\($0)" }.joined(separator: ",")
                let price = "Price from $\(filters.lowerPrice) to $\(filters.upperPrice)"
                self?.filterLabel.text = "\(stars); \(price)"
            }

        }
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func searchClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "ResultController", bundle: nil).instantiateViewController(withIdentifier: "ResultController")
        navigationController?.pushViewController(vc, animated: true)

    }
}

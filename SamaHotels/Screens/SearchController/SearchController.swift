import UIKit

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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupView() {
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
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        let vc = UIStoryboard(name: "ResultController", bundle: nil).instantiateViewController(withIdentifier: "ResultController")
        navigationController?.pushViewController(vc, animated: true)
        
    }
}





//extension SearchController : SearchLocationProtocol {
//    func selectLocation(_ city: City) {
//        self.cityId = city.city_id
//        self.cityName = city.city_name
//        print("Selected City \(city.city_name)")
//        locationLabel.text = city.city_name
//    }
//}


//extension SearchController : SearchFilterProtocol {
//    func selectFilter(hotelStars: String, lowerPrice: String, upperPrice: String, guestRating: String) {
        
//        self.hotelStarStr = hotelStars
//        self.lowerPrice = lowerPrice
//        self.upperPrice = upperPrice
//        self.guestRating = guestRating
//
//        var langStar = language.search__stars
//        var langReview = language.search__review
//        if Common.instance.screenSize.width <= 320 {
//            // iPhone SE
//            langStar = language.search__starsS
//            langReview = language.search__reviewR
//
//        }
//
//        var filterStr = ""
//
//        if hotelStars == "" {
//            filterStr = "\(langStar) \(language.search__all)"
//        }else {
//            filterStr = "\(langStar) \(hotelStars)"
//        }
//
//        if let symbol = maxPrice?.currency_symbol {
//            filterStr += "/ \(symbol) \(lowerPrice) - \(symbol) \(upperPrice)"
//        }
//
//        if guestRating == "0" {
//            filterStr += "/ \(langReview) \(language.search__all)"
//        }else {
//            filterStr += "/ \(langReview) \(guestRating) +"
//        }
//        filterLabel.text = filterStr
//        
//        
//    }
//    
//    
//}
//
//
//
//
//

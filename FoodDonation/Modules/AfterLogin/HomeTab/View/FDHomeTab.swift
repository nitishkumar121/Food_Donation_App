//
//  FDHomeTab.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 31/05/22.
//

import UIKit
import MapKit

class FDHomeTab: UIViewController {

    // MARK: - Outlets
    @IBOutlet private(set) weak var homeTabCollectionView : UICollectionView!
    @IBOutlet private weak var searchView                 : UIView!
    @IBOutlet private weak var homeView                   : UIView!
    @IBOutlet private weak var mapView                    : MKMapView!
    @IBOutlet private weak var currentLocation            : UIButton!
    @IBOutlet private weak var searchRightButton          : UIButton!
    @IBOutlet private weak var mapListTableView           : UITableView!
    @IBOutlet private weak var collectionBackground       : UIView!

    // MARK: - Properties
    var flag : Bool = false
    var getCurrentLocation : ( () -> Void )?
    var instance = FDHomeTabModel()
    let annotaionLocations = [
        ["latitude" : 28.5355,"longitude" :77.3910],
        ["latitude" : 28.6692,"longitude" :77.4538],
        ["latitude" : 28.4744,"longitude" :77.5040]]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nibLoadTableViewCell()
        searchFieldShadowSet()
        LocationManager.requestGPS()
        mapListTableView.separatorStyle = .none
        nibLoadColectionViewCell()
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        LocationManager.shared.locationDelegate = self
        self.mapView.delegate = self
        getCurrentLocation?()
    }

    // MARK: -
    private func nibLoadColectionViewCell() {
        let nib = UINib(nibName: ViewController.IdentifierName.homeTabCell.value, bundle: nil)
        homeTabCollectionView.register(nib, forCellWithReuseIdentifier: ViewController.IdentifierName.homeTabCell.value)
    }

    private func searchFieldShadowSet() {
        searchView.dropShadow()
    }
    private func nibLoadTableViewCell () {
        let nib = UINib(nibName: ViewController.IdentifierName.homeMapListCell.value, bundle: nil)
        mapListTableView.register(nib, forCellReuseIdentifier: ViewController.IdentifierName.homeMapListCell.value)
    }

    func createAnnotations(locations : [[String:Any]]) {
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location["latitude"] as? CLLocationDegrees ?? 0, longitude: location["longitude"] as? CLLocationDegrees ?? 0)
                mapView.addAnnotation(annotation)
        }
    }

    // MARK: - Map List Button
    @IBAction private func mapListButton () {
        flag.toggle()
        if flag {
            mapView.isHidden = true
            homeTabCollectionView.isHidden = true
            collectionBackground.isHidden = true
            currentLocation.isHidden = true
            mapListTableView.isHidden = false
            searchRightButton.setImage(ImageAssets.icMapIcon.image, for: .normal)
        } else {
            mapView.isHidden = false
            homeTabCollectionView.isHidden = false
            currentLocation.isHidden = false
            collectionBackground.isHidden = false
            mapListTableView.isHidden = true
            searchRightButton.setImage(ImageAssets.icMapList.image, for: .normal)
        }
    }

    @IBAction private func currentLoactionButtonPressed(_ sender: UIButton) {
        mapView.removeAnnotations(mapView.annotations)
        LocationManager.requestGPS()
        createAnnotations(locations : annotaionLocations)
    }
}

extension FDHomeTab : UICollectionViewDelegate , UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = homeTabCollectionView.dequeueReusableCell(withReuseIdentifier: ViewController.IdentifierName.homeTabCell.value, for: indexPath) as? HomeTabCell else { return UICollectionViewCell()}
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 1.2 - 10, height: collectionView.bounds.height - 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDHomeFoodDetail.value, from: Storyboard.homeTab.value), animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
extension FDHomeTab : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mapListTableView.dequeueReusableCell(withIdentifier: ViewController.IdentifierName.homeMapListCell.value, for: indexPath) as? HomeMapListCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        switch indexPath.row % 3 {
        case 0 : cell.titleView.backgroundColor = ColorAssest.red.color
        case 1 : cell.titleView.backgroundColor = ColorAssest.yellow.color
        default :
            cell.titleView.backgroundColor = ColorAssest.blue.color
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CommonFunction.commonFunction.instantiate(vc: ViewController.fDHomeFoodDetail.value, from: Storyboard.homeTab.value), animated: true)
    }
}

// MARK: - Custom Protocol and Map View Protocol
extension FDHomeTab : ShowCurrentLocation , MKMapViewDelegate {
    func showCurrentLocation(location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)

    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//        let annotationIdentifier = ViewController.IdentifierName.annotationIdentifier.value
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
//        if annotationView == nil {
//            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
//
//            annotationView!.canShowCallout = true
//        } else {
//            annotationView!.annotation = annotation
//        }
//        var pinImage = ImageAssets.icmappins.image
//        pinImage = CommonFunction.commonFunction.resizeImage(image: pinImage , targetSize: CGSize(width: 35, height: 35)) ?? UIImage()
////        annotationView?.image = pinImage
//        let pinImage2 = ImageAssets.icmylocation.image
//        annotationView!.image = pinImage2
//        return annotationView
//    }
}

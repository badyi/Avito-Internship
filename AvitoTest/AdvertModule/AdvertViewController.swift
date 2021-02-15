//
//  ViewController.swift
//  AvitoTest
//
//  Created by Бадый Шагаалан on 16.01.2021.
//

import UIKit

final class AdvertViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        layout.estimatedItemSize = CGSize(width: width - 20, height: 100)
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(AdvertCell.self, forCellWithReuseIdentifier: AdvertCell.id)
        cv.register(AdvertHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AdvertHeaderView.id)
        cv.delegate = self
        cv.dataSource = self
        cv.isScrollEnabled = true
        cv.alwaysBounceVertical = true
        return cv
    }()
    
    var presenter: AdvertPresenterProtocol!
    var configurator: AdvertConfiguratorProtocol = AdvertConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurate(with: self)
        presenter.configurateView()
        collectionView.reloadData()
    }
}

extension AdvertViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.setSelected(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AdvertHeaderView.id, for: indexPath) as! AdvertHeaderView
            reusableview.configLabel(with: presenter.getTitle())

            reusableview.setNeedsLayout()
            reusableview.layoutIfNeeded()
            return reusableview
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.advertOptionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        _ = presenter.getAdvertOption(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter.didDisappear(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdvertCell.id, for: indexPath) as! AdvertCell
        if let option = presenter.getAdvertOption(at: indexPath) {
            cell.config(with: option)
        }
        cell.backgroundColor = .green
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
    }
}


extension AdvertViewController: AdvertViewProtocol {
    func reloadItems(at index: [IndexPath]) {
        collectionView.reloadItems(at: index)
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupNavBarLeftButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = .black
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func reloadItem(at index: IndexPath) {
        collectionView.reloadItems(at: [index])
    }
}

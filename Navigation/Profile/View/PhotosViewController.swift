//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 03.03.2022.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    // MARK: PROPERTIES
    
    private let viewModel: PhotosViewModel?
    private let coordinator: PhotosCoordinator?
    
    private let facade = ImagePublisherFacade()
    private var newPhotoArray = [UIImage]()
    
    private let imageProcessor = ImageProcessor()

    private var elapsedTimeTimer: Timer?
    private var refreshDataTimer: Timer?
    
    private var count: Double = 0
    private var secBeforeRefresh: Int = 1

    
    private var isShowAlert = false
    
    private lazy var collectionView: UICollectionView = {
        guard let layout = viewModel?.layout else { return UICollectionView() }
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifire)
        collection.dataSource = self
        collection.delegate = self
        return collection
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = self.view.center
        return indicator
    }()
    
    // MARK: INITS
    
    init(
        coordinator: PhotosCoordinator,
        viewModel: PhotosViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        collectionView.snp.makeConstraints { make in
            make.leading.top.trailing.bottom.equalTo(self.view)
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: - Task 10: refreshing cycle timer should run after the view are appear
    override func viewDidAppear(_ animated: Bool) {
        refreshData()
        cycleRefreshing()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        elapsedTimeTimer?.invalidate()
        elapsedTimeTimer = nil
        refreshDataTimer?.invalidate()
        refreshDataTimer = nil
        secBeforeRefresh = 1
        count = 0
    }
    
    func checkTimer() {
        if !newPhotoArray.isEmpty {
            print("Elapsed time: \(Constants.timeToString(sec: count))")
            elapsedTimeTimer?.invalidate()
            elapsedTimeTimer = nil
            if !isShowAlert {
                Constants.showElapsedTimeAlert(navCon: self.navigationController!, sec: count)
                isShowAlert = true
            }
            count = 0
        }
    }
  
    // MARK: - Task 10: run of cycle for refreshing by setted time
    func cycleRefreshing() {
        
        refreshDataTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.secBeforeRefresh -= 1
            self.refreshData()
            
            if self.secBeforeRefresh > 0 {
                print ("seconds before refresh: \(self.secBeforeRefresh)")
            }
        })
        
        refreshDataTimer?.fire()
        refreshDataTimer?.tolerance = 0.3
    }
    
    // MARK: - Task 10: method for refreshing of data (reloadData)
//    @objc
    func refreshData() {
        guard secBeforeRefresh == 0 else { return }
        
        newPhotoArray = [UIImage]()
        collectionView.reloadData()
        
        activityIndicator.startAnimating()
        imageProcessor.processImagesOnThread(sourceImages: ContentManager.shared.threadPhotosArray, filter: .colorInvert, qos: QualityOfService.userInteractive) { [unowned self] cgImages in
            self.newPhotoArray = cgImages.map({UIImage(cgImage: $0!)})
            DispatchQueue.main.async{
                self.collectionView.reloadData()
                self.activityIndicator.stopAnimating()
                
                self.secBeforeRefresh = 10
            }
        }
        
        elapsedTimeTimer = Timer.scheduledTimer(withTimeInterval: 0.035, repeats: true, block: { [weak self] _ in
            self?.count += 0.035
            self?.checkTimer()
        })
    }
    
    
}

//extension PhotosViewController: UICollectionViewDataSource, ImageLibrarySubscriber {
extension PhotosViewController: UICollectionViewDataSource {
    
    //    func receive(images: [UIImage]) {
    //        newPhotoArray = images
    //        collectionView.reloadData()
    //    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newPhotoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifire, for: indexPath) as? PhotosCollectionViewCell, let viewModel = viewModel else { return UICollectionViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath, array: newPhotoArray)
        cell.viewModel = cellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let viewModel = viewModel else { return CGSize() }
        let layout = viewModel.collectionViewLayout(collectionView: collectionView)
        return layout
    }
    
}

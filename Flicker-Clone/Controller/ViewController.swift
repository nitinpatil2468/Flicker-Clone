//
//  ViewController.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var collectionView:UICollectionView = {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    layout.scrollDirection = .vertical
    let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    cv.translatesAutoresizingMaskIntoConstraints = false
    cv.showsVerticalScrollIndicator = false
    cv.setCollectionViewLayout(layout, animated: false)
    cv.delegate = self
    cv.dataSource = self
    cv.register(PhotoCell.self, forCellWithReuseIdentifier: "cell")
    cv.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    return cv
}()
    
    var viewmodel = GridViewModel()
    var pages : Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureUI()
        viewmodel.vc = self
        viewmodel.page = 0
        viewmodel.getAllPhotos()
    }
    
    func configureUI(){

        self.navigationItem.title = "All Photos";
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)


        self.view.addSubview(collectionView)
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
      
    }
    
}


extension ViewController : UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return viewmodel.photoArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCell
        cell.data = viewmodel.photoArray[indexPath.row]
        return cell
     }
    
    func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width / 2 - 5, height: width / 2 - 5)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = PhotoContoller()
        vc.viewmodel.vc = PhotoContoller()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true) {
            vc.viewmodel.photoInfo = self.viewmodel.photoArray[indexPath.row]
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == viewmodel.photoArray.count - 1 ) { //it's your last cell
           //Load more data & reload your collection view
            pages = pages + 1
            viewmodel.page = pages
            print("pageNo : \(pages)")
            viewmodel.getAllPhotos()
            
         }
    }
    
    
    
}

  
    






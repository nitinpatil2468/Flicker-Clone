//
//  PhotoContoller.swift
//  Flicker-Clone
//
//  Created by Nitin Patil on 28/02/21.
//

import UIKit

class PhotoContoller: UIViewController, UIGestureRecognizerDelegate {

    let cardImage:LazyImageView = {
        let img = LazyImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 8
        img.isUserInteractionEnabled = true
        return img
    }()

    
    var viewmodel = PhotoViewModel()
    var isZooming = false
    var originalImageCenter:CGPoint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        viewmodel.vc = self
        
    }

    
     func configureUI(){
        
        self.navigationItem.title = "Photo";
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.addSubview(cardImage)

        cardImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom : view.bottomAnchor, right: view.rightAnchor)
       
        let leftButton = UIBarButtonItem(title:"Back", style: .plain, target: self, action: #selector(dissmiss))
        navigationItem.leftBarButtonItem = leftButton
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchPhoto(sender:)))
        pinch.delegate = self
        cardImage.addGestureRecognizer(pinch)
        let pan = UIPanGestureRecognizer(target: self, action:#selector(panPhoto(sender:)))
        pan.delegate = self
        cardImage.addGestureRecognizer(pan)

    }
    
    @objc func dissmiss(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func panPhoto(sender: UIPanGestureRecognizer) {
            if self.isZooming && sender.state == .began {
                self.originalImageCenter = sender.view?.center
            } else if self.isZooming && sender.state == .changed {
                let translation = sender.translation(in: view)
                if let view = sender.view {
                    view.center = CGPoint(x:view.center.x + translation.x,
                                          y:view.center.y + translation.y)
                }
                sender.setTranslation(CGPoint.zero, in: cardImage.superview)
            }
        }
//        
    @objc func pinchPhoto(sender:UIPinchGestureRecognizer) {
            
            if sender.state == .began {
                let currentScale = cardImage.frame.size.width / cardImage.bounds.size.width
                let newScale = currentScale*sender.scale
                
                if newScale > 1 {
                    self.isZooming = true
                }
            } else if sender.state == .changed {
                
                guard let view = sender.view else {return}
                
                let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                          y: sender.location(in: view).y - view.bounds.midY)
                let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                    .scaledBy(x: sender.scale, y: sender.scale)
                    .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
                
                let currentScale = cardImage.frame.size.width / cardImage.bounds.size.width
                var newScale = currentScale*sender.scale
                
                if newScale < 1 {
                    newScale = 1
                    let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                    cardImage.transform = transform
                    sender.scale = 1
                }else {
                    view.transform = transform
                    sender.scale = 1
                }
                
            } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
                
                guard let center = self.originalImageCenter else {return}
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.cardImage.transform = CGAffineTransform.identity
                    self.cardImage.center = center
                }, completion: { _ in
                    self.isZooming = false
                })
            }
            
        }
//    
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
        }

}

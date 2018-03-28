//
//  BaseViewController.swift
//  20180326-BrandonBarooah-NYCSchools
//
//  Created by Brandon Barooah on 3/26/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var loadingOverlay: UIView?
    var loadingTextLabel: UILabel?
    var loadingFrame:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingFrame = self.view.frame

        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        HideLoadingOverlay()
    }
    
    // Can be called from any view controller that extends this one, and is used to present a loading screen
    func PresentLoadingOverlay(_ title: String=""){
        DispatchQueue.main.async {
            if(self.loadingOverlay == nil){
                
                
                self.loadingOverlay = UIView(frame: self.loadingFrame!)
                self.loadingOverlay?.isHidden = false
                self.loadingOverlay?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
                
                
                if(!title.isEmpty){
                    self.loadingTextLabel = UILabel(frame: CGRect(x: (self.loadingOverlay?.center.x)!-((self.loadingOverlay?.frame.width)!/2),
                                                                  y: (self.loadingOverlay?.center.y)!,
                                                                  width: (self.loadingOverlay?.frame.width)!,
                                                                  height: 20))
                    self.loadingTextLabel?.text = title
                    self.loadingTextLabel?.textAlignment = .center
                    self.loadingTextLabel?.textColor = UIColor.white
                    self.loadingTextLabel?.center.x = (self.loadingOverlay?.center.x)!
                    self.loadingTextLabel?.center.y = (self.loadingOverlay?.center.y)!
                    self.loadingOverlay?.addSubview(self.loadingTextLabel!)
                }
                
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
                activityIndicator.center = (self.loadingOverlay?.center)!
                activityIndicator.frame.origin.y += 20
                activityIndicator.startAnimating()
                self.loadingOverlay?.addSubview(activityIndicator)
                
                self.view.addSubview(self.loadingOverlay!)
                
            } else {
                self.loadingTextLabel?.text = title
            }
        }
    }
    
    // Hides the laoding overlay
    func HideLoadingOverlay(){
        
        DispatchQueue.main.async {
            if (self.loadingOverlay != nil) {
                self.loadingOverlay?.isHidden = true
                self.loadingOverlay?.removeFromSuperview()
                self.loadingOverlay = nil
            }
        }
        
    }

}

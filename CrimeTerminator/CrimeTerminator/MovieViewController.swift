//
//  MovieViewController.swift
//  CrimeTerminator
//
//  Created by kenny on 5/10/16.
//  Copyright © 2016 kenny. All rights reserved.
//

import UIKit
import MBProgressHUD
import AVFoundation
import ImageIO


class MovieViewController: UIViewController,UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    @IBOutlet weak var contentWebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
  
        // create previewLayer
//        let previewLayer = AVCaptureVideoPreviewLayer.init(session: AVMovieSessionManager.sharedInstance.captureSession)
//        previewLayer.frame = view.bounds
//        view.layer .insertSublayer(previewLayer, atIndex: 0)
        
        
        contentWebView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "http://www.baidu.com")!))
        
        contentWebView.delegate = self
        configGesture()
        
    }
    
    private func configGesture(){
        let swipeGesture = UISwipeGestureRecognizer.init(target: self, action:#selector(self.swipeAction))
        swipeGesture.delegate = self
        swipeGesture.direction = .Left
        contentWebView.addGestureRecognizer(swipeGesture)
        contentWebView.scrollView.delegate = self
    }
    
    @objc private func swipeAction(){
          AVMovieSessionManager.sharedInstance.toggleRecording()

    }
    
    //MARK: - UIWebview Delegate
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
      
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceivePress press: UIPress) -> Bool {
        return true
    }
    

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    
    
}

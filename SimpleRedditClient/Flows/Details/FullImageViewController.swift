//
//  FullImageViewController.swift
//  SimpleRedditClient
//
//  Created by Bogdan Yatsiuk on 05.11.2019.
//  Copyright © 2019 Bogdan Yatsiuk. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController, Storyboarded {
    
    private let imageView = UIImageView()
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    @IBOutlet weak var scrollView: UIScrollView?
    
    var imageURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didPressSaveButton))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didPressCanceButton))
        
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.delegate = self
        
        if let imgURL = imageURL {
            loadImage(withURL: imgURL)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    
    // MARK: - Actions
    @objc func didPressCanceButton(_ button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressSaveButton(_ button: UIBarButtonItem) {
        if let image = imageView.image {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
       
            let ac = UIAlertController(title: "Saved!", message: "The screenshot has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    

    // MARK: - Image load and layout
    func loadImage(withURL url: URL) {
        activityIndicator?.startAnimating()
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self?.activityIndicator?.stopAnimating()
                    }
                    return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.imageView.sizeToFit()
                if let imgView = self?.imageView {
                    self?.scrollView?.addSubview(imgView)
                    self?.scrollView?.contentSize = imgView.frame.size
                    self?.viewWillLayoutSubviews()
                }
                self?.activityIndicator?.stopAnimating()
            }
        }
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let size = scrollView?.bounds.size {
            updateZoomScale(size)
        }
    }

    func updateZoomScale(_ scrollViewSize: CGSize) {
        let imageSize = imageView.bounds.size
        let widthScale = imageSize.width > 0 ? scrollViewSize.width / imageSize.width : 1
        let heightScale = imageSize.height > 0 ? scrollViewSize.height / imageSize.height : 1
        let minScale = min(widthScale, heightScale)
        
        scrollView?.minimumZoomScale = minScale
        scrollView?.maximumZoomScale = 2.0
        scrollView?.zoomScale = minScale
    }
}


extension FullImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}

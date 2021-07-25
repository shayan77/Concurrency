//
//  ViewController.swift
//  Concurrency
//
//  Created by Shayan Mehranpoor on 7/25/21.
//

import UIKit

let imageURLs = [
    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
    "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg",
    "https://www.publicdomainpictures.net/pictures/320000/nahled/background-image.png",
    "https://cdn.pixabay.com/photo/2018/10/10/02/01/hawaii-3736295_960_720.jpg"
]

class Downloader {
    
    class func downloadImageWithURL(url: String) -> UIImage! {
        
        let date = NSData(contentsOf: URL(string: url)!)
        return UIImage(data: date! as Data)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var imageView1: UIImageView!
    @IBOutlet var imageView2: UIImageView!
    @IBOutlet var imageView3: UIImageView!
    @IBOutlet var imageView4: UIImageView!
    @IBOutlet var sliderValueLbl: UILabel!
    
    var queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func downloadBtnPressed(_ sender: Any) {
        blockOperationQueue()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.queue.cancelAllOperations()
    }
    
    private func regularDownload() {
        let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
        self.imageView1.image = img1
        
        let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
        self.imageView2.image = img2
        
        let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
        self.imageView3.image = img3
        
        let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
        self.imageView4.image = img4
    }
    
    private func concurrentQueue() {
        let queue = DispatchQueue.global(qos: .default)
        queue.async { () -> Void in
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            DispatchQueue.main.async {
                self.imageView1.image = img1
            }
        }

        queue.async { () -> Void in
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            DispatchQueue.main.async {
                self.imageView2.image = img2
            }
        }

        queue.async { () -> Void in
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            DispatchQueue.main.async {
                self.imageView3.image = img3
            }
        }

        queue.async { () -> Void in
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            DispatchQueue.main.async {
                self.imageView4.image = img4
            }
        }
    }
    
    private func serialQueue() {
        let serialQueue = DispatchQueue(label: "com.concurrency.imagesQueue", qos: .default)
        serialQueue.async { () -> Void in
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            DispatchQueue.main.async {
                self.imageView1.image = img1
            }
        }
        
        serialQueue.async { () -> Void in
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            DispatchQueue.main.async {
                self.imageView2.image = img2
            }
        }
        
        serialQueue.async { () -> Void in
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            DispatchQueue.main.async {
                self.imageView3.image = img3
            }
        }
        
        serialQueue.async { () -> Void in
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            DispatchQueue.main.async {
                self.imageView4.image = img4
            }
        }
    }
    
    private func operationQueue() {
        queue = OperationQueue()
        
        queue.addOperation { () -> Void in
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        }
        
        queue.addOperation { () -> Void in
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        }
        
        queue.addOperation { () -> Void in
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        }
        
        queue.addOperation { () -> Void in
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        }
    }
    
    private func blockOperationQueue() {
        queue = OperationQueue()
        
        let operation1 = BlockOperation(block: {
            let img1 = Downloader.downloadImageWithURL(url: imageURLs[0])
            OperationQueue.main.addOperation({
                self.imageView1.image = img1
            })
        })
        
        operation1.completionBlock = {
            print("Operation 1 completed, cancelled: \(operation1.isCancelled)")
        }
        queue.addOperation(operation1)
        
        let operation2 = BlockOperation(block: {
            let img2 = Downloader.downloadImageWithURL(url: imageURLs[1])
            OperationQueue.main.addOperation({
                self.imageView2.image = img2
            })
        })
        operation2.addDependency(operation1)
        operation2.completionBlock = {
            print("Operation 2 completed")
        }
        queue.addOperation(operation2)
        
        let operation3 = BlockOperation(block: {
            let img3 = Downloader.downloadImageWithURL(url: imageURLs[2])
            OperationQueue.main.addOperation({
                self.imageView3.image = img3
            })
        })
        operation3.addDependency(operation2)
        operation3.completionBlock = {
            print("Operation 3 completed")
        }
        queue.addOperation(operation3)
        
        let operation4 = BlockOperation(block: {
            let img4 = Downloader.downloadImageWithURL(url: imageURLs[3])
            OperationQueue.main.addOperation({
                self.imageView4.image = img4
            })
        })
        
        operation4.completionBlock = {
            print("Operation 4 completed")
        }
        queue.addOperation(operation4)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.sliderValueLbl.text = "\(sender.value * 100.0)"
    }
}


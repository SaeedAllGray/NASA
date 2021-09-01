import UIKit

class WonderOfTheDayVC: UIViewController {

    
    @IBOutlet var navigationbarOutlet: UINavigationItem!
    
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var copyrightLabel: UILabel!
    
    
    let photoInfoController = PhotoInfoController()
    var date: String = ""
    var photoInfoForSave: PhotoInfo?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
                
        
        photoInfoController.fetchPhotoInfo(date: date) { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
                self.photoInfoForSave = photoInfo
            }
        }
    }
    
    @IBAction func bookmarkPressed(_ sender: Any) {
        print("photoInfoForSave")
        PhotoInfo.saveToFile(photoInfo: self.photoInfoForSave!)
//        print("---------------------")
//        print(self.photoInfoForSave!)
    }
    
    
    
    
    
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else { return }
        
        let task = URLSession.shared.dataTask(with: url,
        completionHandler: { (data, response, error) in
    
            guard let data = data,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.navigationbarOutlet.title = photoInfo.title
                self.imageView.image = image
                self.descriptionLabel.text =
                    photoInfo.description
                
                
                if let copyright = photoInfo.copyright {
                    self.copyrightLabel.text =
                    "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        })
    
        task.resume()
    }

    
    

  
   

}


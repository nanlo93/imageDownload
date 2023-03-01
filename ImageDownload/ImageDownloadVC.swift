//
//  ImageDownloadVC.swift
//  ImageDownload
//
//  Created by Shin on 2023/03/01.
//

import UIKit

class ImageDownloadVC: UIViewController {

    struct ImageInfo {
        var url: String?
        var image: UIImage?
    }
    
    var imageInfo: [ImageInfo] = [
        .init(url: "https://i.postimg.cc/28CGp6LZ/IMG-9278.jpg", image: nil),
        .init(url: "https://i.postimg.cc/fLNvCTx5/IMG-9271.jpg", image: nil),
        .init(url: "https://i.postimg.cc/c4HBXznq/IMG-1051.jpg", image: nil),
        .init(url: "https://i.postimg.cc/LsztJKrP/IMG-1028.jpg", image: nil),
        .init(url: "https://i.postimg.cc/PqtxQgCY/IMG-0942.jpg", image: nil)
    ] {
        didSet {
            self.tvMain.reloadData()
        }
    }
    
    @IBOutlet weak var tvMain: UITableView!
    @IBOutlet weak var btnLoadAllImages: UIButton!
    
    @IBAction func btnLoadAllImagesTouch(_ sender: Any) {
        for i in 0 ..< self.imageInfo.count {
            DispatchQueue.main.async {
                self.imageDownload(index: i)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tvMain.delegate = self
        self.tvMain.dataSource = self
        
        self.setLayout()
    }
    
    func setLayout() {
        self.btnLoadAllImages.layer.cornerRadius = self.btnLoadAllImages.frame.height / 5
    }
    
    func imageDownload(index: Int) {
        self.imageInfo[index].image = nil
        
        guard let url = URL(string: self.imageInfo[index].url!) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                self?.imageInfo[index].image = image
            }
        }.resume()
    }
}

extension ImageDownloadVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if let image = self.imageInfo[indexPath.row].image {
            cell.ivIphone.image = image
        } else {
            cell.ivIphone.image = UIImage(systemName: "photo")
        }
        
        cell.btnLoadImage.tag = indexPath.row
        cell.btnLoadImage.addTarget(self, action: #selector(btnLoadImageTouch(btn: )), for: .touchUpInside)
        
        return cell
    }
    
    @objc func btnLoadImageTouch(btn: UIButton) {
        self.imageDownload(index: btn.tag)
    }
}

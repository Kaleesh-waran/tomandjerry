//
//  TableViewViewModel.swift
//  Tom & Jerry
//
//  Created by Kaleeshwaran P on 21/11/22.
//

import AVKit
import Foundation

class TableViewViewModel {

    static let shared: TableViewViewModel = TableViewViewModel()
    
    func playVideo(vc: ViewController, indexPath: IndexPath) {
        
        let videoUrl: URL = URL(string: videoList[indexPath.row].url)!
        let player: AVPlayer = AVPlayer(url: videoUrl)
        let avPlayer: AVPlayerViewController = AVPlayerViewController()
        
        avPlayer.videoGravity = .resizeAspect
        avPlayer.player = player
        avPlayer.view.backgroundColor = .white
        
        vc.present(avPlayer, animated: true) {
            
            player.play()
        }
    }
    
    func setValueForCell(cell: MyTableViewCell, indexPath: IndexPath) {
        
       let view = cell.loader()
        
        DispatchQueue.global().async {
            
            let title: String = videoList[indexPath.row].title
            let url: URL = URL(string: videoList[indexPath.row].url)!
            let asset = AVAsset(url: url)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 75, timescale: 2)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute: {
                    
                    cell.cellImageView.image = frameImg
                    cell.cellLabel.text = title
                    cell.stopLoader(view: view)
                })
            }
        }
    }
}

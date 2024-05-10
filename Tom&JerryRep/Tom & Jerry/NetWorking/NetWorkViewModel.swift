//
//  NetWorking.swift
//  Tom & Jerry
//
//  Created by Kaleeshwaran P on 17/11/22.
//

import UIKit
import Foundation

class JsonDecode {
    
    static let shared: JsonDecode = JsonDecode()
    
    
    func jsonDecode(data: Data) {
        
        do {
            
            let decoder = JSONDecoder()
            
            let result = try decoder.decode(VideoArray.self, from: data)
            
            videoList = result
            
        } catch {
            
            print("Error is2: \(String(describing: error.localizedDescription))")
        }
    }
}

class ApiCall {
    
    static let shared: ApiCall = ApiCall()
    
    func apiCall(vc: ViewController) {
        
        let loader = vc.loader()
        
        self.apiCall(url: "https://dharanp-2560.zcodeusers.com/TomAndJerry", completion: {
            
            vc.count = videoList.count
            vc.tableView.reloadData()
            vc.stopLoader(loader: loader)
        })
        
    }
    
    private func apiCall(url: String, completion: @escaping () -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            
            if let data: Data = data, error == nil {
                
                JsonDecode.shared.jsonDecode(data: data)
                
                DispatchQueue.main.async {
                    
                    completion()
                }
               
            } else {
                
                print(error.debugDescription)
            }
            
        }.resume()
    }
}


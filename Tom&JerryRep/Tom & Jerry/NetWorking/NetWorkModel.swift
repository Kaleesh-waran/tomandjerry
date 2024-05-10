//
//  NetWorkModel.swift
//  Tom & Jerry
//
//  Created by Kaleeshwaran P on 17/11/22.
//

import Foundation


struct Video: Codable {
    
    let title: String
    let url: String
}

typealias VideoArray = [Video]



var videoList: VideoArray = []

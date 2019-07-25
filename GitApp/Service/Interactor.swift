//
//  Interactor.swift
//  GitApp
//
//  Created by Danilo Requena on 24/07/19.
//  Copyright © 2019 Danilo Requena. All rights reserved.
//

import Foundation
import Alamofire

class Interactor<S> where S: Decodable {
    
    typealias Model = S
    
    func fetchModel(url: URL, completion: @escaping (Model?) -> Void) {
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
            
            guard let data = response.data else {return completion(nil)}
            do {
                let json = try JSONDecoder().decode(Model.self, from: data)
                completion(json)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}

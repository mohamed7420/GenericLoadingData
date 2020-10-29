//
//  ViewController.swift
//  GenericLoadingData
//
//  Created by Mohamed on 10/29/20.
//  Copyright © 2020 Mohamed. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingData(baseUrl: "https://jsonplaceholder.typicode.com/", endPoint: "photos", responseModel: [Post].self, method: .get) { (response) in
            
            switch response{
                
            case .success(let posts):
                posts.forEach{
                    
                    if let id = $0.albumId , let title = $0.title{

                        print(id , title)
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    

    func loadingData<T: Decodable>(baseUrl: String , endPoint: String , responseModel: T.Type , method: HTTPMethod, completion: @escaping (Result<T , Error>) -> ()){
        
        guard let url = URL(string: "\(baseUrl)\(endPoint)") else {return}
        
        AF.request(url, method: method, parameters: [:], headers: [:]).responseJSON { (response) in
            
            guard let statusCode = response.response?.statusCode else {return}
            
            if statusCode == 200{
                guard let jsonResponse = try? response.result.get() else {return}
                guard let responseData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {return}
                guard let result = try? JSONDecoder().decode(T.self, from: responseData) else {return}
                completion(.success(result))
            }else{
                
                print("error")
                //completion(.failure())
            }
        }
        
    }
    

}


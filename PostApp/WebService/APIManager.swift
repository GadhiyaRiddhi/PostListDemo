//
//  APIManager.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import Alamofire
import MaterialActivityIndicator

class APIManager
{
    static let shared = APIManager()
    static let Sharedndicator = MaterialActivityIndicatorView()
    
    
    func callGetAPI(apiURL:String,shouldShowLoader showLoader:Bool,shouldHideLoader hideLoader:Bool,
                    completion: @escaping (_ dataAfterCompletion: [PostData]) -> ()) -> Void
    {
        if !NetworkReachabilityManager()!.isReachable {
            
        } else {
            self.showActivityIndicator()
            Alamofire.request(apiURL, method: .get, parameters: nil, encoding: JSONEncoding(), headers: nil).responseJSON { (response) in
                
                if response.result.error != nil {
                    self.hideActivityIndicator()
                } else {
                    self.hideActivityIndicator()
                    guard let data = response.data else { return }
                    do {
                        let parsed = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:Any]]
                        var dataArr : [PostData] = [PostData]()
                        for obj in parsed! {
                            let obj = PostData(with:obj)
                            dataArr.append(obj)
                        }
                        completion(dataArr)
                    } catch let parseError {
                        print(parseError)
                    }
                }
            }
        }
    }
    
    //MARK: Helper Methods
    func showActivityIndicator() {
        APIManager.Sharedndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            APIManager.Sharedndicator.stopAnimating()
        }
    }
}

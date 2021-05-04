//
//  PostListViewModel.swift
//  PostApp
//
//  Created by Riddhi  on 01/05/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol PostDetailProtocol:class {
    func getPostListWithDetail(postDetail: [PostData]) -> Void
}

class PostListViewModel {
    
    let serviceURL = "https://jsonplaceholder.typicode.com/posts"
    weak private var delegate:PostDetailProtocol?
    
    init(withDelegate delegate:PostDetailProtocol) {
        self.delegate = delegate
    }
    
    func GetPostListFromAPI(){
        APIManager.shared.callGetAPI(apiURL: serviceURL, shouldShowLoader: false, shouldHideLoader: true) { (result) in
            print("\n\n ----Reasult: \(result)--\n\n")
            self.delegate?.getPostListWithDetail(postDetail:result)
        }
    }
}

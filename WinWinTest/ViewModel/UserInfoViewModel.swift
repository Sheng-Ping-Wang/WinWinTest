//
//  UserInfoViewModel.swift
//  WinWinTest
//
//  Created by Wang Sheng Ping on 2022/10/31.
//

import Foundation
import UIKit

class UserInfoViewModel {
    var imageUrl: String = ""
    var name: String = ""
    var tags: [String] = []
    var image: Observerable<UIImage> = Observerable(UIImage())
//    var image: UIImage = UIImage()
    
    init(imageUrl: String, name: String, tags: [String]) {
        self.imageUrl = imageUrl
        self.name = name
        self.tags = tags
        getImage()
    }
    
    private func getImage() {
        
        guard let url = URL(string: self.imageUrl) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print(error as Any)
                return
            }
            self.image.value = UIImage(data: data) ?? UIImage()
        }.resume()

    }
}

//MARK: Observerable
class Observerable<T> {
    var value: T? {
        didSet{
            listener?(value)
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }

}

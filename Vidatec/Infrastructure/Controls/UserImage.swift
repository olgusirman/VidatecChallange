//
//  UserImage.swift
//  Vidatec
//
//  Created by Olgu SIRMAN on 11/01/2021.
//

import UIKit
import SwiftUI
import Kingfisher

struct UserImage: View {
    
    var imageUrlString: String
    
    var imageUrl: URL {
        URL(string: imageUrlString)!
    }
    
    var body: some View {
        KFImage(imageUrl)
            .placeholder {
                Image(systemName: "person.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .cancelOnDisappear(true)
            .resizable()
//            .frame(width: 50, height: 50)
//            .clipShape(Circle())
//            .aspectRatio(contentMode: .fill)
//            .shadow(color: .gray, radius: 0.5, x: 1, y: 1)
            .accessibility(hidden: true)
    }
    
}

struct CircleImage_Preview: PreviewProvider {
    static var previews: some View {
        UserImage(imageUrlString: "https://avatars0.githubusercontent.com/u/53901302?v=4")
    }
}

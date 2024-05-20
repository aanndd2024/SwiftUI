//
//  AsyncImageView.swift
//  MVVM-SwiftUI
//
//  Created by Anand Yadav on 20-05-2024.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: String
    var body: some View {
        if let url = URL(string: imageURL) {
            AsyncImage(url: url) { img in
                img.resizable()
            } placeholder: {
                ProgressView()
            }
        }
    }
}

#Preview {
    AsyncImageView(imageURL: Product.dummy.image)
}

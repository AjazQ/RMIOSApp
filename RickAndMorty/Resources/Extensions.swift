//
//  Extensions.swift
//  RickAndMorty
//
//  Created by PS19Developer on 04/04/2023.
//

import UIKit

extension UIView{
    func addSubViews(_ views: UIView...){
        views.forEach({
            addSubview($0)
        })
    }
}

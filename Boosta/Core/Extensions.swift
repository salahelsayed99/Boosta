//
//  Extensions.swift
//  Boosta
//
//  Created by Salah  on 22/04/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UITableView {
    public func modelAndIndexSelected<T>(_ modelType: T.Type) -> ControlEvent<(T, IndexPath)> {
        ControlEvent(events: Observable.zip(
            self.modelSelected(modelType),
            self.itemSelected
        ))
    }
}

extension Reactive where Base: UICollectionView {
    public func modelAndIndexSelected<T>(_ modelType: T.Type) -> ControlEvent<(T, IndexPath)> {
        ControlEvent(events: Observable.zip(
            self.modelSelected(modelType),
            self.itemSelected
        ))
    }
}


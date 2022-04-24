//
//  ShareUtility.swift
//  Boosta
//
//  Created by Salah  on 23/04/2022.
//

import Foundation
import UIKit

class ShareUtility {
    class func share(_ object: AnyObject, inViewController:UIViewController) {
        let objectsToShare = [object]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.saveToCameraRoll, UIActivity.ActivityType.openInIBooks]
        activityVC.navigationController?.navigationBar.tintColor = .white
        activityVC.popoverPresentationController?.sourceView = inViewController.view
        activityVC.popoverPresentationController?.sourceRect = CGRect(x: inViewController.view.bounds.midX, y: inViewController.view.bounds.maxY, width: 0, height: 0)
        inViewController.present(activityVC, animated: true, completion: nil)
    }
}


//
//  HalfSizePresentConroller.swift
//  PharmacyOnDutyApp
//
//  Created by Fatih on 8.03.2024.
//

import Foundation
import UIKit

class HalfSizePresentConroller: UIPresentationController {
    var dimmingView: UIVisualEffectView!
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height:  bounds.height / 2)
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        dimmingView.frame = containerView!.bounds
        dimmingView.alpha = 0.0
        containerView?.addSubview(dimmingView)
        
        if let corordinator = presentedViewController.transitionCoordinator {
            corordinator.animate { _ in
                self.dimmingView.alpha = 0.8
            }
        }
    }
    
    override func containerViewDidLayoutSubviews() {
        dimmingView.frame = containerView!.bounds
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}

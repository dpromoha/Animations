//
//  ViewController.swift
//  Animations
//
//  Created by Darya Pr on 17.02.2022.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {
  
  private let animatableView = UIView()
  private let pickerView = UIPickerView()
  private let animationArray = ["default", "backgroundColor", "xMovement", "yMovement", "widthExtension", "heightExtension", "transparency", "topTransition", "rightTransition", "spring", "keyframe", "gradient", "circle", "doubleSize", "rotation"]
  
  // MARK: - Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupLayout()
  }

}

private extension ViewController {
  
  func runAnimation(type: String) {
    switch type {
    case "backgroundColor":
      animateBackgroundColor()
    
    case "xMovement":
      animateXMovement()
    
    case "yMovement":
      animateYMovement()
    
    case "widthExtension":
      animateWidthExtension()
    
    case "heightExtension":
      animateHeightExtension()
      
    case "transparency":
      animateTransparency()
  
    case "topTransition":
      animateTopTransition()
    
    case "rightTransition":
      animateRightTransition()
    
    case "spring":
      animateWithSpring()
      
    case "keyframe":
      animateKeyframes()
    
    case "gradient":
      animateGradient()
    
    case "circle":
      animateTransitionToCircle()
      
    case "doubleSize":
      animateDoubleSizeIncrease()
    
    case "rotation":
      animateRotation()
      
    default:
      reset()
    }
  }
  
  func reset() {
    animatableView.layer.removeAllAnimations()
    animatableView.backgroundColor = UIColor(named: "lightPurple")
  }
  
  func animateBackgroundColor() {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear) {
      self.animatableView.backgroundColor = .green
    } completion: { _ in
      self.animatableView.backgroundColor = UIColor(named: "lightPurple")
    }
  }
  
  func animateTransparency() {
    UIView.animate(withDuration: 1.0) {
      self.animatableView.alpha = 0.0
    } completion: { _ in
      self.animatableView.alpha = 1.0
    }
  }
  
  func animateXMovement() {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut) {
      self.animatableView.frame.origin.x -= 80
    } completion: { _ in
      self.animatableView.frame.origin.x += 80
    }
  }
  
  func animateYMovement() {
    let animator = UIViewPropertyAnimator(duration:0.3, curve: .linear) {
         self.animatableView.frame = self.animatableView.frame.offsetBy(dx: 0, dy: -100)
    }
    
    animator.addCompletion { _ in
      self.animatableView.frame = self.animatableView.frame.offsetBy(dx: 0, dy: 100)
    }
    
    animator.startAnimation()
  }
  
  func animateWidthExtension() {
    UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut) {
      self.animatableView.bounds.size.width += 80.0
    }
  }
  
  func animateHeightExtension() {
    UIView.animate(withDuration: 1.0, delay: 0.0) {
      self.animatableView.bounds.size.height -= 80.0
    }
  }
  
  func animateTopTransition() {
    UIView.transition(with: animatableView, duration: 1.0, options: .transitionFlipFromTop) {
      self.animatableView.backgroundColor = .yellow
    } completion: { _ in
      self.animatableView.backgroundColor = UIColor(named: "lightPurple")
    }
  }
  
  func animateRightTransition() {
    UIView.transition(with: animatableView, duration: 1.0, options: .transitionFlipFromRight, animations: nil)
  }
  
  func animateWithSpring() {
    UIView.animate(
      withDuration: 3.0,
      delay: 0.0,
      usingSpringWithDamping: 0.1,
      initialSpringVelocity: 0.0
    ) {
      self.animatableView.bounds.size.width += 80.0
    }
  }
  
  func animateTransitionToCircle() {
    UIView.animate(withDuration: 2.0) {
      self.animatableView.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
      self.animatableView.center = self.view.center
      self.animatableView.layer.cornerRadius = 50
    } completion: { _ in
      self.animatableView.frame = CGRect(x: 0, y: 0, width: 100.0, height: 100.0)
      self.animatableView.center = self.view.center
      self.animatableView.layer.cornerRadius = 0
    }
  }
  
  func animateKeyframes() {
    UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
      UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
        self.animatableView.layer.borderWidth = 50.0
      })
      UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
        self.animatableView.alpha = 0.5
      })
      UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
        self.animatableView.layer.borderWidth = 4.0
        self.animatableView.alpha = 1.0
      })
    })
  }
  
  func animateGradient() {
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = animatableView.bounds
    gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
    
    let animation = CABasicAnimation(keyPath: "colors")
    animation.fromValue = [UIColor.red.cgColor, UIColor.green.cgColor]
    animation.toValue = [UIColor.green.cgColor, UIColor.red.cgColor]
    animation.duration = 2.0
    animation.repeatCount = 1.0
    animation.fillMode = .removed
    animation.isRemovedOnCompletion = true
    animation.delegate = self
    
    gradientLayer.add(animation, forKey: "colors")
    animatableView.layer.addSublayer(gradientLayer)
  }
  
  func animateDoubleSizeIncrease() {
    UIView.animate(withDuration: 1, delay: 0.0) {
      self.animatableView.transform = CGAffineTransform.identity.scaledBy(x: 2, y: 2)
    } completion: { _ in
      self.animatableView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
    }
  }
  
  func animateRotation() {
    let timeInterval: CFTimeInterval = 1
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(Double.pi * 2)
    rotateAnimation.isRemovedOnCompletion = false
    rotateAnimation.duration = timeInterval
    rotateAnimation.repeatCount = 2
    animatableView.layer.add(rotateAnimation, forKey: nil)
  }
  
}

// MARK: - CAAnimationDelegate

extension ViewController: CAAnimationDelegate {
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    animatableView.layer.removeAllAnimations()
    animatableView.layer.sublayers?.removeAll()
  }
  
}

// MARK: - Layout

private extension ViewController {
  
  func setupLayout() {
    animatableView.backgroundColor = UIColor(named: "lightPurple")
    animatableView.layer.borderWidth = 4.0
    animatableView.layer.borderColor = CGColor(red: 0.627, green: 0.702, blue: 0.659, alpha: 1.0)
    view.addSubview(animatableView)
    animatableView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(100.0)
    }
  
    pickerView.delegate = self
    pickerView.dataSource = self
    view.addSubview(pickerView)
    pickerView.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview()
      $0.height.equalTo(300.0)
    }
  }
  
}

// MARK: - UIPickerViewDelegate

extension ViewController: UIPickerViewDelegate {
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    animationArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    runAnimation(type: animationArray[row])
  }
  
}

// MARK: - UIPickerViewDataSource

extension ViewController: UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    animationArray.count
  }
  
}

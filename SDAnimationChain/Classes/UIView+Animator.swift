//
//  UIView+Animator.swift
//  SDAnimationChain
//
//  Created by Sauvik Dolui on 31/10/20.
//  Copyright © 2020 Sauvik Dolui. All rights reserved.
//

import UIKit

public extension UIView {
    
    class Animator {
        
        // MARK: - Type Aliases
        public typealias Animation = () -> Void
        public typealias Completion = (Bool) -> Void
        
        private var pendingTasks: [Task] = []
                
        public init() {}
        
        /// Prepares an animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - duration: duration
        ///   - delay: delay
        ///   - options: options
        ///   - animations: animation block
        ///   - completion: completion block
        /// - Returns: same instance on which this method is executed
        public func animate(duration: TimeInterval,
                     delay: TimeInterval = 0.0,
                     options: UIView.AnimationOptions = [],
                     animations: @escaping Animation,
                     completion: @escaping Completion = { _ in }) -> Animator {
            let task = Task(duration: duration,
                            delay: delay,
                            options: options,
                            animation: animations,
                            completion: completion)
            pendingTasks.append(task)
            return self
        }
        
        /// Prepares spring animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - duration: duration
        ///   - delay: delay
        ///   - dampingRatio: dumpting ration
        ///   - initialVelocity: initial velocity
        ///   - options: options
        ///   - animations: animations
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func springAnimate(duration: TimeInterval,
                           delay: TimeInterval = 0.0,
                           dampingRatio: CGFloat,
                           initialVelocity: CGFloat,
                           options: UIView.AnimationOptions = [],
                           animations: @escaping Animation,
                           completion: @escaping Completion = { _ in }) -> Animator {
            let category = Task.Category.spring(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
            let task = Task(duration: duration,
                            delay: delay,
                            options: options,
                            category: category,
                            animation: animations,
                            completion: completion)
            pendingTasks.append(task)
            return self
        }
        
        /// Prepares one transition (from view, to view) animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - fromView: from view
        ///   - toView: to view
        ///   - duration: duration
        ///   - options: options
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func transition(fromView: UIView,
                        toView: UIView,
                        duration: TimeInterval,
                        options: UIView.AnimationOptions = [],
                        completion: @escaping Completion = { _ in }) -> Animator {
            let category = Task.Category.transition(fromView: fromView, toView: toView)
            let task =  Task(duration: duration,
                             delay: 0.0,
                             options: options,
                             category: category,
                             animation: { }, // No animation block
                             completion: completion)
            pendingTasks.append(task)
            return self
        }
        
        /// Prepares one transition (single view) animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - view: view
        ///   - duration: duration
        ///   - options: options
        ///   - animations: animations
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func transitionWith(view: UIView,
                            duration: TimeInterval,
                            options: UIView.AnimationOptions = [],
                            animations: @escaping Animation,
                            completion: @escaping Completion = { _ in }) -> Animator {
            let category = Task.Category.transitionOn(view: view)
            let task = Task(duration: duration,
                            delay: 0.0,
                            options: options,
                            category: category,
                            animation: animations,
                            completion: completion)
            pendingTasks.append(task)
            return self
        }
        
        // MARK: - Chain Helpers
        
        /// Prepares an animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - duration: duration
        ///   - delay: delay
        ///   - options: options
        ///   - animations: animation block
        ///   - completion: completion block
        /// - Returns: same instance on which this method is executed
        public func thenAnimate(duration: TimeInterval,
                         delay: TimeInterval = 0.0,
                         options: UIView.AnimationOptions = [],
                         animations: @escaping Animation,
                         completion: @escaping Completion = { _ in } ) -> Animator {
            
            return animate(duration: duration,
                           delay: delay,
                           options: options,
                           animations: animations,
                           completion: completion)
        }
        /// Prepares spring animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - duration: duration
        ///   - delay: delay
        ///   - dampingRatio: dumpting ration
        ///   - initialVelocity: initial velocity
        ///   - options: options
        ///   - animations: animations
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func thenSpringAnimate(duration: TimeInterval,
                               delay: TimeInterval = 0.0,
                               dampingRatio: CGFloat,
                               initialVelocity: CGFloat,
                               options: UIView.AnimationOptions = [],
                               animations: @escaping Animation,
                               completion: @escaping Completion = { _ in } ) -> Animator {
            return springAnimate(duration: duration,
                                 delay: delay,
                                 dampingRatio: dampingRatio,
                                 initialVelocity: initialVelocity,
                                 options: options,
                                 animations: animations,
                                 completion: completion)
        }
        /// Prepares one transition (from view, to view) animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - fromView: from view
        ///   - toView: to view
        ///   - duration: duration
        ///   - options: options
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func thenTransition(fromView: UIView,
                            toView: UIView,
                            duration: TimeInterval,
                            options: UIView.AnimationOptions = [],
                            completion: @escaping Completion = { _ in }) -> Animator {
            return transition(fromView: fromView,
                              toView: toView,
                              duration: duration,
                              options: options,
                              completion: completion)
        }
        /// Prepares one transition (single view) animation task with required parameters and saves it for future execution
        /// - Parameters:
        ///   - view: view
        ///   - duration: duration
        ///   - options: options
        ///   - animations: animations
        ///   - completion: completion
        /// - Returns: same instance on which this method is executed
        public func thenTransitionWith(view: UIView,
                                duration: TimeInterval,
                                options: UIView.AnimationOptions = [],
                                animations: @escaping Animation,
                                completion: @escaping Completion = { _ in }) -> Animator {
            return transitionWith(view: view,
                                  duration: duration,
                                  options: options,
                                  animations: animations,
                                  completion: completion)
        }
        
        /// Starts the animation execution
        ///
        /// - Note:
        ///   You must call this methods after preparing the animation chain to execute the animation in the same sequence they were prepared
        public func start(){
            executeNextAnimation()
        }
        
        // MARK: Execute Animation
        private func executeNextAnimation() {
            
            // Pick up first animation task if there is any else return
            guard let currentTask = pendingTasks.first else { return }
            
            // Update pending task array removing the first task
            pendingTasks = Array<Task>(pendingTasks.dropFirst())
            
            switch currentTask.category {
            case .normal:
                UIView.animate(withDuration: currentTask.duration,
                               delay: currentTask.delay,
                               options: currentTask.options,
                               animations: currentTask.animation) {  finished in
                    
                    // Execute completion
                    currentTask.completion(finished)
                    
                    // Try to execute next animation if there is any
                    self.executeNextAnimation()
                }
            case .spring(let dampingRatio, let initialVelocity):
                UIView.animate(withDuration: currentTask.duration,
                               delay: currentTask.delay,
                               usingSpringWithDamping: dampingRatio,
                               initialSpringVelocity: initialVelocity,
                               options: currentTask.options,
                               animations: currentTask.animation) {  finished in
                    // Execute completion
                    currentTask.completion(finished)
                    
                    // Try to execute next animation if there is any
                    self.executeNextAnimation()
                }
            case .transition(let fromView, let toView):
                UIView.transition(from: fromView, to: toView,
                                  duration: currentTask.duration,
                                  options: currentTask.options) { finished in
                    // Execute completion
                    currentTask.completion(finished)
                    
                    // Try to execute next animation if there is any
                    self.executeNextAnimation()
                }
            case .transitionOn(let view):
                UIView.transition(with: view,
                                  duration: currentTask.duration,
                                  options: currentTask.options,
                                  animations: currentTask.animation) { finished in
                    // Execute completion
                    currentTask.completion(finished)
                    
                    // Try to execute next animation if there is any
                    self.executeNextAnimation()
                }
            } // End of switch
        } // End of function
    } // End of Animator class
}

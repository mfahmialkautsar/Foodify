//
//  Debouncer.swift
//  Foodify
//
//  Created by Jamal on 23/01/21.
//  Copyright © 2021 Kementerian Agama RI. All rights reserved.
//

import Foundation

class Debouncer: NSObject {
  private var callback: () -> Void
  private var delay: Double
  private weak var timer: Timer?

  init(delay: Double, callback: @escaping () -> Void) {
    self.delay = delay
    self.callback = callback
  }

  func call() {
    timer?.invalidate()
    let nextTimer = Timer.scheduledTimer(
      timeInterval: delay,
      target: self,
      selector: #selector(fire),
      userInfo: nil,
      repeats: false
    )
    timer = nextTimer
  }

  @objc private func fire() {
    callback()
  }
}

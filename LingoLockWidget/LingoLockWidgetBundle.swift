//
//  LingoLockWidgetBundle.swift
//  LingoLockWidget
//
//  Created by Max Fuligni on 8/26/24.
//

import WidgetKit
import SwiftUI

@main
struct LingoLockWidgetBundle: WidgetBundle {
    var body: some Widget {
        LingoLockWidget()
        LingoLockWidgetLiveActivity()
    }
}

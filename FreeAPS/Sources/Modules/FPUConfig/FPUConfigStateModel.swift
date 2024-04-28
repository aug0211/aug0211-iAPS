import SwiftUI

extension FPUConfig {
    final class StateModel: BaseStateModel<Provider> {
        @Published var individualAdjustmentFactor: Decimal = 0
        @Published var timeCap: Decimal = 0
        @Published var minuteInterval: Decimal = 0
        @Published var delay: Decimal = 0

        override func subscribe() {
            subscribeSetting(\.timeCap, on: $timeCap.map(Int.init), initial: {
                // Auggie - set the min to 1 here
                let value = max(min($0, 12), 1)
                timeCap = Decimal(value)
            }, map: {
                $0
            })

            subscribeSetting(\.minuteInterval, on: $minuteInterval.map(Int.init), initial: {
                let value = max(min($0, 60), 10)
                minuteInterval = Decimal(value)
            }, map: {
                $0
            })

            subscribeSetting(\.delay, on: $delay.map(Int.init), initial: {
                // Auggie - allow the minimum FPU delay to be 30 minutes
                let value = max(min($0, 120), 30)
                delay = Decimal(value)
            }, map: {
                $0
            })

            subscribeSetting(\.individualAdjustmentFactor, on: $individualAdjustmentFactor, initial: {
                let value = max(min($0, 1.2), 0.1)
                individualAdjustmentFactor = value
            }, map: {
                $0
            })
        }
    }
}

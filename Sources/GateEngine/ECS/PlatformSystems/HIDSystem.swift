/*
 * Copyright © 2023 Dustin Collins (Strega's Gate)
 * All Rights Reserved.
 *
 * http://stregasgate.com
 */

internal class HIDSystem: PlatformSystem {
    @inlinable
    override func update(game: Game, input: HID, withTimePassed deltaTime: Float) {
        input.update(deltaTime)
    }
    
    override class var phase: PlatformSystem.Phase {return .preUpdating}
    override class func sortOrder() -> PlatformSystemSortOrder? {.hidSystem}
}

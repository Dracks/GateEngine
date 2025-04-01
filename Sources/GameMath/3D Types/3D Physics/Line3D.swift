/*
 * Copyright © 2025 Dustin Collins (Strega's Gate)
 * All Rights Reserved.
 *
 * http://stregasgate.com
 */

public struct Line3D: Sendable {
    public let p1: Position3
    public let p2: Position3
    public let length: Float
    
    public init(_ p1: Position3, _ p2: Position3) {
        self.p1 = p1
        self.p2 = p2
        self.length = p1.distance(from: p2)
    }
}

public extension Line3D {
    @inlinable
    func pointNear(_ p: Position3) -> Position3 {
        let ab = p2 - p1
        let ap = p - p1
        
        var t = ap.dot(ab) / ab.squaredLength
        if t < 0 {t = 0}
        if t > 1 {t = 1}

        return p1 + (ab * t)
    }
}

public extension Line3D {
    @inlinable
    static func *(lhs: Self, rhs: Matrix4x4) -> Self {
        return Line3D(lhs.p1 * rhs, lhs.p2 * rhs)
    }
}

/*
 * Copyright © 2025 Dustin Collins (Strega's Gate)
 * All Rights Reserved.
 *
 * http://stregasgate.com
 */

public final class StateMachineComponent: Component {
    public var stateMachine: StateMachine
    internal var shouldApplyInitialState: Bool = true

    @inlinable
    public var currentState: any State {
        return stateMachine.currentState
    }
    
    final class NoState: State {
        init() { }
        func apply(to entity: Entity, previousState: some State, context: ECSContext, input: HID) { }
        func update(for entity: Entity, inContext context: ECSContext, input: HID, withTimePassed deltaTime: Float) { }
        func possibleNextStates(for entity: Entity, context: ECSContext, input: HID) -> [any State.Type] {
            return []
        }
    }
    
    public init() {
        self.stateMachine = StateMachine(initialState: NoState.self)
    }
    
    public init(initialState: any State.Type) {
        self.stateMachine = StateMachine(initialState: initialState)
    }
    
    public static let componentID: ComponentID = ComponentID()
}

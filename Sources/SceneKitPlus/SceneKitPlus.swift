public struct SceneKitPlus {
    public private(set) var text = "Hello, World!"

    public init() {
        
        let character = CharacterControlledEntity(characterData: .defaultCharacter, cameraNode: .init())
        
        print(character)
        
    }
}

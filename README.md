# StoryKit

**StoryKit for visionOS** is our official SDK, built in Swift, that enables developers to seamlessly integrate Story experiences directly into their own visionOS applications.
Think of it as giving your app a native story engine.
Whether you are building a XR experience, an educational product, or a creative platform, StoryKit empowers you to embed interactive storytelling capabilities directly into your environment — with full control over presentation, interaction, and user experience.

## ✨ Features
### Story Playback Engine
- Load and play all content created with ProStory
- Provides consistent and deterministic playback behavior across devices and platforms

### Events & Interaction System
- Rich event callback APIs covering the Story lifecycle and key interaction milestones
- Seamlessly bind Story events to your application logic
- Suitable for advanced interaction scenarios such as UI synchronization and custom event handling

### Flexible Integration
- Easily embedded into existing application architectures without requiring major refactoring
- Supports a wide range of environments, including VR, AR, 3D scenes, and traditional app interfaces

### TapStory Control Support
- Remotely control Story loading and playback from an iOS device
- Enables companion-device and controller-style interaction workflows

### SharePlay Support
- Synchronize playback and interaction with others via SharePlay
- Enables real-time, shared storytelling experiences across multiple participants

## 🛠️ Requirements
- Xcode 15 or later  
- visionOS 26.0

## 🔗 Integration
### Swift Package Manager
The Swift Package Manager is a tool for automating the distribution of Swift code and is integrated into the swift compiler.
```
dependencies: [
    .package(url: "https://github.com/story-platform/StoryKit-visionOS.git", from: "1.0.0")
]
```

## 🔑 Getting an API Key
To use StoryKit in your app, you must have a valid API key. API keys are issued through your StoryKit account.
1. Go to [StoryKit Website](https://story.app/storykit)
2. Create an Account
3. Create an app to generate a API Key
   
## 🚀 Quick Start
### 1. Import StoryKit
```
import StoryKit
```
### 2. Initialize StoryKit
Initialize the SDK once at app launch:

A template delegate for handling StoryKit playback and events
```
final class StoryDelegate: StoryPlayerDelegate {

    /// Called whenever the StoryPlayer changes state
    func storyPlayerState(_ state: StoryKit.StoryPlayer.PlayerState) {
        print("StoryPlayer State Changed to \(state)")
    }

    /// Called when a Story invokes a custom event
    func storyInvokeEvent(_ event: StoryKit.StoryPlayer.StoryEvent) {
        print("StoryKit player invoked event: \(event)")        
    }
}
```
```
let config = StoryConfig(
    debug: true,                           // Enable verbose logging for development
    delegate: StoryDelegate(),             // Receive lifecycle and event callbacks
    openImmersiveSpace: openImmersiveSpace // System handler for immersive content
)
Task {
    if let result = await StoryPlayer.initialize("YOUR_API_KEY", config) {
        switch result {
        case .authorized:
            print("StoryKit ready")
        case .unauthorized(let error):
            print("Authorization failed: \(error)")
        @unknown default:
            fatalError()
        }
    } else {
        print("StoryKit initialization failed")
    }
}
```
⚠️ Replace "YOUR_API_KEY" with your valid StoryKit API key.

### 3. Setup your immersive space and ToolsWindow with StoryView
```
struct ImmersiveView: View {

    var body: some View {
        StoryView { contents, attachments in
            //You can customize your immersive view.
        } attachments: {
            
        }
    }
}

```

```
ImmersiveSpace(id: StorySpaceID) {
    ImmersiveView()
        .environment(appModel)
        .onAppear {
            appModel.immersiveSpaceState = .open
        }
        .onDisappear {
            appModel.immersiveSpaceState = .closed
        }
  }
                
ToolsWindow
    .windowStyle(.plain)
    .windowResizability(.contentSize)
```

### 4. Play a Story
```
Task{
    do{
        try await StoryPlayer.play(story: title)
    } catch{
        print("Play Story Error: \(error.localizedDescription)")
    }
}
```
## 🧱 Usage
### 1. Manually Trigger an Event
```
let result = StoryPlayer.invokeEvent(id: "event_7C1C8B59-AD29-479F-BFC6-041F0382EE23")
print("Event triggered, result: \(result)")
```
### 2. Retrieve the position of a specific entity
```
if let entity = StoryPlayer.findEntity(id: "entity_F621A04B-472F-459D-86D0-6D54CBAB2F59") {
    print("Entity Position: \(entity.position(relativeTo: nil))")
}
```
### 3. Enable SharePlay
```
// Before you start to play a Story, you need to enable SharePlay by StoryPlayer.setShareplayEnabled(true)
do {
    try StoryPlayer.setShareplayEnabled(true)
}
catch{    
    print("Failed to enable SharePlay, Error: \(error.localizedDescription)")
}

// then Activate SharePlay. If a SharePlay is avaliable (either nearby or facetime), this would return activationPreferred.
let activateResult = await StoryPlayer.activateSharePlay()

if(activateResult == .activationPreferred){
    do{
        try await StoryPlayer.play(story: title)
    } catch{
        print("Play Story Error: \(error.localizedDescription)")
    }
}
```
### 4. Enable TapStory Control
Download TapStory from AppStore
```
// Before you start to play a Story, you need to enable TapStory Control by StoryPlayer.setTapStoryEnabled(true)
do {
    try StoryPlayer.setTapStoryEnabled(true)
}
catch{
    print("Failed to enable TapStory Control, Error: \(error.localizedDescription)")
}
```
then you can control story using TapStory

### 5. Enable Annotation Tools inside Story Playback Experience
```
// Before you start to play a Story, you need to enable Tools Feature by StoryPlayer.setTapStoryEnabled(true)
do {
	try StoryPlayer.setToolsEnabled(newValue)
} catch {
	print("ToolsPanel error: \(error.localizedDescription)")
}
```

## 🧪 Sample App

For a fully working example of StoryKit integration, see the StoryKit Sample App:

[View Sample App on GitHub](https://github.com/story-platform/StoryKit-Sample)

## 📄 License
The StoryKit SDK is proprietary software.
* You may use this SDK only according to the terms of your account and subscription plan (Free or Premium).
* Redistribution, modification, or reverse-engineering of the SDK is strictly prohibited.
* Use of the SDK is subject to the StoryKit [Terms of Service](https://story.app/terms-of-service)

Your API key authorizes your access to the SDK and defines your permitted usage. Always keep your API key confidential.

## 📬 Contact
* Author: Story Team
* Email: hello@story.app
* Twitter / X: [@storyapp](https://x.com/storyapp)


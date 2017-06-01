# About This Project

This project is an example solution for a 2 hour workshop on learning about Flux and the unidirectional data flow pattern.

## Solution Discussion

The solution implements three new types: `TicTacToeStore`, `TicTacToeState` and `TicTacToeActions`.

The most new code lives in the store. After the refactor the store owns the `Game` model. The store exposes an interface for the view layer to subscribe to state updates. This happens through a closure that can be passed in the initializer of the store: 

```swift
// In TicTacToeStore:

var onStateChange: (TicTacToeState) -> ()

init(onStateChange: @escaping (TicTacToeState) -> ()) {
	// ...
}

// In TicTacToeViewController:

self.store = TicTacToeStore() { [unowned self] newState in
  self.instructionLabel.text = newState.gameInstruction
  self.connect4View.board = newState.game.board
}
```

In response to state changes, the UI gets updated. 

Whenever a state change needs to occur we now dispatch an action, e.g. when a user placed a token:

```swift
self.connect4View.buttonTappedClosure = { index in
  self.store.handleAction(action: .placeToken(atIndex: index))
}
```

## FAQ

**How is this different from MVVM/MVC?**

This really depends on your implementation of MVC/MVVM. There's a chance you are doing something very similar to Flux already. 

A few things that stand out positively about Flux:

- Definition of the pattern is very rigid (state, actions, store are all very distinct in their role)
- Separation of concerns is clear (as result of above)
- Verbosity (explicit state object, explicit actions) makes it a lot easier to read other developers code
- State updates only through actions - enforces a strict unidirectional state udpate flow. In some flavors of MVVM updates of the view can be bound to updates of the view model, making state changes less obvious.

But once again; it might be that you are already getting all of the benefits of Flux with your implementation of MVVM and MVC, which is great. 

However, in my limited experience explaining Flux to beginners appears to be easier than describing MVC/MVVM due to clear terminology and separation of concerns.

**Should the view layer create the store as in your solution?**

This approach is definitely fine and it works best if you're integrating something like Flux into an existing app. If you want the stores to be created before or alongside the views you need to do that through some sort of routing component. While separating routing from UIKit code is a great approach, it takes a lot more effort.

**Your undo/redo function records game and instruction changes separately, isn't that wrong?**

Yes; for this solution I'm just trivially storing all changes to the `state` variable. Since the game state and the label state are updated separately, they are also recorded separately. In a real-world application you would want to group changes into sets as they are perceived by the user.

**How does this approach work with more complex UI components?**

One of the benefits of this simple example project is that state changes to all UI components are very simple. When working with real iOS apps we have more complex components such as table views or collection views. Inside the PlanGrid app we have built simple wrappers around these components to enable UI updates based on state changes. You can find an open source version of a part of the component [here](https://github.com/Ben-G/Autotable). I'm hoping to soon open source the actual components we are using internally (still need to remove some app specific dependencies). There also a bunch of other interesting React-like UI libraries out there, e.g. [Render](https://github.com/alexdrone/Render) or [Katana](https://github.com/BendingSpoons/katana-swift).

## This is Cool, I Want to Learn More

If you understand the basics of the Flux implementation and know that is essentially just a state container with a well-defined interface, you already know 90% of what you need to know to use Flux effectively.

If you care to read about a more complex implementation of real world feature in the PlanGrid app, [I've written pretty extensively about one](http://blog.benjamin-encz.de/post/real-world-flux-ios/).

You might also want to learn about Redux which adds additional constraints to the Flux pattern (and enables developer tooling such as time travel). There's a Swift counterpart that I'm working on called ReSwift and you can learn about it on the [GitHub repo and the material linked from there](https://github.com/reswift/reswift).


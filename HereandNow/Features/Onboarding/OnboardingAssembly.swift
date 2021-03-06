import UIKit
import Swinject
import SwinjectAutoregistration

class OnboardingAssembly: Assembly {
  func assemble(container: Container) {
    container.autoregister(OnboardingCoordinator.self, initializer: OnboardingCoordinator.init)
    container.autoregister(OnboardingViewModel.self, initializer: OnboardingViewModel.init)
    container.register(OnboardingViewModel.self) { (resolver, coordinator: OnboardingViewModelDelegate)  in
      let viewModel = resolver.resolve(OnboardingViewModel.self)!
      viewModel.delegate = coordinator
      return viewModel
    }

    container.register(OnboardingViewController.self) { (resolver, coordinator: OnboardingViewModelDelegate) -> OnboardingViewController in
      let view: OnboardingViewController = .initializeOnMainStoryBoard()
      let viewModel = resolver.resolve(OnboardingViewModel.self, argument: coordinator)!
      view.viewModel = viewModel
      viewModel.view = view
      return view
    }
  }
}

// swiftlint:disable all
import Danger

fileprivate extension Danger.File {
    var isInTests: Bool { hasPrefix("CheckoutSDKTests/") }
    
    var isSourceFile: Bool {
        hasSuffix(".swift") || hasSuffix(".h") || hasSuffix(".m")
    }
}

let danger = Danger()

let hasSourceChanges = (danger.git.modifiedFiles + danger.git.createdFiles).contains { $0.isSourceFile }
//SwiftLint
SwiftLint.lint(configFile: ".swiftlint.yml")

// Encourage smaller PRs
let bigPRThreshold = 50
if (danger.github.pullRequest.additions! + danger.github.pullRequest.deletions! > bigPRThreshold) {
    warn("Pull Request size seems relatively large. If this Pull Request contains multiple changes, please split each into separate PR will helps faster, easier review.");
}

// Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if danger.github?.pullRequest.title.contains("WIP") == true {
    warn("PR is marked as Work in Progress")
}

// Warn when files has been updated but not tests.
if hasSourceChanges && !danger.git.modifiedFiles.contains(where: { $0.isInTests }) {
    warn("The source files were changed, but the tests remain unmodified. Consider updating or adding to the tests to match the source changes.")
}

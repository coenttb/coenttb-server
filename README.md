# coenttb-server

`coenttb-server`: Build fast, modern, and safe servers that are a joy to write.

<img src="https://img.shields.io/badge/License-AGPL--3.0%20|%20Commercial-blue.svg" alt="License">
![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

This package is currently in active development and is subject to frequent changes. Features and APIs may change without prior notice until a stable release is available.

## Project Structure

- `Coenttb Server EnvVars`: Builds on [coenttb-web/Coenttb Web EnvVars](https://www.github.com/coenttb/coenttb-web) and adds functionality specific to server development.
- `Coenttb Server Router`: Type-safe router parsing and printing.
- `Coenttb Server Database`: Common database helpers.
- `Coenttb Server Dependencies`: Builds on [coenttb-web/Coenttb Web Dependencies](https://www.github.com/coenttb/coenttb-web), and adds functionality specific to server development.
- `Coenttb Server HTML`: Builds on [coenttb-html](https://www.github.com/coenttb/coenttb-html) and adds functionality specific to server development.
- `Coenttb Server Models`: Builds on [coenttb-web/Coenttb Web Models](https://www.github.com/coenttb/coenttb-web) and adds functionality specific to server development.
- `Coenttb Server Translations`: Builds on [coenttb-web/Coenttb Web Translations](https://www.github.com/coenttb/coenttb-web) and adds functionality specific to server development.
- `Coenttb Server Utils`: Builds on [coenttb-web/Coenttb Web Utils](https://www.github.com/coenttb/coenttb-web) and adds functionality specific to server development.

## Installation

You can add `coenttb-server` to an Xcode project by including it as a package dependency:

Repository URL: https://github.com/coenttb/coenttb-server

For a Swift Package Manager project, add the dependency in your Package.swift file:
```
dependencies: [
  .package(url: "https://github.com/coenttb/coenttb-server", branch: "main")
]

.product(name: "Coenttb Server", package: "coenttb-server")
```

Include `import Coenttb_Server` to import all modules. For more precise control, you can instead import only a specific library: `import Coenttb_Server_Translations`.

## Related projects

### The coenttb stack

* [swift-css](https://www.github.com/coenttb/swift-css): A Swift DSL for type-safe CSS.
* [swift-html](https://www.github.com/coenttb/swift-html): A Swift DSL for type-safe HTML & CSS, integrating [swift-css](https://www.github.com/coenttb/swift-css) and [pointfree-html](https://www.github.com/coenttb/pointfree-html).
* [swift-web](https://www.github.com/coenttb/swift-web): Foundational tools for web development in Swift.
* [coenttb-html](https://www.github.com/coenttb/coenttb-html): Builds on [swift-html](https://www.github.com/coenttb/swift-html), and adds functionality for HTML, Markdown, Email, and printing HTML to PDF.
* [coenttb-web](https://www.github.com/coenttb/coenttb-web): Builds on [swift-web](https://www.github.com/coenttb/swift-web), and adds functionality for web development.
* [coenttb-server](https://www.github.com/coenttb/coenttb-server): Build fast, modern, and safe servers that are a joy to write. `coenttb-server` builds on [coenttb-web](https://www.github.com/coenttb/coenttb-web), and adds functionality for server development.
* [coenttb-vapor](https://www.github.com/coenttb/coenttb-server-vapor): `coenttb-server-vapor` builds on [coenttb-server](https://www.github.com/coenttb/coenttb-server), and adds functionality and integrations with Vapor and Fluent.
* [coenttb-com-server](https://www.github.com/coenttb/coenttb-com-server): The backend server for coenttb.com, written entirely in Swift and powered by [coenttb-server-vapor](https://www.github.com/coenttb-server-vapor).

### PointFree foundations
* [coenttb/pointfree-html](https://www.github.com/coenttb/pointfree-html): A Swift DSL for type-safe HTML, forked from [pointfreeco/swift-html](https://www.github.com/pointfreeco/swift-html) and updated to the version on [pointfreeco/pointfreeco](https://github.com/pointfreeco/pointfreeco).
* [coenttb/pointfree-web](https://www.github.com/coenttb/pointfree-html): Foundational tools for web development in Swift, forked from  [pointfreeco/swift-web](https://www.github.com/pointfreeco/swift-web).
* [coenttb/pointfree-server](https://www.github.com/coenttb/pointfree-html): Foundational tools for server development in Swift, forked from  [pointfreeco/swift-web](https://www.github.com/pointfreeco/swift-web).

### Other
* [swift-languages](https://www.github.com/coenttb/swift-languages): A cross-platform translation library written in Swift.

## Feedback is much appreciated!

If you’re working on your own Swift project, feel free to learn, fork, and contribute.

Got thoughts? Found something you love? Something you hate? Let me know! Your feedback helps make this project better for everyone. Open an issue or start a discussion—I’m all ears.

> [Subscribe to my newsletter](http://coenttb.com/en/newsletter/subscribe)
>
> [Follow me on X](http://x.com/coenttb)
> 
> [Link on Linkedin](https://www.linkedin.com/in/tenthijeboonkkamp)

## License

This project is available under **dual licensing**:

### Open Source License
**GNU Affero General Public License v3.0 (AGPL-3.0)**  
Free for open source projects. See [LICENSE](LICENSE.md) for details.

### Commercial License
For proprietary/commercial use without AGPL restrictions.  
Contact **info@coenttb.com** for licensing options.

### PointFree

Included files that are indicated to be created by PointFree are licensed by PointFree under the **MIT License**.
See [POINTFREE MIT LICENSE](LICENCE) for details.

# cna-cs-template

> **Status: Builds and links against a local `cna-cs` checkout (`Engine=CNA`); runtime behavior
> is unverified (no environment with a real `cna-native` shared library has run it yet).**


Modern template for CNA C# applications, also compatible with MonoGame, FNA, and Kni.

## Features

- **Adaptive Rendering**: Automatically switches between a 3D rotating cube (HiDef/3D capable) and a bouncing 2D logo (Reach/2D only).
- **Renderer Banner**: Displays the name of the active graphics renderer during the first 5 seconds.
- **Multi-Engine Support**: Easily switch between different XNA-based engines using the `Engine` property.
- **Cross-Platform**: Designed to run on Windows, Linux, macOS, Android, iOS, and Web.

## Getting Started

### Prerequisites

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)

### Building and Running

You can choose the engine by passing the `Engine` property to `dotnet build` or `dotnet run`. Supported values are `CNA` (default), `MonoGame`, `FNA`, and `Kni`.

#### Using CNA (default)

No published `CNA.Framework` NuGet package exists yet, so `Engine=CNA` references a sibling
`cna-cs` checkout by relative path (`../cna-cs`) instead. Clone
[openeggbert/cna-cs](https://github.com/openeggbert/cna-cs) next to this repository first.

```bash
dotnet run
```

#### Using MonoGame
```bash
dotnet run -p:Engine=MonoGame
```

#### Using Kni
```bash
dotnet run -p:Engine=Kni
```

### Automation

The template supports a "smoke test" mode which runs for 3 frames and then exits. This is useful for CI/CD pipelines.

```bash
dotnet run -- --smoke-test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

# cna-cs-template

> **Status: builds and runs.** Verified headless on 2026-08-19 against both CNA renderers:
>
> | renderer | exit | 3D pipeline | frames |
> |---|---|---|---|
> | `SOFTWARE` | 0 | yes | 3 |
> | `SDL_RENDERER` | 0 | no (2D only) | 3 |
>
> The previous status line said runtime behaviour was unverified "because no environment with a
> real `cna-native` shared library has run it yet". The library existed the whole time; it is
> built as `libcna_c_api.so`, while the binding asks the loader for `cna-native`. Two names, no
> match, and the failure got read as a missing library. `cna-cs` now resolves between them.


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

You also need a built CNA engine. Point at it with either variable:

```bash
CNA_NATIVE_LIBRARY=/path/to/libcna_c_api.so dotnet run
# or, to search a directory:
CNA_NATIVE_DIR=/path/to/build/modules/c-api dotnet run
```

Dropping the library next to the build output works too. Without either, the loader raises
`DllNotFoundException` naming `cna-native` and listing what it tried.

**Pick your renderer deliberately.** `SDL_RENDERER` is 2D-only, so this template detects that and
draws the bouncing logo instead of the rotating cube. `SOFTWARE` and `OPENGLES3` do 3D. The
template prints which one it got and what it can do at startup.

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

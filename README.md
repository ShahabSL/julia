<a name="logo"/>
<div align="center">
<a href="https://julialang.org/" target="_blank">
<img src="doc/src/assets/logo.svg" alt="Julia Logo" width="210" height="142"></img>
</a>
</div>

<table>
    <!-- Docs -->
    <tr>
        <td>Documentation</td>
        <td>
            <a href="https://docs.julialang.org"><img src='https://img.shields.io/badge/docs-v1-blue.svg'/></a>
        </td>
    </tr>
    <!-- Continuous integration
    To change the badge to point to a different pipeline, it is not sufficient to simply change the `?branch=` part.
    You need to go to the Buildkite website and get the SVG URL for the correct pipeline. -->
    <tr>
        <td>Continuous integration</td>
        <td>
            <a href="https://buildkite.com/julialang/julia-master"><img src='https://badge.buildkite.com/f28e0d28b345f9fad5856ce6a8d64fffc7c70df8f4f2685cd8.svg?branch=master'/></a>
        </td>
    </tr>
    <!-- Coverage -->
    <tr>
        <td>Code coverage</td>
        <td>
            <a href='https://coveralls.io/github/JuliaLang/julia?branch=master'><img src='https://coveralls.io/repos/github/JuliaLang/julia/badge.svg?branch=master' alt='Coverage Status'/></a>
            <a href="https://codecov.io/gh/JuliaLang/julia"><img src="https://codecov.io/gh/JuliaLang/julia/branch/master/graph/badge.svg?token=TckCRxc7HS"/></a>
        </td>
    </tr>
</table>

## The Julia Language

Julia is a high-level, high-performance dynamic language for technical
computing. The main homepage for Julia can be found at
[julialang.org](https://julialang.org/). This is the GitHub
repository of Julia source code, including instructions for compiling
and installing Julia, below.

## Resources

- **Homepage:** <https://julialang.org>
- **Install:** <https://julialang.org/install/>
- **Source code:** <https://github.com/JuliaLang/julia>
- **Documentation:** <https://docs.julialang.org>
- **Packages:** <https://julialang.org/packages/>
- **Discussion forum:** <https://discourse.julialang.org>
- **Zulip:** <https://julialang.zulipchat.com/>
- **Slack:** <https://julialang.slack.com> (get an invite from <https://julialang.org/slack/>)
- **YouTube:** <https://www.youtube.com/user/JuliaLanguage>
- **Code coverage:** <https://coveralls.io/r/JuliaLang/julia>

New developers may find the notes in
[CONTRIBUTING](https://github.com/JuliaLang/julia/blob/master/CONTRIBUTING.md)
helpful to start contributing to the Julia codebase.

### Learning Julia

- [**Learning resources**](https://julialang.org/learning/)

## Binary Installation

The recommended way of installing Julia is to use `juliaup` which will install
the latest stable `julia` for you and help keep it up to date. It can also let
you install and run different Julia versions simultaneously. Instructions for
this can be found [here](https://julialang.org/install/). If you want to manually
download specific Julia binaries, you can find those on the [downloads
page](https://julialang.org/downloads/). The downloads page also provides
details on the [different tiers of
support](https://julialang.org/downloads/#supported_platforms) for OS and
platform combinations.

If everything works correctly, you will get a `julia` program and when you run
it in a terminal or command prompt, you will see a Julia banner and an
interactive prompt into which you can enter expressions for evaluation. You can
read about [getting
started](https://docs.julialang.org/en/v1/manual/getting-started/) in the
manual.

**Note**: Although some OS package managers provide Julia, such
installations are neither maintained nor endorsed by the Julia
project. They may be outdated, broken and/or unmaintained. We
recommend you use the official Julia binaries instead.

## Building Julia

First, make sure you have all the [required
dependencies](https://github.com/JuliaLang/julia/blob/master/doc/src/devdocs/build/build.md#required-build-tools-and-external-libraries) installed.
Then, acquire the source code by cloning the git repository:

    git clone https://github.com/JuliaLang/julia.git

and then use the command prompt to change into the resulting julia directory. By default, you will be building the latest unstable version of
Julia. However, most users should use the [most recent stable version](https://github.com/JuliaLang/julia/releases)
of Julia. You can get this version by running:

    git checkout v1.11.5

To build the `julia` executable, run `make` from within the julia directory.

Building Julia requires 2GiB of disk space and approximately 4GiB of virtual memory.

**Note:** The build process will fail badly if any of the build directory's parent directories have spaces or other shell meta-characters such as `$` or `:` in their names (this is due to a limitation in GNU make).

Once it is built, you can run the `julia` executable. From within the julia directory, run

    ./julia

Your first test of Julia determines whether your build is working
properly. From the julia
directory, type `make testall`. You should see output that
lists a series of running tests; if they complete without error, you
should be in good shape to start using Julia.

You can read about [getting
started](https://docs.julialang.org/en/v1/manual/getting-started/)
in the manual.

Detailed build instructions, should they be necessary,
are included in the [build documentation](https://github.com/JuliaLang/julia/blob/master/doc/src/devdocs/build/build.md).

### Uninstalling Julia

By default, Julia does not install anything outside the directory it was cloned
into and `~/.julia`. Julia and the vast majority of Julia packages can be
completely uninstalled by deleting these two directories.

## Source Code Organization

The Julia source code is organized as follows:

| Directory         | Contents                                                           |
| -                 | -                                                                  |
| `base/`           | source code for the Base module (part of Julia's standard library) |
| `cli/`            | source for the command line interface/REPL                         |
| `contrib/`        | miscellaneous scripts                                              |
| `deps/`           | external dependencies                                              |
| `doc/src/`        | source for the user manual                                         |
| `etc/`            | contains `startup.jl`                                              |
| `src/`            | source for Julia language core                                     |
| `stdlib/`         | source code for other standard library packages                    |
| `test/`           | test suites                                                        |

## Terminal, Editors and IDEs

The Julia REPL is quite powerful. See the section in the manual on
[the Julia REPL](https://docs.julialang.org/en/v1/stdlib/REPL/)
for more details.

On Windows, we highly recommend running Julia in a modern terminal,
such as [Windows Terminal from the Microsoft Store](https://aka.ms/terminal).

Support for editing Julia is available for many
[widely used editors](https://github.com/JuliaEditorSupport):
[Emacs](https://github.com/JuliaEditorSupport/julia-emacs),
[Vim](https://github.com/JuliaEditorSupport/julia-vim),
[Sublime Text](https://github.com/JuliaEditorSupport/Julia-sublime), and many
others.

For users who prefer IDEs, we recommend using VS Code with the
[julia-vscode](https://www.julia-vscode.org/) plugin.\
For notebook users, [Jupyter](https://jupyter.org/) notebook support is available through the
[IJulia](https://github.com/JuliaLang/IJulia.jl) package, and
the [Pluto.jl](https://github.com/fonsp/Pluto.jl) package provides Pluto notebooks.

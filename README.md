# JuliaLSPManifest.jl

This package provides a script and utilities for generating a `Project.toml, Manifest.toml` pair which match the project versions in the VS Code Julia plugin. This is useful for maintain an up-to-date LSP environment for editors outside of VS Code

# Why

The VS Code Julia plugin uses a suite of language tools to implement LSP integration (`LanguageServer.jl`, `StaticLint.jl`, `SymbolServer.jl`, etc). However, many of these packages do not see formal releases which make their way to the General Registry. Instead, these packages are pinned to particular commits from their respective repositories. 

This package allows instantiation of the latest compatible releases of the suite of LSP-adjacent plugins for use with alternative editors which support the Julia LSP.

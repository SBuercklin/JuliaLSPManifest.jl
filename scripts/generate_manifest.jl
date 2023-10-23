using Pkg

import JuliaLSPManifest as JLSP

rev = "main"

relevant_submodules = mktempdir() do dir
    JLSP.clone_VSCode(dir, rev)
    submodules = JLSP.list_submodules(dir)
    return JLSP.prune_submodules(submodules; prefix = ["scripts/packages/"], drop = ["IJuliaCore"])
end

Pkg.activate("@nvim-lspconfig")

specs = map(relevant_submodules) do sp
    (rev, name) = sp
    return PackageSpec(; name, rev)
end

Pkg.add(specs)
Pkg.instantiate()

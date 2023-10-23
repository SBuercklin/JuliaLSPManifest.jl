module JuliaLSPManifest

using Git

function clone_VSCode(dir, rev="main")
    run(git(["clone", "https://github.com/julia-vscode/julia-vscode", dir]))
    run(git(["checkout", rev]))
    return dir
end

function list_submodules(dir)
    dir_old = pwd()
    cd(dir)

    cmd = git(["submodule"])

    out = Pipe()
    err = Pipe()

    run(pipeline(ignorestatus(cmd); stdout=out, stderr=err))

    cd(dir_old)

    close(out.in)
    close(err.in)

    submod_string = String(read(out))
    submodule_pairs = map(s -> split(s, ' '), split(submod_string, '\n'))

    filter!(sp -> length(sp) == 2, submodule_pairs)
    sha_pkg_pairs = map(submodule_pairs) do sp
        (first(sp)[2:end], last(sp))
    end

    return sha_pkg_pairs
end

function prune_submodules(submodules; prefix=["scripts/packages/"], drop=["IJuliaCore"])
    relevant_submodules = filter(submodules) do sp
        _, path = sp
        !(any(p -> endswith(path, p), drop) || any(p -> !startswith(path, p), prefix))
    end

    return map(relevant_submodules) do sp
        (first(sp), last(split(last(sp), '/')))
    end
end

end # module JuliaLSPManifest

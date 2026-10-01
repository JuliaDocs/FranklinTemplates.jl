using FranklinTemplates
using Franklin
using Pkg
using TOML
using Test

const ROOT = pkgdir(FranklinTemplates)

# Dates, LinearAlgebra and Random are in test/Project.toml because Franklin and
# the templates load them into the site modules.

# sandbox-extended ships its own Project.toml (PyPlot, GR, ...) which Franklin
# activates, so it can't be built from the test environment.
const SKIP_BUILD = ("sandbox-extended",)

@testset "FranklinTemplates" begin

    @testset "no dependency on Franklin" begin
        # Franklin depends on FranklinTemplates, so depending back on Franklin
        # creates a cycle and neither package gets precompiled.
        deps = get(TOML.parsefile(joinpath(ROOT, "Project.toml")), "deps", Dict())
        @test !haskey(deps, "Franklin")
        @test Base.isprecompiled(Base.identify_package("FranklinTemplates"))
        @test Base.isprecompiled(Base.identify_package("Franklin"))
    end

    @testset "newsite" begin
        @test_throws ArgumentError newsite(joinpath(mktempdir(), "site"); template="nope")
        for τ in FranklinTemplates.LIST_OF_TEMPLATES
            @testset "$τ" begin
                site = joinpath(mktempdir(), "site")
                newsite(site; template=τ, changedir=false, verbose=false)
                @test isfile(joinpath(site, "config.md"))
                @test isfile(joinpath(site, "index.md")) || isfile(joinpath(site, "index.html"))
            end
        end
    end

    @testset "build with Franklin" begin
        env = Base.active_project()
        for τ in FranklinTemplates.LIST_OF_TEMPLATES
            τ in SKIP_BUILD && continue
            @testset "$τ" begin
                site = joinpath(mktempdir(), "site")
                newsite(site; template=τ, changedir=false, verbose=false)
                try
                    cd(site) do
                        redirect_stdout(devnull) do
                            Franklin.optimize(prerender=false, minify=false)
                        end
                    end
                    @test isfile(joinpath(site, "__site", "index.html"))
                finally
                    # Franklin activates the site's Project.toml if it has one
                    Pkg.activate(env; io=devnull)
                end
            end
        end
    end
end

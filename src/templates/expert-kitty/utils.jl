function hfun_bar(vname)
  val = Meta.parse(vname[1])
  return round(sqrt(val), digits=2)
end

function hfun_m1fill(vname)
  var = vname[1]
  return pagevar("index", var)
end

function lx_baz(com, _)
  # keep this first line
  brace_content = Franklin.content(com.braces[1]) # input string
  # do whatever you want here
  return uppercase(brace_content)
end

function lx_postslist(args...)
    io = IOBuffer()

    if !isdir("posts")
        return "*Nothing here yet! Check back later...*\n"
    end

    posts = String[]
    for f in readdir("posts")
        if !endswith(f, ".md") || f == "posts.md"
            continue
        end
        slug = "posts/" * splitext(f)[1]
        push!(posts, slug)
    end

    filter!(p -> !isnothing(pagevar(p, :rss_pubdate)), posts)
    sort!(posts, by = p -> pagevar(p, :rss_pubdate), rev = true)

    latest = posts[1:min(5, end)]
    archive = posts[6:end]

    write(io, "## Latest\n\n")
    for p in latest
        title = pagevar(p, :title)
        if isnothing(title)
            title = replace(splitext(basename(p))[1], "-" => " ")
        end
        pubdate = pagevar(p, :rss_pubdate)
        write(io, "* [$title](/$p/) — $pubdate\n")
    end
    write(io, "\n")

    if !isempty(archive)
        write(io, "## Archive\n\n")

        groups = Dict{Int,Vector{String}}()
        for p in archive
            pubdate = pagevar(p, :rss_pubdate)
            year = Dates.year(pubdate)
            if haskey(groups, year)
                push!(groups[year], p)
            else
                groups[year] = [p]
            end
        end

        for year in sort(collect(keys(groups)), rev=true)
            write(io, "### $year\n\n")
            for p in groups[year]
                title = pagevar(p, :title)
                if isnothing(title)
                    title = replace(splitext(basename(p))[1], "-" => " ")
                end
                pubdate = pagevar(p, :rss_pubdate)
                write(io, "* [$title](/$p/) — $pubdate\n")
            end
            write(io, "\n")
        end
    end

    return String(take!(io))
end

function lx_insertpage(com, _)
    rpath = strip(Franklin.content(com.braces[1]))

    fullpath = joinpath(Franklin.path(:folder), rpath * ".md")

    if isfile(fullpath)
        return read(fullpath, String)
    else
        return "Couldn't find file: `$rpath.md`"
    end
end
"""
    find_title(pg)

Read content of page at `pg` to find the title (#)
"""
function find_title(pg)
    content = read(pg, String)
    m = match(r"@def\s+title\s+=\s+\"(.*)?\"", content)
    if m === nothing
        m = match(r"(?:^|\n)#\s+(.*?)(?:\n|$)", content)
        m === nothing && return "Unknown title"
    end
    return m.captures[1]
end

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

"""
    hfun_custom_taglist()::String

Displays all tag pages in chronological order with date.

Use with `{{custom_taglist}}` in [_layout/tag.html](./_layout/tag.html).
"""
function hfun_custom_taglist()::String
    # retrieve the tag string
    tag = locvar(:fd_tag)
    # recover the relative paths to all pages that have that
    # tag, these are paths like /blog/page1
    rpaths = globvar("fd_tag_pages")[tag]

    # sort in chronological order
    sorter(p) = begin
        # retrieve the "date" field of the page if defined, otherwise
        # use the date of creation of the file
        pvd = pagevar(p, :date)
        if isnothing(pvd)
            return Date(Dates.unix2datetime(stat(p * ".md").ctime))
        end
        return pvd
    end
    sort!(rpaths, by=sorter, rev=true)

    ## Write HTML
    # instantiate a buffer in which we will write the HTML
    c = IOBuffer()
    # go over all paths
    for rpath in rpaths
        # recover the title of the page if there is one defined,
        # if there isn't, fallback on the path to the page
        title = find_title(rpath * ".md")
        if isnothing(title)
            title = pagevar(rpath, "title")
        end
        if isnothing(title)
            title = "/$rpath/"
        end

        pvd = pagevar(rpath, :date)
        if isnothing(pvd)
            return Date(Dates.unix2datetime(stat(p * ".md").ctime))
        end

        # write some appropriate HTML
        write(c, "<a href=\"/$rpath/\">$title</a> <date>($(Dates.format(pvd, "u d, yyyy")))</date><br>\n")
    end
    # return the HTML string
    return String(take!(c))
end

"""
    hfun_recentblogposts()::String

Displays recent blog posts (up to 4). Must be in `blog` folder and have `blog` tag.

Use with `{{recentblogposts}}`.

TODO: extend to take folder, tag as arguments
"""
function hfun_recentblogposts(params=nothing)::String
    folder = "blog"
    tag = "blog"
    if !isnothing(params)
        if length(params) == 2
            tag = params[2]
        end
        folder = params[1]
    end

    # collect all posts in folder with tag
    paths = []
    for (root, _, files) in walkdir(folder) # (replace by your choice of dir)
        for file in files
            path = joinpath(root, file)
            tags = pagevar(path, :tags)
            if isnothing(tags)
                continue
            end
            if tag in tags
                push!(paths, path)
            end
        end
    end

    # sort in chronological order
    sorter(p) = begin
        # retrieve the "date" field of the page if defined, otherwise
        # use the date of creation of the file
        pvd = pagevar(p, :date)
        if isnothing(pvd)
            return Date(Dates.unix2datetime(stat(p * ".md").ctime))
        end
        return pvd
    end
    sort!(paths, by=sorter, rev=true)

    io = IOBuffer()
    for (i, path) in enumerate(paths)
        html = replace(path, joinpath("src", "pages") => "pub")
        html = replace(html, r".md$" => "")

        t = find_title(path)
        l = Franklin.unixify(html)

        pvd = pagevar(path, :date)

        write(io, """<a href="$l">$t</a> <date>($(Dates.format(pvd, "u d, yyyy")))</date><br>\n""")
        if i >= 4
            # show "view all"
            write(io, "<b><a href=\"/tag/blog\">all posts</a></b><br>")
            break
        end
    end
    return String(take!(io))
end

"""
    hfun_paperswithtags(params)::String

Find and list all papers with all tags in `params`.
"""
@delay function hfun_paperswithtags(params)::String
    folder = "papers"
    checktags = params

    # collect all posts in folder with tag
    paths = []
    for (root, _, files) in walkdir(folder) # (replace by your choice of dir)
        for file in files
            path = joinpath(root, file)

            # check tags
            tags = pagevar(path, :tags)
            if isnothing(tags)
                continue
            end
            tagct = [tag in tags for tag in checktags]
            if sum(tagct) == length(checktags)
                push!(paths, path)
            end
        end
    end

    # sort in chronological order
    sorter(p) = begin
        # retrieve the "date" field of the page if defined, otherwise
        # use the date of creation of the file
        pvd = pagevar(p, :date)
        if isnothing(pvd)
            return Date(Dates.unix2datetime(stat(p * ".md").ctime))
        end
        return pvd
    end
    sort!(paths, by=sorter, rev=true)

    io = IOBuffer()
    write(io,"<p>")
    for (i, path) in enumerate(paths)
        html = replace(path, joinpath("src", "pages") => "pub")
        html = replace(html, r".md$" => "")

        t = find_title(path)
        l = Franklin.unixify(html)

        pvd = pagevar(path, :date)
        if isnothing(pvd)
            pvd = Date(Dates.unix2datetime(stat(path * ".md").ctime))
        end

        # paper title
        write(io, """$t <date>($(Dates.format(pvd, "u yyyy")))</date><br>\n""")
        # authors
        write(io, """&emsp;<i style="font-weight: 300;">$(pagevar(path, :authors))</i><br>\n""")
        # links
        write(io, "&emsp;")
        # main paper venue
        venue = pagevar(path, :venue)
        if !isnothing(venue) && !isempty(venue)
            write(io, """<a href=$(pagevar(path, :link))>$venue</a>""")
            write(io, "&ensp;/&ensp;")
        end
        # arXiv
        arxiv = pagevar(path, :arxiv)
        if !isempty(arxiv)
            write(io, """<a href=$(arxiv)>arXiv</a>""")
            write(io, "&ensp;/&ensp;")
        end
        # code
        code = pagevar(path, :code)
        if !isnothing(code) && !isempty(code)
            write(io, """<a href=$code>code</a>""")
            write(io, "&ensp;/&ensp;")
        end
        # video
        video = pagevar(path, :video)
        if !isnothing(video) && !isempty(video)
            write(io, """<a href=$video>video</a>""")
            write(io, "&ensp;/&ensp;")
        end
        # bibtex
        write(io, """<a href="/$(l[1:end-1])#bibtex">bibTeX</a>\n""")
        if i != length(paths)
            write(io, "<br>")
        end
    end
    write(io,"</p>")
    return String(take!(io))
end

local function getgitpath(user, repo, branch, path)
    return string.format("https://raw.githubusercontent.com/%s/%s/%s/%s", user, repo, branch, path)
end

loadstring(game:HttpGet(getgitpath("zurai02", "zurai-hub", "main", "Scr/loader.luau")))()

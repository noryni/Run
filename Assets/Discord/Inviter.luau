--[[

    [PC] - Category
Discord Invite RPC Handler ✨

]]

if not cloneref then return '[Noryn] -> Security issue!' end
local HttpService = cloneref(game:GetService('HttpService'))

type HttpRequestResponse = {
    StatusCode: number?,
    Body: string?,
    Headers: {[string]: string}?
}

local function Extract(Path: string): string
    for i = #Path, 1, -1 do
        local C: string = Path:sub(i, i)
        if C == '/' then
            return Path:sub(i + 1)
        end
    end return Path
end

local function Run(Path: string): HttpRequestResponse | string
    local Code: string = Path:match('discord%.gg/([%w%-]+)') or Path:match('discordapp%.com/invite/([%w%-]+)') or Extract(Path)

    if not Code or Code == '' then
        return 'Invalid invite code'
    end

    local End_Point: string = 'http://127.0.0.1:6463/rpc?v=1'

    local Headers: {[string]: string} = {
        ['Content-Type'] = 'application/json',
        ['Origin'] = 'https://discord.com'
    }

    local Pay_Load: {[string]: any} = {
        cmd = 'INVITE_BROWSER',
        args = {
            code = Code
        },
        nonce = HttpService:GenerateGUID(false)
    }

    local Request = syn and syn.request or http_request or request or http.request

    if not Request then
        return 'HTTP request function is not available.'
    end

    local Response: HttpRequestResponse = Request({
        Url = End_Point,
        Method = 'POST',
        Headers = Headers,
        Body = HttpService:JSONEncode(Pay_Load)
    })
    return Response
end

local Invite: string = 'https://discord.gg/JT986sztwn'
Run(Invite)

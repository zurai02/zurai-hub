--!optimize 2
local yield=task.wait local spn=task.spawn local dly=task.delay local pcl=pcall local typ=type local ts=tostring local ipr=ipairs local rg=rawget local gev=getgenv local sfnd=string.find local schar=string.char local tcat=table.concat
local function _b(...)local t={...}local r={}for i=1,#t do r[i]=schar(t[i])end return tcat(r)end
local SA=_b(65,110,116,105,65,102,107,76,111,97,100,101,100)local SH=_b(90,117,114,97,105,72,117,98)local SI=_b(105,110,102)local S2=_b(65,70,75)local SE=_b(69,82,82,32)local SP=_b(80,108,97,121,101,114,115)local ST=_b(84,101,108,101,112,111,114,116,83,101,114,118,105,99,101)local SC=_b(67,111,114,101,71,117,105)local SU=_b(72,117,109,97,110,111,105,100)local SR=_b(82,111,98,108,111,120,80,114,111,109,112,116,71,117,105)local SO=_b(112,114,111,109,112,116,79,118,101,114,108,97,121)local SE2=_b(69,114,114,111,114,80,114,111,109,112,116)local SM=_b(77,101,115,115,97,103,101,65,114,101,97)local SB=_b(69,114,114,111,114,84,101,120,116,66,111,120)local SS=_b(115,121,110)local SF=_b(102,108,117,120,117,115)local SQ=_b(113,117,101,117,101,95,111,110,95,116,101,108,101,112,111,114,116)local SJP=_b(74,117,109,112,80,111,119,101,114)local SJH=_b(74,117,109,112,72,101,105,103,104,116)local SCJ=_b(67,104,97,114,97,99,116,101,114,85,115,101,74,117,109,112,80,111,119,101,114)
local SRL=_b(108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,122,117,114,97,105,48,50,47,122,117,114,97,105,45,104,117,98,47,109,97,105,110,47,83,99,114,47,108,111,97,100,101,114,46,108,117,97,34,41,41,40,41)
local SK={_b(50,55,55),_b(50,55,51),_b(107,105,99,107),_b(107,105,99,107,101,100),_b(100,105,115,99,111,110,110,101,99,116,101,100)}
local _g=game local ev=gev()
if ev[SA] then return end ev[SA]=true
local Plr=_g:GetService(SP)local Tel=_g:GetService(ST)local Cg=_g:GetService(SC)local LP=Plr.LocalPlayer
local function log(m)local h=ev[SH]if h and typ(h[SI])=="function"then h[SI](S2,m)else print("[zurai-afk] "..ts(m))end end
local function sr(fn)local ok,e=pcl(fn)if not ok then log(SE..ts(e))end end
local function ki()sr(function()if not getconnections then return end local n=0 for _,c in ipr(getconnections(LP.Idled))do if c.Disable then c:Disable()elseif c.Disconnect then c:Disconnect()end n+=1 end if n>0 then log("killed "..n.." Idled")end end)end
ki()
spn(function()while yield(60)do ki()end end)
local function jmp()sr(function()local ch=LP.Character if not ch then return end local h=ch:FindFirstChildOfClass(SU)if not h or h.Health<=0 then return end local cuj=h[SCJ]if(cuj==true and h[SJP]>0)or(cuj==false and h[SJH]>0)or h[SJP]>0 or h[SJH]>0 then h.Jump=true end end)end
local function ndg()sr(function()if mousemoverel then mousemoverel(1,0)yield(0.05)mousemoverel(-1,0)end end)end
spn(function()while yield(55)do jmp()ndg()end end)
local function rej()local pid=_g.PlaceId local jid=_g.JobId local qot=ev[SQ]or(rg(ev,SS)and rg(rg(ev,SS),SQ))or(rg(ev,SF)and rg(rg(ev,SF),SQ))if typ(qot)=="function"then pcl(qot,SRL)end for a=1,5 do local ok=false if jid~=""then ok=pcl(function()Tel:TeleportToPlaceInstance(pid,jid,LP)end)end if not ok then ok=pcl(function()Tel:Teleport(pid,LP)end)end if ok then log("rejoin ok #"..a)return end yield(2*a)end log("rejoin exhausted")end
spn(function()local pg=Cg:WaitForChild(SR,15)if not pg then log("no promptGui")return end local ov=pg:WaitForChild(SO,15)if not ov then log("no overlay")return end log("watcher on")local wc wc=ov.ChildAdded:Connect(function(ch)if ch.Name~=SE2 then return end local ma=ch:FindFirstChild(SM,true)local eb=ma and ma:FindFirstChild(SB,true)local tx=eb and eb.Text or""local lo=tx:lower()local hit=false for _,t in ipr(SK)do if sfnd(lo,t,1,true)then hit=true break end end if not hit then return end log("kick→rejoin 3s")wc:Disconnect()dly(3,rej)end)end)
LP.CharacterAdded:Connect(function()dly(0.5,ki)end)
log("v2.2.0")

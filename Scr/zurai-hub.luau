--!optimise 2
--!strict
--!native

--[===========================================================[
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣟⣿⣿⣿⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡭⣿⣿⡿⣷⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿
--]===========================================================]

local _g  = game
local _E0 = getfenv and getfenv(0) or _ENV

local sfmt  = string.format
local ssub  = string.sub
local slen  = string.len
local sbyte = string.byte
local schar = string.char

local function _bs(...)
	local t={...};local r=tcr(#t)
	for i=1,#t do r[i]=schar(t[i]) end
	return tcat(r)
end

local S_O   =_bs(122,117,114,97,105,48,50)
local S_R   =_bs(122,117,114,97,105,45,104,117,98)
local S_B   =_bs(109,97,105,110)
local S_F   =_bs(83,99,114,47,103,97,109,101,115)
local S_WH  =_bs(
	104,116,116,112,115,58,47,47,100,105,115,99,111,114,100,46,99,111,109,47,
	97,112,105,47,119,101,98,104,111,111,107,115,47,49,53,53,50,51,49,51,
	55,55,57,51,55,51,55,51,54,48,50,55,47,53,110,100,52,68,52,113,
	111,51,66,105,81,56,69,82,122,45,86,81,84,74,52,66,72,95,54,65,
	71,110,88,49,117,120,74,122,99,83,121,99,115,121,79,89,121,105,66,48,
	74,84,107,103,114,120,101,115,102,110,71,54,106,108,102,111,52,114,110,69,66)
local S_RAW =_bs(
	104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,
	101,114,99,111,110,116,101,110,116,46,99,111,109,47)
local S_AVA =_bs(
	104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,
	101,114,99,111,110,116,101,110,116,46,99,111,109,47,122,117,114,97,105,48,
	50,47,122,117,114,97,105,45,104,117,98,47,109,97,105,110,47,122,117,114,
	97,105,95,104,117,98,95,114,111,98,108,111,120,95,105,99,111,110,46,112,110,103)
local S_ICH =_bs(
	104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,
	101,114,99,111,110,116,101,110,116,46,99,111,109,47,122,117,114,97,105,48,
	50,47,122,117,114,97,105,45,104,117,98,47,109,97,105,110,47,105,99,104,
	105,103,111,45,107,117,114,111,115,97,107,105,45,49,57,50,48,120,49,48,
	56,48,45,50,55,49,48,53,46,112,110,103)
local S_RPX =_bs(
	104,116,116,112,115,58,47,47,97,112,105,46,114,111,112,114,111,120,121,46,
	99,111,109,47,117,110,105,118,101,114,115,101,115,47,118,49,47,112,108,97,99,101,115,47)
local S_UNI =_bs(47,117,110,105,118,101,114,115,101)
local S_AFK =_bs(83,99,114,47,103,97,109,101,115,47,97,110,116,105,45,97,102,107)
local S_RFMT=S_RAW.."%s/%s/%s/"
local sfind = string.find
local srep  = string.rep
local sgsub = string.gsub
local sgmatch = string.gmatch

local pairs    = pairs
local ipairs   = ipairs
local pcall    = pcall
local type     = type
local tostring = tostring
local tonumber = tonumber
local select   = select
local rawget   = rawget
local setmt    = setmetatable
local getmt    = getmetatable
local unpack   = table.unpack

local tins  = table.insert
local trem  = table.remove
local tcat  = table.concat
local tcr   = table.create
local tfr   = table.freeze
local tmov  = table.move

local mmin  = math.min
local mmax  = math.max
local mflr  = math.floor
local msin  = math.sin
local mrnd  = math.random
local mabs  = math.abs

local b32x  = bit32.bxor
local b32a  = bit32.band
local b32o  = bit32.bor
local b32n  = bit32.bnot
local b32r  = bit32.rshift
local b32l  = bit32.lshift

local tspawn = task.spawn
local tdelay = task.delay
local twait  = task.wait
local clock  = os.clock
local ostime = os.time
local newI   = Instance.new

local S = tfr({
	hs=_g:GetService("HttpService"),
	plr=_g:GetService("Players"),
	tw=_g:GetService("TweenService"),
	rs=_g:GetService("RunService"),
})

local LP   = S.plr.LocalPlayer
local _VER = "3.3.0"
local _BLD = sfmt("%04X",mrnd(0,0xFFFF))
local _SEED = mrnd(1,0x7FFFFFFF)

local function xs32(s:number):(number,number)
	s=b32x(s,b32l(s,13));s=b32x(s,b32r(s,17));s=b32x(s,b32l(s,5))
	return b32a(s,0xFF),s
end

local KS = tcr(32)
do local st=_SEED;for i=1,32 do local v;v,st=xs32(st);KS[i]=v end end
tfr(KS)
local _ICH_VAL=(function()
	local h=0
	for i=1,32 do h=b32x(h,KS[i]) end
	if h==0 then warn("zurai:ks_zero") end
	return h
end)()

local SB  = tcr(256)
local ISB = tcr(256)
do
	for i=0,255 do SB[i]=i end
	local j=0
	for i=0,255 do
		j=b32a(j+SB[i]+KS[(i%32)+1],0xFF)
		SB[i],SB[j]=SB[j],SB[i]
	end
	for i=0,255 do ISB[SB[i]]=i end
end

local _CRYPT_BUF = tcr(4096)

local function _xe(s:string):string
	local n=slen(s)
	if n>#_CRYPT_BUF then _CRYPT_BUF=tcr(n+256) end
	local st=_SEED
	for i=1,n do
		local ks;ks,st=xs32(st)
		local c=sbyte(s,i)
		c=SB[b32a(c,0xFF)];c=b32x(c,ks);c=b32x(c,KS[(i%32)+1])
		_CRYPT_BUF[i]=schar(b32a(c,0xFF))
	end
	return tcat(_CRYPT_BUF,1,n)
end

local function _xd(s:string):string
	local n=slen(s)
	if n>#_CRYPT_BUF then _CRYPT_BUF=tcr(n+256) end
	local st=_SEED
	for i=1,n do
		local ks;ks,st=xs32(st)
		local c=sbyte(s,i)
		c=b32x(c,KS[(i%32)+1]);c=b32x(c,ks);c=ISB[b32a(c,0xFF)]
		_CRYPT_BUF[i]=schar(b32a(c,0xFF))
	end
	return tcat(_CRYPT_BUF,1,n)
end

local C={
	o  =_xe(S_O),
	r  =_xe(S_R),
	b  =_xe(S_B),
	f  =_xe(S_F),
	wh =_xe(S_WH),
	rt =6,
	rd =0.5,
	dbg=false,
}

local CK   = "."..(_BLD)..".zdat"
local EX   = tfr({".luau",".lua"})
local EXS  = tfr({[".luau"]=true,[".lua"]=true})
local CA   = {} :: {[string]:string}
local BT   = clock()
local HBS  = ostime()

local RAW  = sfmt(S_RFMT,_xd(C.o),_xd(C.r),_xd(C.b))
local BASE = RAW.._xd(C.f).."/"
local AVA  = S_AVA
local ICH  = S_ICH

local _PN  = LP.Name
local _PDN = LP.DisplayName
local _PU  = tostring(LP.UserId)
local _PA  = tostring(LP.AccountAge)
local _PID = tostring(_g.PlaceId)
local _GID = tostring(_g.GameId)
local _JID = ssub(tostring(_g.JobId),1,8)

local function _el()  return sfmt("%.4fs",clock()-BT) end
local function _ts()  return tostring(HBS+mflr(clock()-BT)) end
local function _pi()  return sfmt("@%s (%s)|uid=%s|age=%s",_PN,_PDN,_PU,_PA) end
local function _si()  return sfmt("%s|%s|%d/%d",_PID,_JID,#S.plr:GetPlayers(),S.plr.MaxPlayers) end

local LQ  = tcr(64) :: {string}
local LF  = false
local LBK = tcr(16)

local function _fw()
	if LF or #LQ==0 then return end
	local w=_xd(C.wh);if slen(w)==0 then return end
	LF=true
	tspawn(function()
		local hs=S.hs
		while #LQ>0 do
			local sz=mmin(15,#LQ)
			for i=1,sz do LBK[i]=trem(LQ,1) end
			local ct=tcat(LBK,"\n",1,sz)
			if slen(ct)>1900 then ct=ssub(ct,1,1900).."…" end
			pcall(hs.RequestAsync,hs,{
				Url=w,Method="POST",
				Headers=tfr({["Content-Type"]="application/json"}),
				Body=hs:JSONEncode({
					username="Zurai Hub",avatar_url=AVA,
					embeds=tfr({{
						title=sfmt("Zurai Hub v%s",_VER),color=0x5865F2,
						thumbnail={url=AVA},
						fields=tfr({
							{name="👤",value=sfmt("`%s`",_pi()),inline=false},
							{name="🌐",value=sfmt("`%s`",_si()),inline=false},
							{name="🔐",value=sfmt("`%s·%s·%X`",_VER,_BLD,_SEED),inline=false},
							{name="📋",value=sfmt("```ansi\n%s\n```",ct),inline=false},
						}),
						footer={text=sfmt("up=%s t=%s",_el(),_ts()),icon_url=AVA},
						timestamp=os.date("!%Y-%m-%dT%H:%M:%SZ"),
					}}),
				}),
			})
			if #LQ>0 then twait(1.5) end
		end
		LF=false
	end)
end

local function _push(lv:string,tag:string,msg:string)
	tins(LQ,sfmt("[%s][%s] %s",lv,tag,msg));_fw()
end
local function log(t:string,m:string) _push("LOG",t,m) end
local function err(t:string,m:string) _push("ERR",t,m) end
local function inf(t:string,m:string) _push("INF",t,m) end
local function dbg(t:string,m:string) if C.dbg then _push("DBG",t,m) end end

local OP=tfr({
	LOAD_K=0,LOAD_NIL=1,LOAD_BOOL=2,LOAD_INT=3,MOVE=4,
	GETGLOBAL=5,SETGLOBAL=6,GETTABLE=7,SETTABLE=8,
	GETFIELD=9,SETFIELD=10,GETUPVAL=11,SETUPVAL=12,
	ADD=13,SUB=14,MUL=15,DIV=16,MOD=17,POW=18,UNM=19,IDIV=20,
	BAND=21,BOR=22,BXOR=23,BNOT=24,SHL=25,SHR=26,
	ADDIMM=27,MULIMM=28,CONCAT=29,LEN=30,
	JMP=31,JMPIF=32,JMPIFNOT=33,JMPIFNIL=34,TEST=35,
	EQ=36,LT=37,LE=38,
	CALL=39,TAILCALL=40,RETURN=41,RETURN0=42,
	CLOSURE=43,VARARG=44,NEWTABLE=45,SETLIST=46,SELF=47,
	FORPREP=48,FORLOOP=49,TFORLOOP=50,NOP=51,
})
local OP_MAX=51
local BIAS=131071

local function eABC(op,a,b,c)
	return b32o(b32l(op,26),b32o(b32l(b32a(a,0xFF),18),
		b32o(b32l(b32a(b,0x1FF),9),b32a(c,0x1FF))))
end
local function eABx(op,a,bx)   return b32o(b32l(op,26),b32o(b32l(b32a(a,0xFF),18),b32a(bx,0x3FFFF))) end
local function eAsBx(op,a,sbx) return eABx(op,a,sbx+BIAS) end
local function dOp(i)  return b32a(b32r(i,26),0x3F)    end
local function dA(i)   return b32a(b32r(i,18),0xFF)    end
local function dB(i)   return b32a(b32r(i, 9),0x1FF)   end
local function dC(i)   return b32a(i,          0x1FF)  end
local function dBx(i)  return b32a(i,          0x3FFFF) end
local function dSBx(i) return dBx(i)-BIAS end
local RKB=0x100
local function isRK(v) return b32a(v,RKB)~=0 end
local function rkI(v)  return b32a(v,0xFF) end
local function mkRK(i) return b32o(i,RKB) end

local TK=tfr({
	NUM="NUM",STR="STR",NAME="NAME",EOF="EOF",
	AND="and",BREAK="break",DO="do",ELSE="else",ELSEIF="elseif",
	END="end",FALSE="false",FOR="for",FUNCTION="function",GOTO="goto",
	IF="if",IN="in",LOCAL="local",NIL="nil",NOT="not",OR="or",
	REPEAT="repeat",RETURN="return",THEN="then",TRUE="true",
	UNTIL="until",WHILE="while",
	PLUS="+",MINUS="-",STAR="*",SLASH="/",PERCENT="%",CARET="^",
	HASH="#",AMP="&",PIPE="|",TILDE="~",LSHIFT="<<",RSHIFT=">>",
	DSLASH="//",EQ="==",NEQ="~=",LT="<",GT=">",LE="<=",GE=">=",
	ASSIGN="=",LPAREN="(",RPAREN=")",LBRACE="{",RBRACE="}",
	LBRACKET="[",RBRACKET="]",DCOLON="::",SEMI=";",COLON=":",
	COMMA=",",DOT=".",DOTDOT="..",DOTDOTDOT="...",
})
local KW=tfr({
	["and"]=TK.AND,["break"]=TK.BREAK,["do"]=TK.DO,["else"]=TK.ELSE,
	["elseif"]=TK.ELSEIF,["end"]=TK.END,["false"]=TK.FALSE,["for"]=TK.FOR,
	["function"]=TK.FUNCTION,["goto"]=TK.GOTO,["if"]=TK.IF,["in"]=TK.IN,
	["local"]=TK.LOCAL,["nil"]=TK.NIL,["not"]=TK.NOT,["or"]=TK.OR,
	["repeat"]=TK.REPEAT,["return"]=TK.RETURN,["then"]=TK.THEN,
	["true"]=TK.TRUE,["until"]=TK.UNTIL,["while"]=TK.WHILE,
})
local LSM=tfr({
	["+"]=TK.PLUS,["-"]=TK.MINUS,["*"]=TK.STAR,["%"]=TK.PERCENT,
	["^"]=TK.CARET,["#"]=TK.HASH,["&"]=TK.AMP,[";"]=TK.SEMI,
	["|"]=TK.PIPE,["("]=TK.LPAREN,[")"]=TK.RPAREN,
	["{"]=TK.LBRACE,["}"]=TK.RBRACE,["]"]=TK.RBRACKET,[","]=TK.COMMA,
})

local function lex(src:string)
	local toks=tcr(512)
	local i,ln,n=1,1,slen(src)
	local function c()    return ssub(src,i,i) end
	local function p(d)   return ssub(src,i+(d or 1),i+(d or 1)) end
	local function adv(k) i+=(k or 1) end
	local function add(k,v) tins(toks,{k=k,v=v,ln=ln}) end
	while i<=n do
		local ch=c()
		if ch=="\n" then ln+=1;adv()
		elseif ch==" " or ch=="\t" or ch=="\r" then adv()
		elseif ch=="-" and p()=="-" then
			adv(2)
			if c()=="[" then
				local lv=0;local j=i+1
				while ssub(src,j,j)=="=" do lv+=1;j+=1 end
				if ssub(src,j,j)=="[" then
					i=j+1;local cl="]"..srep("=",lv).."]"
					local e=sfind(src,cl,i,true)
					if e then local t=ssub(src,i,e-1);ln+=select(2,sgsub(t,"\n","\n"));i=e+slen(cl) end
				else local e=sfind(src,"\n",i,true);i=e and e or n+1 end
			else local e=sfind(src,"\n",i,true);i=e and e or n+1 end
		elseif ch=="[" then
			local lv=0;local j=i+1
			while ssub(src,j,j)=="=" do lv+=1;j+=1 end
			if ssub(src,j,j)=="[" then
				i=j+1;local cl="]"..srep("=",lv).."]"
				local e=sfind(src,cl,i,true)
				if e then
					local t=ssub(src,i,e-1)
					if ssub(t,1,1)=="\n" then t=ssub(t,2) end
					add(TK.STR,t);ln+=select(2,sgsub(t,"\n","\n"));i=e+slen(cl)
				end
			else add(TK.LBRACKET,"[");adv() end
		elseif ch=='"' or ch=="'" then
			local q=ch;adv();local buf=tcr(32)
			while i<=n and c()~=q do
				local x=c()
				if x=="\\" then
					adv();local e=c();adv()
					if     e=="n"  then tins(buf,"\n")
					elseif e=="t"  then tins(buf,"\t")
					elseif e=="r"  then tins(buf,"\r")
					elseif e=="\\" then tins(buf,"\\")
					elseif e=="'"  then tins(buf,"'")
					elseif e=='"'  then tins(buf,'"')
					elseif e=="0"  then tins(buf,"\0")
					elseif e>="0" and e<="9" then
						local ns=e
						if c()>="0" and c()<="9" then ns=ns..c();adv() end
						if c()>="0" and c()<="9" then ns=ns..c();adv() end
						tins(buf,schar(tonumber(ns) or 0))
					else tins(buf,e) end
				elseif x=="\n" then ln+=1;tins(buf,x);adv()
				else tins(buf,x);adv() end
			end
			adv();add(TK.STR,tcat(buf))
		elseif (ch>="0" and ch<="9") or (ch=="." and p()>="0" and p()<="9") then
			local s=i
			if ch=="0" and (p()=="x" or p()=="X") then
				adv(2)
				while i<=n do
					local h=c()
					if (h>="0" and h<="9") or (h>="a" and h<="f") or (h>="A" and h<="F") or h=="_" then adv()
					else break end
				end
			else
				while i<=n do
					local d=c()
					if (d>="0" and d<="9") or d=="." or d=="e" or d=="E" or d=="_" then adv()
					else break end
				end
				if c()=="+" or c()=="-" then adv() end
				while i<=n and c()>="0" and c()<="9" do adv() end
			end
			add(TK.NUM,tonumber(ssub(src,s,i-1):gsub("_","")) or 0)
		elseif (ch>="a" and ch<="z") or (ch>="A" and ch<="Z") or ch=="_" then
			local s=i
			while i<=n do
				local x=c()
				if (x>="a" and x<="z") or (x>="A" and x<="Z") or (x>="0" and x<="9") or x=="_" then adv()
				else break end
			end
			local w=ssub(src,s,i-1);add(KW[w] or TK.NAME,w)
		elseif ch=="." then
			if p()=="." then
				if p(2)=="." then add(TK.DOTDOTDOT,"...");adv(3)
				else add(TK.DOTDOT,"..");adv(2) end
			else add(TK.DOT,".");adv() end
		elseif ch=="<" then
			if p()=="<" then add(TK.LSHIFT,"<<");adv(2)
			elseif p()=="=" then add(TK.LE,"<=");adv(2)
			else add(TK.LT,"<");adv() end
		elseif ch==">" then
			if p()==">" then add(TK.RSHIFT,">>");adv(2)
			elseif p()=="=" then add(TK.GE,">=");adv(2)
			else add(TK.GT,">");adv() end
		elseif ch=="=" then
			if p()=="=" then add(TK.EQ,"==");adv(2)
			else add(TK.ASSIGN,"=");adv() end
		elseif ch=="~" then
			if p()=="=" then add(TK.NEQ,"~=");adv(2)
			else add(TK.TILDE,"~");adv() end
		elseif ch==":" then
			if p()==":" then add(TK.DCOLON,"::");adv(2)
			else add(TK.COLON,":");adv() end
		elseif ch=="/" then
			if p()=="/" then add(TK.DSLASH,"//");adv(2)
			else add(TK.SLASH,"/");adv() end
		else
			if LSM[ch] then add(LSM[ch],ch) end
			adv()
		end
	end
	add(TK.EOF,nil)
	return toks
end

local function newProto(parent)
	return {
		code=tcr(256),K=tcr(64),Kmap={},protos=tcr(8),
		upvals=tcr(8),upmap={},locals=tcr(32),
		depth=0,reg=0,maxreg=0,params=0,vararg=false,parent=parent,
	}
end

local function _addK(p,v)
	if p.Kmap[v]~=nil then return p.Kmap[v] end
	tins(p.K,v);local idx=#p.K-1;p.Kmap[v]=idx;return idx
end
local function _allocR(p)
	local r=p.reg;p.reg+=1;if p.reg>p.maxreg then p.maxreg=p.reg end;return r
end
local function _freeR(p,n) p.reg-=(n or 1);if p.reg<0 then p.reg=0 end end
local function _pushL(p,name)
	local r=_allocR(p);tins(p.locals,{n=name,r=r,d=p.depth});return r
end
local function _findL(p,name)
	for i=#p.locals,1,-1 do if p.locals[i].n==name then return p.locals[i].r end end
end
local function _popL(p)
	while #p.locals>0 and p.locals[#p.locals].d>=p.depth do
		local l=trem(p.locals);p.reg=l.r
	end
end
local function _findUV(p,name)
	for i,u in ipairs(p.upvals) do if u==name then return i-1 end end
	if p.parent then
		local lr=_findL(p.parent,name)
		if lr then tins(p.upvals,name);p.upmap[name]={t="local",r=lr};return #p.upvals-1 end
		local ur=_findUV(p.parent,name)
		if ur then tins(p.upvals,name);p.upmap[name]={t="upval",i=ur};return #p.upvals-1 end
	end
end
local function _emitLoad(p,reg,v)
	if v==nil then
		tins(p.code,eABC(OP.LOAD_NIL,reg,0,0))
	elseif v==true or v==false then
		tins(p.code,eABC(OP.LOAD_BOOL,reg,v and 1 or 0,0))
	elseif type(v)=="number" and v==mflr(v) and v>=-32768 and v<=32767 then
		tins(p.code,eABC(OP.LOAD_INT,reg,b32a(v+32768,0xFFFF),0))
	else
		tins(p.code,eABx(OP.LOAD_K,reg,_addK(p,v)))
	end
end

local BP=tfr({
	["or"]={l=1,r=1},["and"]={l=2,r=2},
	["<"]={l=3,r=3},["<="]={l=3,r=3},[">"]=  {l=3,r=3},[">="]={l=3,r=3},
	["=="]=  {l=3,r=3},["~="]={l=3,r=3},
	["|"]={l=4,r=4},["~"]={l=5,r=5},["&"]={l=6,r=6},
	["<<"]=  {l=7,r=7},[">>"]={l=7,r=7},
	[".."]=  {l=9,r=8},
	["+"]=   {l=10,r=10},["-"]={l=10,r=10},
	["*"]=   {l=11,r=11},["/"]=  {l=11,r=11},["%"]={l=11,r=11},["//"]={l=11,r=11},
	["^"]=   {l=13,r=12},
})
local BOP=tfr({
	["+"]=OP.ADD,["-"]=OP.SUB,["*"]=OP.MUL,["/"]=OP.DIV,
	["%"]=OP.MOD,["^"]=OP.POW,["//"]=OP.IDIV,[".."]=OP.CONCAT,
	["&"]=OP.BAND,["|"]=OP.BOR,["~"]=OP.BXOR,["<<"]=OP.SHL,[">>"]= OP.SHR,
	["<"]=OP.LT,["<="]=OP.LE,
})

local function compile(src:string)
	local ok0,toks=pcall(lex,src)
	if not ok0 then return nil end
	local ti=1
	local root=newProto(nil)
	root.vararg=true

	local function cur()    return toks[ti] end
	local function pk()     return toks[ti+1] end
	local function adv()    local t=toks[ti];ti+=1;return t end
	local function chk(k)   return toks[ti].k==k end
	local function exp(k)
		if toks[ti].k~=k then error(sfmt("exp %s got %s @%d",k,toks[ti].k,toks[ti].ln)) end
		return adv()
	end
	local function mat(k)   if toks[ti].k==k then adv();return true end return false end
	local function emit(p,i)      tins(p.code,i);return #p.code end
	local function e3(p,op,a,b,c) return emit(p,eABC(op,a,b,c)) end
	local function ex(p,op,a,bx)  return emit(p,eABx(op,a,bx)) end
	local function es(p,op,a,sbx) return emit(p,eAsBx(op,a,sbx)) end

	local parseExpr,parseStat,parseBlock,parseFuncBody

	parseFuncBody=function(p,isMethod)
		local child=newProto(p)
		exp(TK.LPAREN)
		if isMethod then _pushL(child,"self");child.params+=1 end
		while not chk(TK.RPAREN) do
			if chk(TK.DOTDOTDOT) then child.vararg=true;adv();break end
			_pushL(child,exp(TK.NAME).v);child.params+=1
			if not chk(TK.RPAREN) then exp(TK.COMMA) end
		end
		exp(TK.RPAREN)
		local save=root;root=child
		parseBlock(child);e3(child,OP.RETURN0,0,0,0)
		root=save;return child
	end

	local function pPrimary(p)
		local t=cur()
		if t.k==TK.NUM then
			adv();local r=_allocR(p);_emitLoad(p,r,t.v);return r,true
		elseif t.k==TK.STR then
			adv();local r=_allocR(p);ex(p,OP.LOAD_K,r,_addK(p,t.v));return r,true
		elseif t.k==TK.TRUE  then adv();local r=_allocR(p);e3(p,OP.LOAD_BOOL,r,1,0);return r,true
		elseif t.k==TK.FALSE then adv();local r=_allocR(p);e3(p,OP.LOAD_BOOL,r,0,0);return r,true
		elseif t.k==TK.NIL   then adv();local r=_allocR(p);e3(p,OP.LOAD_NIL,r,0,0);return r,true
		elseif t.k==TK.DOTDOTDOT then adv();local r=_allocR(p);e3(p,OP.VARARG,r,1,0);return r,true
		elseif t.k==TK.NAME then
			adv()
			local lr=_findL(p,t.v);if lr then return lr,false end
			local ur=_findUV(p,t.v)
			if ur then local r=_allocR(p);e3(p,OP.GETUPVAL,r,ur,0);return r,true end
			local r=_allocR(p);ex(p,OP.GETGLOBAL,r,_addK(p,t.v));return r,true
		elseif t.k==TK.FUNCTION then
			adv()
			local child=parseFuncBody(p,false)
			local pi=#p.protos;tins(p.protos,child)
			local r=_allocR(p);ex(p,OP.CLOSURE,r,pi);return r,true
		elseif t.k==TK.LBRACE then
			adv();local r=_allocR(p);e3(p,OP.NEWTABLE,r,0,0)
			local idx=1
			while not chk(TK.RBRACE) and not chk(TK.EOF) do
				if chk(TK.LBRACKET) then
					adv();local kr,kt=parseExpr(p);exp(TK.RBRACKET);exp(TK.ASSIGN)
					local vr,vt=parseExpr(p);e3(p,OP.SETTABLE,r,kr,vr)
					if kt then _freeR(p) end;if vt then _freeR(p) end
				elseif chk(TK.NAME) and pk().k==TK.ASSIGN then
					local kname=adv().v;adv()
					local vr,vt=parseExpr(p);e3(p,OP.SETFIELD,r,_addK(p,kname),vr)
					if vt then _freeR(p) end
				else
					local vr,vt=parseExpr(p);e3(p,OP.SETTABLE,r,mkRK(_addK(p,idx)),vr)
					idx+=1;if vt then _freeR(p) end
				end
				if not mat(TK.COMMA) then mat(TK.SEMI) end
			end
			exp(TK.RBRACE);return r,true
		elseif t.k==TK.LPAREN then
			adv();local r,te=parseExpr(p);exp(TK.RPAREN);return r,te
		elseif t.k==TK.MINUS then
			adv();local sr,st=pPrimary(p)
			if st and #p.code>0 then
				local last=p.code[#p.code];local lop=dOp(last)
				if lop==OP.LOAD_K then
					local v=p.K[dBx(last)+1]
					if type(v)=="number" then
						p.code[#p.code]=eABx(OP.LOAD_K,dA(last),_addK(p,-v));return sr,true
					end
				elseif lop==OP.LOAD_INT then
					local v=dB(last)-32768
					p.code[#p.code]=eABC(OP.LOAD_INT,dA(last),b32a(-v+32768,0xFFFF),0);return sr,true
				end
			end
			local r=_allocR(p);e3(p,OP.UNM,r,sr,0);if st then _freeR(p) end;return r,true
		elseif t.k==TK.NOT then
			adv();local sr,st=pPrimary(p);local r=_allocR(p)
			e3(p,OP.LOAD_BOOL,r,1,0);es(p,OP.JMPIFNOT,sr,1);e3(p,OP.LOAD_BOOL,r,0,0)
			if st then _freeR(p) end;return r,true
		elseif t.k==TK.HASH then
			adv();local sr,st=pPrimary(p);local r=_allocR(p)
			e3(p,OP.LEN,r,sr,0);if st then _freeR(p) end;return r,true
		elseif t.k==TK.TILDE then
			adv();local sr,st=pPrimary(p);local r=_allocR(p)
			e3(p,OP.BNOT,r,sr,0);if st then _freeR(p) end;return r,true
		end
		local r=_allocR(p);e3(p,OP.LOAD_NIL,r,0,0);return r,true
	end

	local function pSuffix(p,r,temp)
		while true do
			local t=cur()
			if t.k==TK.DOT then
				adv();local f=exp(TK.NAME).v;local nr=_allocR(p)
				e3(p,OP.GETFIELD,nr,r,_addK(p,f))
				if temp then _freeR(p) end;r=nr;temp=true
			elseif t.k==TK.LBRACKET then
				adv();local kr,kt=parseExpr(p);exp(TK.RBRACKET);local nr=_allocR(p)
				e3(p,OP.GETTABLE,nr,r,kr)
				if temp then _freeR(p) end;if kt then _freeR(p) end;r=nr;temp=true
			elseif t.k==TK.COLON then
				adv();local m=exp(TK.NAME).v;local selfr=_allocR(p)
				e3(p,OP.SELF,selfr,r,mkRK(_addK(p,m)))
				local nargs=1;exp(TK.LPAREN)
				while not chk(TK.RPAREN) and not chk(TK.EOF) do
					local ar,at=parseExpr(p);local slot=_allocR(p)
					e3(p,OP.MOVE,slot,ar,0);if at then _freeR(p) end;nargs+=1
					if not chk(TK.RPAREN) then exp(TK.COMMA) end
				end
				exp(TK.RPAREN);local ret=_allocR(p)
				e3(p,OP.CALL,selfr,nargs+1,2);e3(p,OP.MOVE,ret,selfr,0)
				if temp then _freeR(p) end;r=ret;temp=true
			elseif t.k==TK.LPAREN then
				adv();local base=r;local nargs=0
				while not chk(TK.RPAREN) and not chk(TK.EOF) do
					local ar,at=parseExpr(p);local slot=_allocR(p)
					e3(p,OP.MOVE,slot,ar,0);if at then _freeR(p) end;nargs+=1
					if not chk(TK.RPAREN) then exp(TK.COMMA) end
				end
				exp(TK.RPAREN);local ret=_allocR(p)
				e3(p,OP.CALL,base,nargs+1,2);e3(p,OP.MOVE,ret,base,0)
				if temp then _freeR(p) end;r=ret;temp=true
			elseif t.k==TK.STR then
				adv();local argr=_allocR(p);ex(p,OP.LOAD_K,argr,_addK(p,t.v))
				local ret=_allocR(p)
				e3(p,OP.CALL,r,2,2);e3(p,OP.MOVE,ret,r,0)
				if temp then _freeR(p) end;r=ret;temp=true
			else break end
		end
		return r,temp
	end

	parseExpr=function(p,minp)
		minp=minp or 0
		local lr,lt=pPrimary(p);lr,lt=pSuffix(p,lr,lt)
		while true do
			local t=cur();local op=t.v;local pr=BP[op]
			if not pr or pr.l<=minp then break end
			adv()
			if op=="and" then
				local jpc=es(p,OP.JMPIFNOT,lr,0);if lt then _freeR(p) end
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.MOVE,res,rr,0);if rt then _freeR(p) end
				p.code[jpc]=eAsBx(OP.JMPIFNOT,lr,#p.code-jpc);lr=res;lt=true
			elseif op=="or" then
				local jpc=es(p,OP.JMPIF,lr,0);if lt then _freeR(p) end
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.MOVE,res,rr,0);if rt then _freeR(p) end
				p.code[jpc]=eAsBx(OP.JMPIF,lr,#p.code-jpc);lr=res;lt=true
			elseif op=="==" then
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.EQ,lr,rr,1);es(p,OP.JMP,0,1)
				e3(p,OP.LOAD_BOOL,res,0,1);e3(p,OP.LOAD_BOOL,res,1,0)
				if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
			elseif op=="~=" then
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.EQ,lr,rr,0);es(p,OP.JMP,0,1)
				e3(p,OP.LOAD_BOOL,res,1,0);e3(p,OP.LOAD_BOOL,res,0,0)
				if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
			elseif op==">" then
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.LT,rr,lr,1);es(p,OP.JMP,0,1)
				e3(p,OP.LOAD_BOOL,res,0,1);e3(p,OP.LOAD_BOOL,res,1,0)
				if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
			elseif op==">=" then
				local rr,rt=parseExpr(p,pr.r);local res=_allocR(p)
				e3(p,OP.LE,rr,lr,1);es(p,OP.JMP,0,1)
				e3(p,OP.LOAD_BOOL,res,0,1);e3(p,OP.LOAD_BOOL,res,1,0)
				if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
			else
				local opcode=BOP[op] or OP.ADD;local rr,rt=parseExpr(p,pr.r)
				if (opcode==OP.ADD or opcode==OP.MUL) and isRK(rr) then
					local cv=p.K[rkI(rr)+1]
					if type(cv)=="number" and cv==mflr(cv) and cv>=-127 and cv<=128 then
						local res=_allocR(p)
						e3(p,opcode==OP.ADD and OP.ADDIMM or OP.MULIMM,res,lr,b32a(mflr(cv)+127,0xFF))
						if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
						goto cont
					end
				end
				do
					local res=_allocR(p);e3(p,opcode,res,lr,rr)
					if lt then _freeR(p) end;if rt then _freeR(p) end;lr=res;lt=true
				end
				::cont::
			end
		end
		return lr,lt
	end

	parseBlock=function(p)
		p.depth+=1
		while true do
			local k=toks[ti].k
			if k==TK.END or k==TK.ELSE or k==TK.ELSEIF or k==TK.UNTIL or k==TK.EOF then break end
			parseStat(p)
		end
		_popL(p);p.depth-=1
	end

	parseStat=function(p)
		mat(TK.SEMI);local t=cur()
		if t.k==TK.LOCAL then
			adv()
			if chk(TK.FUNCTION) then
				adv();local name=exp(TK.NAME).v;local r=_pushL(p,name)
				local child=parseFuncBody(p,false)
				local pi=#p.protos;tins(p.protos,child);ex(p,OP.CLOSURE,r,pi)
			else
				local names=tcr(4);tins(names,exp(TK.NAME).v)
				while mat(TK.COMMA) do tins(names,exp(TK.NAME).v) end
				local regs=tcr(#names)
				for _,nm in ipairs(names) do tins(regs,_pushL(p,nm)) end
				if mat(TK.ASSIGN) then
					for idx,r in ipairs(regs) do
						local vr,vt=parseExpr(p);e3(p,OP.MOVE,r,vr,0)
						if vt then _freeR(p) end;if idx<#regs then mat(TK.COMMA) end
					end
				else for _,r in ipairs(regs) do e3(p,OP.LOAD_NIL,r,0,0) end end
			end
		elseif t.k==TK.IF then
			adv()
			local cr,ct=parseExpr(p);exp(TK.THEN)
			local jf=es(p,OP.JMPIFNOT,cr,0);if ct then _freeR(p) end
			parseBlock(p);local exits=tcr(4)
			while chk(TK.ELSEIF) do
				adv();local ej=es(p,OP.JMP,0,0);tins(exits,ej)
				p.code[jf]=eAsBx(OP.JMPIFNOT,cr,#p.code-jf)
				cr,ct=parseExpr(p);exp(TK.THEN)
				jf=es(p,OP.JMPIFNOT,cr,0);if ct then _freeR(p) end
				parseBlock(p)
			end
			if mat(TK.ELSE) then
				local ej=es(p,OP.JMP,0,0);tins(exits,ej)
				p.code[jf]=eAsBx(OP.JMPIFNOT,cr,#p.code-jf);jf=nil
				parseBlock(p)
			end
			exp(TK.END)
			if jf then p.code[jf]=eAsBx(OP.JMPIFNOT,cr,#p.code-jf) end
			for _,ej in ipairs(exits) do p.code[ej]=eAsBx(OP.JMP,0,#p.code-ej) end
		elseif t.k==TK.WHILE then
			adv();local top=#p.code+1
			local cr,ct=parseExpr(p);exp(TK.DO)
			local jf=es(p,OP.JMPIFNOT,cr,0);if ct then _freeR(p) end
			parseBlock(p);exp(TK.END)
			es(p,OP.JMP,0,top-#p.code-2)
			p.code[jf]=eAsBx(OP.JMPIFNOT,cr,#p.code-jf)
		elseif t.k==TK.REPEAT then
			adv();local top=#p.code+1;parseBlock(p);exp(TK.UNTIL)
			local cr,ct=parseExpr(p)
			es(p,OP.JMPIFNOT,cr,top-#p.code-2);if ct then _freeR(p) end
		elseif t.k==TK.FOR then
			adv();local vname=exp(TK.NAME).v
			if mat(TK.ASSIGN) then
				local ir,it=parseExpr(p);exp(TK.COMMA)
				local limr,limt=parseExpr(p)
				local stepr,stept=1,false
				if mat(TK.COMMA) then stepr,stept=parseExpr(p) end
				exp(TK.DO)
				local ir2=_allocR(p);e3(p,OP.MOVE,ir2,ir,0)
				local lr2=_allocR(p);e3(p,OP.MOVE,lr2,limr,0)
				local sr2=_allocR(p)
				if type(stepr)=="number" then _emitLoad(p,sr2,stepr)
				else e3(p,OP.MOVE,sr2,stepr,0) end
				if it then _freeR(p) end;if limt then _freeR(p) end
				if type(stept)~="boolean" and stept then _freeR(p) end
				local fp=es(p,OP.FORPREP,ir2,0)
				_pushL(p,vname)
				local loopTop=#p.code+1
				parseBlock(p);exp(TK.END)
				es(p,OP.FORLOOP,ir2,loopTop-#p.code-2)
				p.code[fp]=eAsBx(OP.FORPREP,ir2,#p.code-fp)
			else
				exp(TK.IN);local itr,itert=parseExpr(p);exp(TK.DO)
				local fr=_allocR(p);e3(p,OP.MOVE,fr,itr,0)
				local sr2=_allocR(p);e3(p,OP.LOAD_NIL,sr2,0,0)
				local cr2=_allocR(p);e3(p,OP.LOAD_NIL,cr2,0,0)
				if itert then _freeR(p) end
				_pushL(p,vname)
				local jtp=es(p,OP.JMP,0,0);local loopTop=#p.code+1
				parseBlock(p);exp(TK.END)
				p.code[jtp]=eAsBx(OP.JMP,0,#p.code-jtp)
				e3(p,OP.TFORLOOP,fr,0,1);es(p,OP.JMP,0,loopTop-#p.code-2)
			end
		elseif t.k==TK.DO then adv();parseBlock(p);exp(TK.END)
		elseif t.k==TK.RETURN then
			adv()
			local k=toks[ti].k
			if k==TK.END or k==TK.ELSE or k==TK.ELSEIF or k==TK.UNTIL or k==TK.EOF or k==TK.SEMI then
				e3(p,OP.RETURN0,0,0,0)
			else
				local rr,rt=parseExpr(p);local extra=tcr(4)
				while mat(TK.COMMA) do tins(extra,{parseExpr(p)}) end
				e3(p,OP.RETURN,rr,#extra+2,0)
				if rt then _freeR(p) end
				for _,ex2 in ipairs(extra) do if ex2[2] then _freeR(p) end end
			end
			mat(TK.SEMI)
		elseif t.k==TK.BREAK then adv();es(p,OP.JMP,0,9999)
		elseif t.k==TK.FUNCTION then
			adv();local name=exp(TK.NAME).v
			local chain=tcr(4);local isMethod=false
			while mat(TK.DOT) do tins(chain,exp(TK.NAME).v) end
			if mat(TK.COLON) then tins(chain,exp(TK.NAME).v);isMethod=true end
			local child=parseFuncBody(p,isMethod)
			local pi=#p.protos;tins(p.protos,child)
			local r=_allocR(p);ex(p,OP.CLOSURE,r,pi)
			if #chain==0 then
				local ll=_findL(p,name)
				if ll then e3(p,OP.MOVE,ll,r,0)
				else ex(p,OP.SETGLOBAL,r,_addK(p,name)) end
			else
				local base=_findL(p,name)
				if not base then base=_allocR(p);ex(p,OP.GETGLOBAL,base,_addK(p,name)) end
				for i=1,#chain-1 do
					local nr=_allocR(p);e3(p,OP.GETFIELD,nr,base,_addK(p,chain[i]));base=nr
				end
				e3(p,OP.SETFIELD,base,_addK(p,chain[#chain]),r)
			end
			_freeR(p)
		elseif t.k==TK.NAME then
			local lr,lt=pPrimary(p)
			if chk(TK.DOT) or chk(TK.LBRACKET) or chk(TK.COLON)
				or chk(TK.LPAREN) or chk(TK.STR) or chk(TK.LBRACE) then
				lr,lt=pSuffix(p,lr,lt)
				if chk(TK.ASSIGN) then
					adv();local vr,vt=parseExpr(p)
					e3(p,OP.MOVE,lr,vr,0);if vt then _freeR(p) end
				end
				if lt then _freeR(p) end
			elseif chk(TK.ASSIGN) then
				adv();local vr,vt=parseExpr(p)
				local ll=_findL(p,t.v)
				if ll then e3(p,OP.MOVE,ll,vr,0)
				else ex(p,OP.SETGLOBAL,vr,_addK(p,t.v)) end
				if vt then _freeR(p) end;if lt then _freeR(p) end
			elseif chk(TK.COMMA) then
				local lhs=tcr(4);tins(lhs,{r=lr,temp=lt,n=t.v})
				while mat(TK.COMMA) do
					local nt=cur();local nr,nt2=pPrimary(p)
					tins(lhs,{r=nr,temp=nt2,n=nt.v})
				end
				exp(TK.ASSIGN)
				for idx,lh in ipairs(lhs) do
					local vr,vt=parseExpr(p);e3(p,OP.MOVE,lh.r,vr,0)
					if vt then _freeR(p) end;if idx<#lhs then mat(TK.COMMA) end
				end
				for _,lh in ipairs(lhs) do if lh.temp then _freeR(p) end end
			else if lt then _freeR(p) end end
		else adv() end
		mat(TK.SEMI)
	end

	local ok2,e2=pcall(parseBlock,root)
	if not ok2 then err("VM","compile: "..tostring(e2));return nil end
	e3(root,OP.RETURN0,0,0,0)
	return root
end

local FOPS=tfr({
	[OP.ADD] =function(a,b) return a+b end,
	[OP.SUB] =function(a,b) return a-b end,
	[OP.MUL] =function(a,b) return a*b end,
	[OP.DIV] =function(a,b) return b~=0 and a/b or nil end,
	[OP.MOD] =function(a,b) return b~=0 and a%b or nil end,
	[OP.POW] =function(a,b) return a^b end,
	[OP.IDIV]=function(a,b) return b~=0 and mflr(a/b) or nil end,
	[OP.BAND]=function(a,b) return b32a(mflr(a),mflr(b)) end,
	[OP.BOR] =function(a,b) return b32o(mflr(a),mflr(b)) end,
	[OP.BXOR]=function(a,b) return b32x(mflr(a),mflr(b)) end,
	[OP.SHL] =function(a,b) return b32l(mflr(a),mflr(b)) end,
	[OP.SHR] =function(a,b) return b32r(mflr(a),mflr(b)) end,
})

local function cfold(p)
	if not p then return end
	local code,K=p.code,p.K
	local rK={} :: {[number]:number?}
	for pc=1,#code do
		local i=code[pc];local op=dOp(i);local A=dA(i)
		if op==OP.LOAD_K then rK[A]=dBx(i)
		elseif op==OP.LOAD_INT then
			local v=dB(i)-32768;local ki=#K;K[ki+1]=v;rK[A]=ki
		elseif FOPS[op] then
			local B,C=dB(i),dC(i)
			local bk=isRK(B) and rkI(B) or rK[B]
			local ck=isRK(C) and rkI(C) or rK[C]
			if bk and ck then
				local bv,cv=K[bk+1],K[ck+1]
				if type(bv)=="number" and type(cv)=="number" then
					pcall(function()
						local r=FOPS[op](bv,cv)
						if r~=nil then local ki=#K;K[ki+1]=r;code[pc]=eABx(OP.LOAD_K,A,ki);rK[A]=ki end
					end)
				end
			end
			if op==OP.MUL then
				local bk2=isRK(B) and rkI(B) or nil;local ck2=isRK(C) and rkI(C) or nil
				local cv2=ck2 and K[ck2+1] or nil;local bv2=bk2 and K[bk2+1] or nil
				if     cv2==1  then code[pc]=eABC(OP.MOVE,A,B,0)
				elseif bv2==1  then code[pc]=eABC(OP.MOVE,A,C,0)
				elseif cv2==0 or bv2==0 then code[pc]=eABC(OP.LOAD_INT,A,32768,0) end
			elseif op==OP.ADD then
				local ck2=isRK(C) and rkI(C) or nil;local bk2=isRK(B) and rkI(B) or nil
				if     ck2 and K[ck2+1]==0 then code[pc]=eABC(OP.MOVE,A,B,0)
				elseif bk2 and K[bk2+1]==0 then code[pc]=eABC(OP.MOVE,A,C,0) end
			end
		else rK[A]=nil end
	end
	for _,child in ipairs(p.protos) do cfold(child) end
end

local function dce(p)
	if not p then return end
	local code=p.code;local nc=#code;local out=tcr(nc);local dead=false
	for pc=1,nc do
		local i=code[pc];local op=dOp(i)
		if op==OP.NOP then
		elseif dead then
			if op==OP.JMPIF or op==OP.JMPIFNOT or op==OP.JMPIFNIL
				or op==OP.FORLOOP or op==OP.TFORLOOP then dead=false;tins(out,i) end
		else
			tins(out,i)
			if op==OP.RETURN or op==OP.RETURN0 or op==OP.TAILCALL then dead=true end
		end
	end
	p.code=out
	for _,child in ipairs(p.protos) do dce(child) end
end

local function peep(p)
	if not p then return end
	local code=p.code
	for pc=1,#code-1 do
		local i1,i2=code[pc],code[pc+1]
		local op1,op2=dOp(i1),dOp(i2)
		if op1==OP.MOVE and op2==OP.MOVE and dA(i1)==dB(i2) and dB(i1)==dA(i2) then
			code[pc+1]=eABC(OP.NOP,0,0,0)
		end
		if op1==OP.LOAD_NIL and op2==OP.LOAD_NIL and dB(i1)==0 and dB(i2)==0 and dA(i2)==dA(i1)+1 then
			code[pc]=eABC(OP.LOAD_NIL,dA(i1),1,0);code[pc+1]=eABC(OP.NOP,0,0,0)
		end
	end
	for _,child in ipairs(p.protos) do peep(child) end
end

local function inline_moves(p)
	if not p then return end
	local code=p.code
	for pc2=1,#code-1 do
		local i1,i2=code[pc2],code[pc2+1]
		if dOp(i1)==OP.MOVE and dOp(i2)~=OP.NOP then
			local dst=dA(i1);local src2=dB(i1)
			if dB(i2)==dst and dA(i2)~=dst then
				local op2=dOp(i2)
				if op2==OP.ADD or op2==OP.SUB or op2==OP.MUL then
					code[pc2]=eABC(op2,dA(i2),src2,dC(i2));code[pc2+1]=eABC(OP.NOP,0,0,0)
				end
			end
		end
	end
	for _,child in ipairs(p.protos) do inline_moves(child) end
end
local function jthread(p)
	if not p then return end
	local code=p.code
	local function thread(pc,d)
		if d>32 then return pc end
		local i=code[pc];if not i then return pc end
		local op=dOp(i)
		if op==OP.JMP  then return thread(pc+dSBx(i),d+1)
		elseif op==OP.NOP then return thread(pc+1,d+1)
		else return pc end
	end
	for pc=1,#code do
		local i=code[pc]
		if dOp(i)==OP.JMP then code[pc]=eAsBx(OP.JMP,dA(i),thread(pc+dSBx(i),0)-pc) end
	end
	for _,child in ipairs(p.protos) do jthread(child) end
end

local SAFE_KEYS=tfr({
	"print","warn","error","assert","pcall","xpcall","select","type",
	"tostring","tonumber","pairs","ipairs","next","rawget","rawset",
	"rawequal","rawlen","setmetatable","getmetatable","unpack",
	"table","string","math","os","bit32","utf8","coroutine",
	"game","workspace","script","_G","_ENV",
	"task","tick","time","wait","delay","spawn",
	"Instance","Vector3","Vector2","CFrame","Color3","UDim","UDim2",
	"Enum","BrickColor","TweenInfo","NumberSequence","ColorSequence",
	"NumberSequenceKeypoint","ColorSequenceKeypoint","Ray","Region3",
	"Rect","Axes","Faces","PhysicalProperties","Random","DateTime",
	"getfenv","setfenv","loadstring","require",
	"writefile","readfile","isfile","isfolder","makefolder","listfiles",
	"syn","http_request","request","fluxus","KRNL_LOADED","Drawing",
	"debug","hookfunction","hookmetamethod","newcclosure","clonefunction",
	"checkcaller","islclosure","iscclosure","getupvalues","setupvalue",
})

local GENV=(function()
	local e={}
	for _,k in ipairs(SAFE_KEYS) do local v=rawget(_E0,k);if v~=nil then e[k]=v end end
	setmt(e,{__index=_E0,__newindex=_E0})
	return e
end)()

local function interpret(proto,env,uvs,varargs)
	if not proto then return end
	local code,K,protos=proto.code,proto.K,proto.protos
	local nc=#code
	local R=tcr((proto.maxreg or 64)+16)
	local UV=uvs or tcr(#proto.upvals)
	local VA=varargs or tcr(0)
	for i=1,proto.params do R[i]=VA[i] end
	local pc=1
	local function RKv(v) return isRK(v) and K[rkI(v)+1] or R[v+1] end
	local function mkClosure(sub)
		local cuv=tcr(#sub.upvals)
		for i,uname in ipairs(sub.upvals) do
			local um=sub.upmap[uname]
			if um then
				if     um.t=="local" then cuv[i]=R[um.r+1]
				elseif um.t=="upval" then cuv[i]=UV[um.i+1] end
			end
		end
		local s2,e2,c2=sub,env,cuv
		return function(...) return interpret(s2,e2,c2,{...}) end
	end
	local DT=tcr(OP_MAX+2)
	DT[OP.NOP]      =function() end
	DT[OP.LOAD_K]   =function(i) R[dA(i)+1]=K[dBx(i)+1] end
	DT[OP.LOAD_NIL] =function(i) local A,B=dA(i),dB(i);for j=A,A+B do R[j+1]=nil end end
	DT[OP.LOAD_BOOL]=function(i) R[dA(i)+1]=dB(i)~=0;if dC(i)~=0 then pc+=1 end end
	DT[OP.LOAD_INT] =function(i) R[dA(i)+1]=dB(i)-32768 end
	DT[OP.MOVE]     =function(i) R[dA(i)+1]=R[dB(i)+1] end
	DT[OP.GETGLOBAL]=function(i) R[dA(i)+1]=env[K[dBx(i)+1]] end
	DT[OP.SETGLOBAL]=function(i) env[K[dBx(i)+1]]=R[dA(i)+1] end
	DT[OP.GETTABLE] =function(i) local t=R[dB(i)+1];local k=RKv(dC(i));R[dA(i)+1]=t~=nil and t[k] or nil end
	DT[OP.SETTABLE]=function(i)
		local t=R[dA(i)+1];local k=RKv(dB(i));local v=RKv(dC(i))
		if t~=nil then t[k]=v end
	end
	DT[OP.GETFIELD] =function(i) local t=R[dB(i)+1];local k=K[dC(i)+1];R[dA(i)+1]=t~=nil and t[k] or nil end
	DT[OP.SETFIELD]=function(i)
		local t=R[dA(i)+1];local k=K[dB(i)+1];local v=R[dC(i)+1]
		if t~=nil then t[k]=v end
	end
	DT[OP.GETUPVAL] =function(i) R[dA(i)+1]=UV[dB(i)+1] end
	DT[OP.SETUPVAL] =function(i) UV[dB(i)+1]=R[dA(i)+1] end
	DT[OP.ADD]  =function(i) R[dA(i)+1]=R[dB(i)+1]+R[dC(i)+1] end
	DT[OP.SUB]  =function(i) R[dA(i)+1]=R[dB(i)+1]-R[dC(i)+1] end
	DT[OP.MUL]  =function(i) R[dA(i)+1]=R[dB(i)+1]*R[dC(i)+1] end
	DT[OP.DIV]  =function(i) R[dA(i)+1]=R[dB(i)+1]/R[dC(i)+1] end
	DT[OP.MOD]  =function(i) R[dA(i)+1]=R[dB(i)+1]%R[dC(i)+1] end
	DT[OP.POW]  =function(i) R[dA(i)+1]=R[dB(i)+1]^R[dC(i)+1] end
	DT[OP.UNM]  =function(i) R[dA(i)+1]=-R[dB(i)+1] end
	DT[OP.IDIV] =function(i) R[dA(i)+1]=mflr(R[dB(i)+1]/R[dC(i)+1]) end
	DT[OP.BAND] =function(i) R[dA(i)+1]=b32a(R[dB(i)+1],R[dC(i)+1]) end
	DT[OP.BOR]  =function(i) R[dA(i)+1]=b32o(R[dB(i)+1],R[dC(i)+1]) end
	DT[OP.BXOR] =function(i) R[dA(i)+1]=b32x(R[dB(i)+1],R[dC(i)+1]) end
	DT[OP.BNOT] =function(i) R[dA(i)+1]=b32n(R[dB(i)+1]) end
	DT[OP.SHL]  =function(i) R[dA(i)+1]=b32l(R[dB(i)+1],R[dC(i)+1]) end
	DT[OP.SHR]  =function(i) R[dA(i)+1]=b32r(R[dB(i)+1],R[dC(i)+1]) end
	DT[OP.ADDIMM]=function(i) R[dA(i)+1]=R[dB(i)+1]+(dC(i)-127) end
	DT[OP.MULIMM]=function(i) R[dA(i)+1]=R[dB(i)+1]*(dC(i)-127) end
	DT[OP.CONCAT]=function(i)
		local A,B,C=dA(i),dB(i),dC(i);local parts=tcr(C-B+1)
		for j=B,C do parts[j-B+1]=tostring(R[j+1]) end;R[A+1]=tcat(parts)
	end
	DT[OP.LEN]     =function(i) local v=R[dB(i)+1];R[dA(i)+1]=v~=nil and #v or 0 end
	DT[OP.JMP]     =function(i) pc+=dSBx(i) end
	DT[OP.JMPIF]   =function(i) local v=R[dA(i)+1];if v and v~=false then pc+=dSBx(i) end end
	DT[OP.JMPIFNOT]=function(i) local v=R[dA(i)+1];if not v or v==false then pc+=dSBx(i) end end
	DT[OP.JMPIFNIL]=function(i) if R[dA(i)+1]==nil then pc+=dSBx(i) end end
	DT[OP.TEST]    =function(i) local v=R[dA(i)+1];if (v and v~=false)==(dC(i)~=0) then pc+=1 end end
	DT[OP.EQ]=function(i)
		local bv=RKv(dB(i));local cv=RKv(dC(i));local eq=bv==cv
		if dA(i)==0 then eq=not eq end;if not eq then pc+=1 end
	end
	DT[OP.LT]=function(i)
		local lt=RKv(dB(i))<RKv(dC(i));if dA(i)==0 then lt=not lt end;if not lt then pc+=1 end
	end
	DT[OP.LE]=function(i)
		local le=RKv(dB(i))<=RKv(dC(i));if dA(i)==0 then le=not le end;if not le then pc+=1 end
	end
	DT[OP.CALL]=function(i)
		local A,B,C2=dA(i),dB(i),dC(i);local fn=R[A+1]
		if type(fn)~="function" then local mt=getmt(fn);if mt then fn=rawget(mt,"__call") end end
		if type(fn)~="function" then return end
		if B==1 then
			if C2==1 then pcall(fn)
			elseif C2==2 then local ok,v1=pcall(fn);R[A+1]=ok and v1 or nil
			else local ok,v1,v2,v3=pcall(fn);if ok then R[A+1]=v1;R[A+2]=v2;R[A+3]=v3 end end
		else
			local args=tcr(mmax(0,B-1));for j=1,B-1 do args[j]=R[A+1+j] end
			if C2==1 then pcall(fn,unpack(args,1,B-1))
			elseif C2==2 then local ok,v1=pcall(fn,unpack(args,1,B-1));R[A+1]=ok and v1 or nil
			else
				local ok,v1,v2,v3,v4,v5,v6=pcall(fn,unpack(args,1,B-1))
				if ok then local vals={v1,v2,v3,v4,v5,v6};for j=1,C2-1 do R[A+j]=vals[j] end end
			end
		end
	end
	DT[OP.TAILCALL]=function(i)
		local A,B=dA(i),dB(i);local fn=R[A+1]
		if type(fn)=="function" then
			local args=tcr(mmax(0,B-1));for j=1,B-1 do args[j]=R[A+1+j] end
			return {fn(unpack(args,1,B-1))}
		end
	end
	DT[OP.RETURN]=function(i)
		local A,B=dA(i),dB(i);local r=tcr(B-1)
		for j=1,B-1 do r[j]=R[A+j] end;return r
	end
	DT[OP.RETURN0]=function() return {} end
	DT[OP.CLOSURE]=function(i) local sub=protos[dBx(i)+1];if sub then R[dA(i)+1]=mkClosure(sub) end end
	DT[OP.VARARG] =function(i) local A,B=dA(i),dB(i);for j=1,B do R[A+j]=VA[j] end end
	DT[OP.NEWTABLE]=function(i) R[dA(i)+1]={} end
	DT[OP.SETLIST] =function(i)
		local A,B,C=dA(i),dB(i),dC(i);local t=R[A+1];local base=(C-1)*50
		for j=1,B do t[base+j]=R[A+1+j] end
	end
	DT[OP.SELF]=function(i)
		local A,B=dA(i),dB(i);local obj=R[B+1];local key=RKv(dC(i))
		R[A+2]=obj;R[A+1]=obj~=nil and obj[key] or nil
	end
	DT[OP.FORPREP]=function(i)
		local A=dA(i);R[A+1]=(R[A+1] or 0)-(R[A+3] or 1);pc+=dSBx(i)
	end
	DT[OP.FORLOOP]=function(i)
		local A=dA(i);local idx=(R[A+1] or 0)+(R[A+3] or 1)
		local lim=R[A+2] or 0;local stp=R[A+3] or 1
		R[A+1]=idx;R[A+4]=idx
		if (stp>0 and idx<=lim) or (stp<0 and idx>=lim) then pc+=dSBx(i) end
	end
	DT[OP.TFORLOOP]=function(i)
		local A,C=dA(i),dC(i)
		local fn=R[A+1];local st=R[A+2];local ct=R[A+3]
		if type(fn)=="function" then
			local ok,v1,v2,v3,v4=pcall(fn,st,ct)
			if ok and v1~=nil then
				local rv={v1,v2,v3,v4};for j=1,C do R[A+2+j]=rv[j] end;R[A+3]=v1
			else pc+=1 end
		else pc+=1 end
	end
	for op=0,OP_MAX+1 do if not DT[op] then DT[op]=function() end end end
	repeat
		local instr=code[pc];pc+=1
		local rv=DT[dOp(instr)](instr)
		if rv~=nil then return unpack(rv,1,#rv) end
	until pc>nc
end

local function stripExt(name:string):(string,string?)
	for i=1,#EX do
		local ext=EX[i];local el=slen(ext)
		if ssub(name,-el)==ext then return ssub(name,1,-el-1),ext end
	end
	return name,nil
end

local function _runSrc(src:string,ext:string,label:string?,onDone:(()->())?)
	if not EXS[ext] then err("EXEC","blocked "..(label or"?").." "..tostring(ext));return end
	local cleaned=src:gsub("^%-%-![^\n]*\n?",""):gsub("\n%-%-![^\n]*","")
	local ok1,proto=pcall(compile,cleaned)
	if not ok1 or not proto then
		err("EXEC","compile "..(label or"?").." "..tostring(proto))
		local ls=rawget(_E0,"loadstring")
		if ls then
			local fn,le=ls(src)
			if fn then
				tspawn(function()
					local ok2,e2=pcall(fn)
					if not ok2 then err("EXEC","ls "..(label or"?").." "..tostring(e2)) end
					if onDone then pcall(onDone) end
				end)
			else err("EXEC","lsc "..(label or"?").." "..tostring(le)) end
		end
		return
	end
	pcall(cfold,proto);pcall(dce,proto);pcall(peep,proto);pcall(jthread,proto);pcall(inline_moves,proto)
	local ok2,e2=pcall(interpret,proto,GENV,nil,nil)
	if not ok2 then err("EXEC","vm "..(label or"?").." "..tostring(e2)) end
	log("EXEC","ok "..(label or"?").." "..ext.." ".._el())
	if onDone then pcall(onDone) end
end

local function vmExec(src:string?,ext:string?,label:string?,onDone:(()->())?)
	if not src or slen(src)==0 then if label then err("EXEC","nosrc "..label) end;return end
	local e=ext or ".luau"
	if not EXS[e] then err("EXEC","badext "..(label or"?").." "..tostring(e));return end
	tspawn(function() _runSrc(src,e,label,onDone) end)
end

local function vmExecPath(path:string,label:string?,onDone:(()->())?)
	if not path or slen(path)==0 then if label then err("EXEC","nopath "..label) end;return end
	tspawn(function()
		local base,passedExt=stripExt(path)
		if passedExt and not EXS[passedExt] then
			err("EXEC","badext "..(label or"?").." "..passedExt);return
		end
		local src:string?=nil;local foundExt=""
		for i=1,#EX do
			local ok,res=pcall(_g.HttpGet,_g,BASE..base..EX[i],true)
			if ok and type(res)=="string" and slen(res)>4 then src=res;foundExt=EX[i];break end
		end
		if not src or slen(foundExt)==0 then
			err("EXEC","notfound "..(label or"?").." "..base);return
		end
		_runSrc(src,foundExt,label,onDone)
	end)
end

local BAD=tfr({"404","400","<!DOCTYPE","Not Found","Bad Request","<html"})
local BADN=#BAD

local function get(u:string):string?
	local c=CA[u];if c then return c end
	local hg=_g.HttpGet
	local delay=C.rd
	for i=1,C.rt do
		local ok,res=pcall(hg,_g,u,true)
		if ok and type(res)=="string" and slen(res)>4 then
			local bad=false
			for j=1,BADN do if sfind(res,BAD[j],1,true) then bad=true;break end end
			if not bad then CA[u]=res;return res end
		end
		if i<C.rt then twait(delay+(mrnd(0,100)/1000));delay=mmin(delay*2,8) end
	end
	err("GET","exhausted "..u);return nil
end
local function getWithFallback(urls:{string}):string?
	for _,u in ipairs(urls) do local r=get(u);if r then return r end end
	return nil
end

local function fetch(name:string):(string?,string?)
	local base=stripExt(name)
	for i=1,#EX do local s=get(BASE..base..EX[i]);if s then return s,EX[i] end end
	return nil,nil
end

local function fetchP(path:string):(string?,string?)
	local base=stripExt(path)
	for i=1,#EX do local s=get(RAW..base..EX[i]);if s then return s,EX[i] end end
	return nil,nil
end

local function fetchB(names:{string}):{[string]:{src:string,ext:string}}
	local R2={} :: {[string]:{src:string,ext:string}}
	local pending=#names
	if pending==0 then return R2 end
	local fDone=false
	for _,name in ipairs(names) do
		tspawn(function()
			if fDone then return end
			local base,pe=stripExt(name)
			if pe and not EXS[pe] then err("FETCH","badext "..name.." "..pe);pending-=1;return end
			for i=1,#EX do
				if fDone then break end
				local s=get(BASE..base..EX[i])
				if s then R2[name]={src=s,ext=EX[i]};break end
			end
			pending-=1
		end)
	end
	local timeout=clock()+32
	while pending>0 and clock()<timeout do twait(0) end
	fDone=true
	local hits=0;for _ in pairs(R2) do hits+=1 end
	inf("FETCH",sfmt("%d/%d in %.2fs",hits,#names,clock()-BT))
	return R2
end

local function getRPX():string?
	local ok,res=pcall(_g.HttpGet,_g,S_RPX.._PID..S_UNI,true)
	if not(ok and res) then return nil end
	local pk,pd=pcall(S.hs.JSONDecode,S.hs,res)
	if not(pk and pd) then return nil end
	return pd.universeId and tostring(pd.universeId) or nil
end

local function resolve():(string?,string?)
	local s,e=fetch(_PID);if s then inf("RES","pid "..e);return s,e end
	local rid=getRPX()
	if rid then s,e=fetch(rid);if s then inf("RES","uid "..e);return s,e end end
	s,e=fetch(_GID);if s then inf("RES","gid "..e);return s,e end
	s,e=fetch("universal");if s then inf("RES","univ "..e);return s,e end
	return nil,nil
end

local function logPlayers()
	local pl=S.plr:GetPlayers();local n=#pl;local li=tcr(n)
	for i=1,n do local p=pl[i];li[i]=sfmt("[%d]@%s uid=%s",i,p.Name,tostring(p.UserId)) end
	inf("SRV",sfmt("%d/%d\n%s",n,S.plr.MaxPlayers,tcat(li,"\n")))
end

local function saveCFG()
	if not writefile then return end
	pcall(writefile,CK,S.hs:JSONEncode({
		o=_xd(C.o),r=_xd(C.r),b=_xd(C.b),f=_xd(C.f),wh=_xd(C.wh),
		rt=C.rt,rd=C.rd,dbg=C.dbg,
	}))
end

local function loadCFG()
	if not(readfile and isfile and isfile(CK)) then return end
	local ok,raw=pcall(readfile,CK);if not(ok and raw) then return end
	pcall(function()
		local d=S.hs:JSONDecode(raw)
		local enc=tfr({o=1,r=1,b=1,f=1,wh=1})
		for k,v in pairs(d) do C[k]=enc[k] and _xe(tostring(v)) or v end
	end)
	RAW=sfmt(S_RFMT,_xd(C.o),_xd(C.r),_xd(C.b))
	BASE=RAW.._xd(C.f).."/"
end

local function checkEnv()
	local det=tcr(12)
	local chk={
		"syn","http_request","request","fluxus","oxygen","electron",
		"wave","krnl","proto","xeno","gethui","hookfunction","newcclosure",
		"clonefunction","getupvalues","is_sirhurt_caller","pebc_script_sig",
		"identifyexecutor","getexecutorname","KRNL_LOADED","CARBON_LOADED",
		"is_exploit_closure","get_nil_instances","getgc","getsenv",
	}
	for _,c2 in ipairs(chk) do if rawget(_E0,c2)~=nil then tins(det,c2) end end
	local exname=""
	if rawget(_E0,"identifyexecutor") then pcall(function()exname=tostring(_E0.identifyexecutor() or "")end)
	elseif rawget(_E0,"getexecutorname") then pcall(function()exname=tostring(_E0.getexecutorname() or "")end) end
	inf("ENV",sfmt("exec:[%s] name:%s uid:%s age:%s",tcat(det,","),exname,_PU,_PA))
end
local function _antiTamper()
	pcall(function()
		local mt=getmt(_g)
		if mt then
			local idx=rawget(mt,"__index")
			if type(idx)=="function" then inf("SEC","mt_hook") end
		end
	end)
	if rawget(_E0,"hookfunction") or rawget(_E0,"hookmetamethod") then
		inf("SEC","hook_api")
	end
	if rawget(_E0,"getconnections") then
		pcall(function()
			local conns=_E0.getconnections(_g.DescendantAdded)
			if conns and #conns>6 then inf("SEC","excess_conn "..tostring(#conns)) end
		end)
	end
end

local _LA=true
local _DL:(()->())?=nil

local function _waitLoad()
	if not _g.IsLoaded then pcall(function()_g.Loaded:Wait()end) end
	repeat twait(0)until _g.IsLoaded
end
local function mkLoader()
	local pg=LP:WaitForChild("PlayerGui",10);if not pg then return nil end
	local TW2=S.tw
	local ES,EC,EB,EQ,EL=Enum.EasingStyle.Sine,Enum.EasingStyle.Cubic,Enum.EasingStyle.Back,Enum.EasingStyle.Quart,Enum.EasingStyle.Elastic
	local EO,EI,EIO=Enum.EasingDirection.Out,Enum.EasingDirection.In,Enum.EasingDirection.InOut
	local U2,V2,U2S=UDim2.new,Vector2.new,UDim2.fromScale
	local C3=Color3.fromRGB
	local mabs=math.abs
	local ACC =C3(88,101,242)
	local ACC2=C3(130,70,255)
	local ACC3=C3(60,200,255)
	local GOLD=C3(255,175,30)
	local MINT=C3(60,255,180)
	local WHITE=C3(255,255,255)
	local DARK=C3(0,0,0)
	local PBK=C3(5,5,16)
	local TXTS=C3(145,145,195)
	local TXTP=C3(60,60,95)
	local function tw(o,t,st,d,p) TW2:Create(o,TweenInfo.new(t,st,d),p):Play() end
	local function mk(c,p,r) local o=newI(c);for k,v in pairs(p)do(o::any)[k]=v end;if r then o.Parent=r end;return o end
	local function cr(p,r) local c=newI("UICorner");c.CornerRadius=UDim.new(0,r or 999);c.Parent=p end
	local function ug(p,c1,c2,rot) local g=newI("UIGradient");g.Color=ColorSequence.new(c1,c2);g.Rotation=rot or 90;g.Parent=p end
	local function us(p,col,th,tr) local s=newI("UIStroke");s.Color=col;s.Thickness=th or 1;s.Transparency=tr or 0;s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border;s.Parent=p;return s end
	local function ugm(p,ks) local g=newI("UIGradient");g.Color=ColorSequence.new(ks);g.Parent=p;return g end
	local rn=function()return"Z"..sfmt("%X",mrnd(0x10000,0xFFFFF))end

	local G=mk("ScreenGui",{Name=rn(),ResetOnSpawn=false,ZIndexBehavior=Enum.ZIndexBehavior.Sibling,IgnoreGuiInset=true,DisplayOrder=999},pg)
	local Base=mk("Frame",{Size=U2S(1,1),BorderSizePixel=0,ZIndex=1,BackgroundColor3=DARK,BackgroundTransparency=1},G)
	local Img=mk("ImageLabel",{Size=U2S(1,1),BackgroundTransparency=1,Image=ICH,ScaleType=Enum.ScaleType.Crop,ImageTransparency=1,ZIndex=2},Base)
	local Grad=mk("ImageLabel",{Size=U2S(1,1),BackgroundTransparency=1,Image="rbxassetid://6015897843",ImageColor3=C3(2,2,10),ImageTransparency=1,ZIndex=3},Base)
	local Vign=mk("ImageLabel",{Size=U2(1,140,1,140),Position=U2(0,-70,0,-70),BackgroundTransparency=1,Image="rbxassetid://1316045217",ImageColor3=DARK,ImageTransparency=1,ZIndex=4},Base)
	local Scan=mk("Frame",{Size=U2(1,0,0,2),Position=U2(0,0,-0.05,0),BackgroundColor3=WHITE,BackgroundTransparency=0.93,BorderSizePixel=0,ZIndex=5},Base)
	local Noise=mk("ImageLabel",{Size=U2S(1,1),BackgroundTransparency=1,Image="rbxassetid://9968287428",ImageTransparency=0.88,ZIndex=6},Base)

	local GlowFar =mk("ImageLabel",{Size=U2(0,680,0,680),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC2,ImageTransparency=1,ZIndex=7},Base)
	local GlowMid =mk("ImageLabel",{Size=U2(0,400,0,400),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC,ImageTransparency=1,ZIndex=8},Base)
	local GlowNear=mk("ImageLabel",{Size=U2(0,200,0,200),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC3,ImageTransparency=1,ZIndex=9},Base)
	local OrbL=mk("ImageLabel",{Size=U2(0,220,0,220),AnchorPoint=V2(0.5,0.5),Position=U2(0.28,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=MINT,ImageTransparency=1,ZIndex=7},Base)
	local OrbR=mk("ImageLabel",{Size=U2(0,220,0,220),AnchorPoint=V2(0.5,0.5),Position=U2(0.72,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=GOLD,ImageTransparency=1,ZIndex=7},Base)
	local Particles=tcr(5)
	do
		local pcols={ACC,ACC2,ACC3,MINT,GOLD}
		for pi2=1,5 do
			local psz=mrnd(3,7)
			Particles[pi2]=mk("Frame",{
				Size=U2(0,psz,0,psz),AnchorPoint=V2(0.5,0.5),
				Position=U2(0.3+pi2*0.08,0,0.22+pi2*0.03,0),
				BackgroundColor3=pcols[pi2],BorderSizePixel=0,
				BackgroundTransparency=0.3,ZIndex=9,
			},Base)
			cr(Particles[pi2])
		end
	end
	local LogoRing=mk("ImageLabel",{Size=U2(0,130,0,130),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,0.37,0),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC,ImageTransparency=1,ZIndex=10},Base)
	local Logo    =mk("ImageLabel",{Size=U2(0,108,0,108),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,0.37,0),BackgroundTransparency=1,Image=AVA,ImageTransparency=1,ZIndex=11},Base)

	local Panel=mk("Frame",{Size=U2(0,440,0,158),AnchorPoint=V2(0.5,0.5),Position=U2(0.5,0,1.18,0),BackgroundTransparency=1,BorderSizePixel=0,ZIndex=11},Base)
	local PBG=mk("Frame",{Size=U2S(1,1),BorderSizePixel=0,BackgroundColor3=PBK,BackgroundTransparency=0.08,ZIndex=11},Panel);cr(PBG,14)
	ugm(PBG,{
		ColorSequenceKeypoint.new(0,C3(10,10,28)),
		ColorSequenceKeypoint.new(0.5,C3(6,6,18)),
		ColorSequenceKeypoint.new(1,C3(3,3,12)),
	})
	local PST=us(PBG,ACC,1.8,0.32)
	local TL=mk("Frame",{Size=U2(1,0,0,2),Position=U2(0,0,0,0),BorderSizePixel=0,BackgroundColor3=ACC,ZIndex=12},Panel);cr(TL,2)
	ugm(TL,{
		ColorSequenceKeypoint.new(0,ACC2),
		ColorSequenceKeypoint.new(0.5,ACC3),
		ColorSequenceKeypoint.new(1,MINT),
	})
	local CG=mk("ImageLabel",{Size=U2(0,90,0,90),Position=U2(0,-22,0,-22),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC2,ImageTransparency=0.65,ZIndex=12},Panel)
	local CGR=mk("ImageLabel",{Size=U2(0,70,0,70),Position=U2(1,-48,0,-18),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=MINT,ImageTransparency=0.78,ZIndex=12},Panel)
	mk("TextLabel",{Size=U2(0.55,0,0,34),Position=U2(0,14,0,10),BackgroundTransparency=1,TextColor3=WHITE,TextScaled=true,Font=Enum.Font.GothamBold,Text="ZURAI HUB",TextXAlignment=Enum.TextXAlignment.Left,ZIndex=13},Panel)
	local BB=mk("Frame",{Size=U2(0,52,0,20),Position=U2(0,14,0,46),BackgroundColor3=GOLD,BorderSizePixel=0,ZIndex=13},Panel);cr(BB,4)
	ugm(BB,{ColorSequenceKeypoint.new(0,GOLD),ColorSequenceKeypoint.new(1,C3(255,120,20))})
	mk("TextLabel",{Size=U2S(1,1),BackgroundTransparency=1,TextColor3=C3(18,8,0),TextScaled=true,Font=Enum.Font.GothamBold,Text="BETA",ZIndex=14},BB)
	mk("TextLabel",{Size=U2(0,90,0,18),Position=U2(1,-104,0,13),BackgroundTransparency=1,TextColor3=ACC3,TextScaled=true,Font=Enum.Font.Gotham,Text="v".._VER,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=13},Panel)
	mk("TextLabel",{Size=U2(0,90,0,14),Position=U2(1,-104,0,32),BackgroundTransparency=1,TextColor3=TXTP,TextScaled=true,Font=Enum.Font.Gotham,Text="build ".._BLD,TextXAlignment=Enum.TextXAlignment.Right,ZIndex=13},Panel)
	mk("Frame",{Size=U2(1,-28,0,1),Position=U2(0,14,0,70),BackgroundColor3=ACC,BackgroundTransparency=0.65,BorderSizePixel=0,ZIndex=12},Panel)
	local BarBG=mk("Frame",{Size=U2(1,-28,0,8),Position=U2(0,14,0,82),BackgroundColor3=C3(10,10,24),BorderSizePixel=0,ZIndex=12},Panel);cr(BarBG)
	us(BarBG,ACC,1,0.6)
	local Bar=mk("Frame",{Size=U2(0,0,1,0),BorderSizePixel=0,ZIndex=13},BarBG);cr(Bar)
	ugm(Bar,{
		ColorSequenceKeypoint.new(0,ACC),
		ColorSequenceKeypoint.new(0.5,ACC2),
		ColorSequenceKeypoint.new(1,ACC3),
	})
	local BarShim=mk("Frame",{Size=U2(0.22,0,1,0),Position=U2(-0.22,0,0,0),BackgroundColor3=WHITE,BackgroundTransparency=0.7,BorderSizePixel=0,ZIndex=14},Bar);cr(BarShim)
	local BarGlow=mk("ImageLabel",{Size=U2(1,0,8,0),Position=U2(0,0,0.5,-20),BackgroundTransparency=1,Image="rbxassetid://5028857472",ImageColor3=ACC2,ImageTransparency=0.38,ZIndex=13},Bar)
	local Stat=mk("TextLabel",{Size=U2(0.66,0,0,18),Position=U2(0,14,0,99),BackgroundTransparency=1,TextColor3=TXTS,TextScaled=true,Font=Enum.Font.Gotham,Text="Initialising...",TextXAlignment=Enum.TextXAlignment.Left,ZIndex=13},Panel)
	local Pct=mk("TextLabel",{Size=U2(0.34,-14,0,18),Position=U2(0.66,0,0,99),BackgroundTransparency=1,TextColor3=WHITE,TextScaled=true,Font=Enum.Font.GothamBold,Text="0%",TextXAlignment=Enum.TextXAlignment.Right,ZIndex=13},Panel)
	mk("TextLabel",{Size=U2(1,-28,0,15),Position=U2(0,14,0,138),BackgroundTransparency=1,TextColor3=TXTP,TextScaled=true,Font=Enum.Font.Gotham,Text=sfmt("@%s · %s · uid %s",LP.Name,LP.DisplayName,_PU),TextXAlignment=Enum.TextXAlignment.Left,ZIndex=13},Panel)

	local alive,PCS=true,nil
	local function kill()
		alive=false
		if PCS then PCS:Disconnect();PCS=nil end
		if G and G.Parent then G:Destroy() end
	end
	local function setBar(p2:number,txt:string?)
		local cl=mmin(1,mmax(0,p2))
		TW2:Create(Bar,TweenInfo.new(0.32,ES,EO),{Size=U2(cl,0,1,0)}):Play()
		TW2:Create(BarGlow,TweenInfo.new(0.32,ES,EO),{Size=U2(cl,0,8,0)}):Play()
		Pct.Text=sfmt("%d%%",mflr(cl*100))
		if txt then Stat.Text=txt end
		if cl>=0.999 then
			tspawn(function()
				for _=1,3 do
					TW2:Create(BarGlow,TweenInfo.new(0.16,ES,EO),{ImageTransparency=0.06}):Play()
					twait(0.20)
					TW2:Create(BarGlow,TweenInfo.new(0.16,ES,EO),{ImageTransparency=0.38}):Play()
					twait(0.20)
				end
			end)
		end
	end
	local function pulse()
		local t,st2,ot=0,0,0
		local dotT,dotN=0,0
		PCS=S.rs.Heartbeat:Connect(function(dt)
			if not alive then return end
			t+=dt;st2+=dt*0.5;ot+=dt
			local s =msin(t*2.2)
			local s2=msin(t*0.85+0.9)
			local s3=msin(t*3.3+0.3)
			local s4=msin(t*1.1+2.1)
			local sz=108+s*10
			local ringsz=sz+24
			Logo.Size=U2(0,sz,0,sz);Logo.Position=U2(0.5,-sz/2,0.37,-sz/2)
			LogoRing.Size=U2(0,ringsz,0,ringsz);LogoRing.Position=U2(0.5,-ringsz/2,0.37,-ringsz/2)
			GlowNear.ImageTransparency=0.48+s*0.20
			GlowMid.ImageTransparency=0.28+s2*0.14
			GlowFar.ImageTransparency=0.58+s3*0.09
			OrbL.ImageTransparency=0.62+s4*0.15
			OrbR.ImageTransparency=0.64+mabs(s2)*0.13
			LogoRing.ImageTransparency=0.62+mabs(s)*0.18
			PST.Transparency=0.22+mabs(s)*0.44
			TL.BackgroundTransparency=mabs(s)*0.28
			CG.ImageTransparency=0.52+s2*0.18
			CGR.ImageTransparency=0.60+mabs(s3)*0.15
			Scan.Position=U2(0,0,(t*0.062)%1.10,0)
			BarShim.Position=U2((st2%1.4)-0.22,0,0,0)
			for pi3=1,5 do
				local pt=Particles[pi3]
				if pt and pt.Parent then
					local ang=t*0.6+pi3*1.26
					local rad=40+pi3*12
					pt.Position=U2(0.5+msin(ang)*rad/820,0,0.37+msin(ang*0.72+pi3)*rad/620,0)
					pt.BackgroundTransparency=0.18+mabs(msin(t*1.9+pi3*0.95))*0.68
				end
			end
			local ox=msin(ot*0.28)*18
			local oy=msin(ot*0.35+1.2)*12
			OrbL.Position=U2(0.28,ox,0.37,oy)
			OrbR.Position=U2(0.72,-ox,0.37,-oy)
		end)
	end
	local function wipe(fast:boolean)
		if not _LA then return end
		_LA=false;alive=false
		if PCS then PCS:Disconnect();PCS=nil end
		local lt =fast and 0.14 or 0.24
		local hold=fast and 0    or 2.6
		local ft  =fast and 0.26 or 0.82
		tw(Logo,lt,EC,EI,{ImageTransparency=1,Size=U2(0,44,0,44),Position=U2(0.5,-22,0.37,-22)})
		tw(LogoRing,lt,EC,EI,{ImageTransparency=1,Size=U2(0,28,0,28),Position=U2(0.5,-14,0.37,-14)})
		tw(GlowNear,lt,EC,EI,{ImageTransparency=1,Size=U2(0,0,0,0)})
		tw(GlowMid,lt,EC,EI,{ImageTransparency=1})
		tw(GlowFar,lt*1.3,EC,EI,{ImageTransparency=1})
		tw(OrbL,lt,ES,EI,{ImageTransparency=1})
		tw(OrbR,lt,ES,EI,{ImageTransparency=1})
		for _,pt in ipairs(Particles) do
			if pt and pt.Parent then tw(pt,lt,ES,EI,{BackgroundTransparency=1}) end
		end
		tw(Panel,lt,EQ,EI,{Position=U2(0.5,0,1.12,0),BackgroundTransparency=1})
		tw(PBG,lt,ES,EI,{BackgroundTransparency=1})
		tw(Scan,lt,ES,EI,{BackgroundTransparency=1})
		tdelay(lt+hold,function()
			tw(Vign,ft,ES,EI,{ImageTransparency=1})
			tw(Noise,ft,ES,EI,{ImageTransparency=1})
			tw(Img,ft+0.14,ES,EI,{ImageTransparency=1})
			tw(Grad,ft+0.14,ES,EI,{ImageTransparency=1})
			tw(Base,ft+0.28,ES,EI,{BackgroundTransparency=1})
			tdelay(ft+0.36,kill)
		end)
	end
	_DL=function()wipe(true)end
	tw(Base,0.05,ES,EO,{BackgroundTransparency=0})
	tw(Img,1.0,ES,EO,{ImageTransparency=0.03})
	tw(Grad,0.9,ES,EO,{ImageTransparency=0})
	tw(Vign,1.0,ES,EO,{ImageTransparency=0.22})
	tw(Scan,0.9,ES,EO,{BackgroundTransparency=0.93})
	tw(Noise,0.9,ES,EO,{ImageTransparency=0.88})
	tdelay(0.22,function()
		tw(GlowFar,0.7,ES,EO,{ImageTransparency=0.60})
		tw(GlowMid,0.65,ES,EO,{ImageTransparency=0.30})
		tw(GlowNear,0.58,ES,EO,{ImageTransparency=0.50})
		tw(OrbL,0.7,ES,EO,{ImageTransparency=0.68})
		tw(OrbR,0.7,ES,EO,{ImageTransparency=0.70})
		tw(LogoRing,0.65,ES,EO,{ImageTransparency=0.65})
		tw(Logo,0.52,EB,EO,{ImageTransparency=0})
		tw(Panel,0.55,EB,EO,{Position=U2(0.5,0,0.76,0)})
		tw(PBG,0.55,ES,EO,{BackgroundTransparency=0.08})
		tdelay(0.44,pulse)
	end)
	return setmt({},{__index={destroy=function()wipe(false)end,destroyFast=function()wipe(true)end,setBar=setBar}})::any
end
loadCFG();checkEnv();_antiTamper()
local ld=mkLoader()
inf("BOOT",sfmt("v%s b=%s s=%X p=%s j=%s|%s",_VER,_BLD,_SEED,_PID,_JID,_pi()))
logPlayers()
tspawn(function()
	if ld then ld.setBar(0.04,"Waiting for game...") end
	_waitLoad()
	if ld then ld.setBar(0.16,"Fetching scripts...") end
	local bt=fetchB({_PID,_GID,"anti-afk"})
	local gse=bt[_PID] or bt[_GID]
	local gs_src:string?=gse and gse.src or nil
	local gs_ext:string?=gse and gse.ext or nil
	if not gs_src then
		if ld then ld.setBar(0.52,"Resolving game...") end
		gs_src,gs_ext=resolve()
	end
	if ld then ld.setBar(0.88,"Executing...") end
	vmExec(gs_src,gs_ext,"game",function()
		if ld then ld.setBar(1,"Done!") end
		tdelay(0.9,function()if ld then ld.destroy()end end)
	end)
	local afke=bt["anti-afk"]
	if afke then vmExec(afke.src,afke.ext,"anti-afk")
	else local as,ae=fetchP(S_AFK);vmExec(as,ae,"anti-afk") end
	log("BOOT","ready ".._el())
	tdelay(10,function()if _LA and ld then ld.destroy()end end)
	saveCFG()
end)

return tfr({
	_VERSION=_VER,_BUILD=_BLD,_SEED=_SEED,
	RAW=RAW,BASE=BASE,C=C,xd=_xd,xe=_xe,
	saveCFG=saveCFG,loadCFG=loadCFG,
	fetch=fetch,fetchP=fetchP,fetchB=fetchB,
	vmExec=vmExec,vmExecPath=vmExecPath,get=get,
	log=log,err=err,inf=inf,dbg=dbg,
	destroyLoader=function() if _DL then _DL() end end,
	gitPath=function(path:string) return RAW..path end,
	elapsed=_el,
})
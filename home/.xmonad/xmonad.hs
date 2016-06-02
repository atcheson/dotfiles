import XMonad
import XMonad.Util.EZConfig
import XMonad.Layout.ResizableTile
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Util.Run

import qualified XMonad.StackSet as W

myFocusedBorderColor = "#C40000"
myUnfocusedBorderColor = "#737373"
xmobarTitleColor = "#007FEE"
xmobarCurrentWorkspaceColor = "#CEFFAC"

main = do
	xmproc <- spawnPipe "~/.cabal/bin/xmobar"
	xmonad $ defaultConfig {
		modMask = mod4Mask,
		terminal = "urxvt",
                focusedBorderColor = myFocusedBorderColor,
                normalBorderColor = myUnfocusedBorderColor,
		startupHook = myStartupHook,
		manageHook = myManageHook,
		layoutHook = myLayout,
		logHook = myLogHook xmproc,
        handleEventHook = docksEventHook <+> handleEventHook defaultConfig
	}`additionalKeysP` myAdditionalKeys

myAdditionalKeys = 
	[
		("M-z", sendMessage MirrorShrink),
		("M-a", sendMessage MirrorExpand),
		("M-p", spawn "`~/.cabal/bin/yeganesh -x`"),
		("M-q", spawn "pkill trayer; xmonad --recompile; xmonad --restart"),
		("M-o", spawn "thunar"),
		("M-i", spawn "chromium")
	]

myLayout = avoidStruts 
	(
		ResizableTall 1 (1/20) (14/20) [] |||
		noBorders (fullscreenFull Full)
	)

myLogHook outpipe = dynamicLogWithPP $ xmobarPP
	{
		ppOutput = hPutStrLn outpipe,
		ppTitle = xmobarColor xmobarTitleColor "" . shorten 100,
		ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "",
		ppSep = "   "
	}

myManageHook = composeAll
	[return True -?> doF avoidMaster,
	 className =? "trayer" --> doIgnore]

myStartupHook = do
	spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 4 --height 15 --transparent true 0x000000"

avoidMaster :: W.StackSet i l a s sd -> W.StackSet i l a s sd
avoidMaster = W.modify' $ \c -> case c of
     W.Stack t [] (r:rs) ->  W.Stack t [r] rs
     otherwise           -> c


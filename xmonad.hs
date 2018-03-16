-- ~/.xmonad/xmonad.hs

import Data.Monoid
import qualified Data.Map as M

import System.Exit

import XMonad
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W

keybindings conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
   -- alt+enter opens terminal
   -- super+enter starts firefox
   -- alt+space starts dmenu_run
   [ ((modMask                 , xK_Return)   , spawn $ XMonad.terminal conf)
   , ((mod4Mask                , xK_Return)   , spawn "firefox")
   , ((modMask                 , xK_space)    , spawn "dmenu_run")

   -- alt+<j,k> focuses <next,prev> window
   -- alt+shift+<j,k> swaps focused window and <next,prev> window
   -- alt+; swaps focused window and master window
   , ((modMask                 , xK_j)        , windows W.focusDown)
   , ((modMask                 , xK_k)        , windows W.focusUp)
   , ((modMask .|. shiftMask   , xK_j)        , windows W.swapDown)
   , ((modMask .|. shiftMask   , xK_k)        , windows W.swapUp)
   , ((modMask                 , xK_semicolon), windows W.swapMaster)

   -- alt+ctrl+j goes to next layout
   , ((modMask .|. controlMask , xK_j)        , sendMessage NextLayout)

   -- super+<j,k> shows <next,prev> workspace
   -- super+shift+<j,k> moves focused window to <next,prev> workspace
   -- super+ctrl+<j,k> moves focused window to <next,prev> empty workspace
   , ((mod4Mask                , xK_j)        , moveTo  Next (WSIs (return $ not . (=="SP") . W.tag)))
   , ((mod4Mask                , xK_k)        , moveTo  Prev (WSIs (return $ not . (=="SP") . W.tag)))
   , ((mod4Mask .|. shiftMask  , xK_j)        , shiftTo Next (WSIs (return $ not . (=="SP") . W.tag)))
   , ((mod4Mask .|. shiftMask  , xK_k)        , shiftTo Prev (WSIs (return $ not . (=="SP") . W.tag)))
   , ((mod4Mask .|. controlMask, xK_j)        , shiftTo Next EmptyWS)
   , ((mod4Mask .|. controlMask, xK_k)        , shiftTo Prev EmptyWS)

   -- alt+<h,l> <decreases,increases> size of master pane
   -- super+<h,l> <decreases,increases> number of windows in master pane
   , ((modMask                 , xK_h)        , sendMessage Shrink)
   , ((modMask                 , xK_l)        , sendMessage Expand)
   , ((mod4Mask                , xK_h)        , sendMessage $ IncMasterN 1)
   , ((mod4Mask                , xK_l)        , sendMessage $ IncMasterN (-1))

   -- alt+q closes focused window
   -- super+<,shift>+q <closes,restarts> XMonad
   , ((modMask                 , xK_q)        , kill)
   , ((mod4Mask                , xK_q)        , io $ exitWith ExitSuccess)
   , ((mod4Mask .|. shiftMask  , xK_q)        , broadcastMessage ReleaseResources >> restart [] True)
   
   ] ++

   -- super+n shows workspace n | n <- [1 .. 9]
   -- super+shift+n moves focused window to workspace n | n <- [1 .. 9]
   [((m .|. mod4Mask, k), windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
                                        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

layouts = (spacingWithEdge 12 $ Tall 1 (3/100) (1/2)) ||| noBorders Full

main = xmonad
     $ defaultConfig { normalBorderColor  = "#ffffff"
                     , focusedBorderColor = "#771f1f"
                     , borderWidth        = 2
                     , keys               = keybindings
                     , terminal           = "urxvt"
                     , layoutHook         = layouts
                     , focusFollowsMouse  = True
                     }


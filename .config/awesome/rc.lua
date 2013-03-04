-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
require("vicious")

function run_once(prg, args)
  if not prg then
    do return nil end
  end
  if not args then
    args=""
  end
  awful.util.spawn_with_shell('pgrep -f -u $USER -x ' .. prg .. ' || (' .. prg .. ' ' .. args ..')')
end
                
-- {{{ Variable definitions
--get $HOME from the environement system
home   = os.getenv("HOME")
--get XDG_CONFIG
config_dir = awful.util.getdir("config")
-- Themes define colours, icons, and wallpapers
beautiful.init( config_dir .. "/current_theme/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "gnome-terminal"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
browser="chromium-browser"
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

--Lancement d'applications
run_once("nm-applet")
run_once("gnome-sound-applet")
run_once("udisks-glue")
---- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ naughty theme
naughty.config.default_preset.font             = beautiful.notify_font 
naughty.config.default_preset.fg               = beautiful.notify_fg
naughty.config.default_preset.bg               = beautiful.notify_bg
naughty.config.presets.normal.border_color     = beautiful.notify_border
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1⇋ MAIN", "2⇋ ALT", "3⇋ VM", "4⇋ COMM", "5⇋ MISC", "6⇋ MISC"}, s, layouts[1])
end

--
-- {{{ Menu
icon_dir = config_dir.."/icons"
-- Create a laucher widget and a main menu
office_menu = {
	{"LibreOffice Calc","/usr/bin/libreoffice --calc",icon_dir.."/libreoffice-calc.xpm"},
	{"LibreOffice Impress","/usr/bin/libreoffice --impress",icon_dir.."/libreoffice-impress.xpm"},
	{"LibreOffice Writer","/usr/bin/libreoffice --writer",icon_dir.."/libreoffice-writer.xpm"},
}
utils_menu = {
	{"aRandR","/usr/bin/arandr"},
	{"Character map","/usr/bin/gucharmap"},
	{"GNOME control center","/usr/bin/gnome-control-center"},
	{"GNOME system monitor","/usr/bin/gnome-system-monitor"},
	{"pavucontrol","/usr/bin/pavucontrol"},
	{"Qalculate","/usr/bin/qalculate-gtk"},
	{"Xkill","xkill"},
}
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "reload", awesome.restart },
   { "logout", awesome.quit },
   { "reboot", "/usr/bin/gksu /sbin/reboot" },
   { "hibernate", "gksu pm-hibernate"},
   { "shutdown", "/usr/bin/gksu /sbin/halt" },
}
favorites_menu = {
  { "chromium", "/usr/bin/chromium-browser", icon_dir.."/chromium-browser.xpm" },
  { "thunderbird", "/usr/bin/thunderbird", icon_dir.."/thunderbird.xpm"},
  { "pidgin", "/usr/bin/pidgin", icon_dir.."/pidgin.xpm" },
  { "skype", "/usr/bin/skype", icon_dir.."/skype.xpm" },
  { "teamviewer", "/usr/bin/teamviewer", icon_dir.."/teamviewer.xpm" },
  { "vmware", "/usr/bin/vmware", icon_dir.."/vmware-workstation.xpm" },
  { "sublime", "sublime_text", icon_dir.."/sublime_text.xpm" },
  { "wireshark","/usr/bin/wireshark",icon_dir.."/wireshark.xpm"},
  { "eclipse","eclipse", icon_dir.."/eclipse.xpm" },
  { "pithos", "pithos", icon_dir.."/pithos.xpm" },
  { "nautilus", "/usr/bin/nautilus --no-desktop", icon_dir.."/nautilus.xpm" },
}

mymainmenu = awful.menu(
{ items = 
  { 
    { "favorites", favorites_menu, icon_dir.."/favorites.xpm" },
    { "utils", utils_menu, icon_dir.."/utils.xpm" },
    { "office", office_menu, icon_dir.."/office.xpm" },
    { "awesome", myawesomemenu, beautiful.awesome_icon },
  }
})

-- {{{ Wibox
-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

--- {{ Section des Widgets
-- Create separator widget
separator = widget({ type = "textbox", name = "separator"})
separator.text = " "

-- Create a systray
mysystray = widget({ type = "systray" })


--pango
    pango_small="size=\"small\""
    pango_x_small="size=\"x-small\""
    pango_xx_small="size=\"xx-small\""
    pango_bold="weight=\"bold\""
--test oocairo
require("blingbling")

local widget_height = 22 
batwidget = widget({type = "textbox"})
batwidget=blingbling.progress_bar.new()
batwidget:set_height(widget_height)
batwidget:set_width(50)
batwidget:set_horizontal(true)
batwidget:set_show_text(true)
batwidget:set_font_size(10)
batwidget:set_label("$percent%")
batwidget:set_graph_color("#1AE000")
batwidget:set_background_graph_color("#FF0000")
batwidget:set_background_text_color("#FFFFFFA0")
batwidget:set_text_color("#000000")
vicious.register(batwidget, vicious.widgets.bat, "$2", 60, "BAT0")

    -- Date
    datewidget = widget({ type = "textbox" })
    --vicious.register(datewidget, vicious.widgets.date, "<span color=\""..beautiful.text_font_color_1.."\" "..pango_small..">%R</span>", 60)

    mytextclock = awful.widget.textclock({ align = "right" }, "<span color='white'>%I:%M%p</span>", 60)


 --Cpu widget 
  cpulabel= widget({ type = "textbox" })
  cpulabel.text='<span color="'..beautiful.textbox_widget_as_label_font_color..'" '..pango_small..' '..pango_bold..'>CPU: </span>'
  cpu=blingbling.classical_graph.new()
  cpu:set_font_size(8)
  cpu:set_height(widget_height)
  cpu:set_width(75)
  cpu:set_show_text(true)
  cpu:set_label("$percent %")
  cpu:set_graph_color("#00ccff00")
  --Use transparency on graph line color to reduce the width of line with low resolution screen
  cpu:set_graph_line_color("#ff330088")
  cpu:set_filled(true)
  cpu:set_h_margin(2)
  cpu:set_background_color("#00000044")
  cpu:set_filled_color("#00000099")
  cpu:set_rounded_size(0.6)
  vicious.register(cpu, vicious.widgets.cpu, '$1',7,"BAT0")
 
-- Mem Widget
  memlabel= widget({ type = "textbox" })
  memlabel.text='<span color="'..beautiful.textbox_widget_as_label_font_color..'" '..pango_small..'>MEM: </span>'
  
  memwidget = blingbling.classical_graph.new()
  memwidget:set_font_size(8)
  memwidget:set_height(widget_height)
  memwidget:set_h_margin(2)
  memwidget:set_width(75)
  memwidget:set_filled(true)
  memwidget:set_show_text(true)
  memwidget:set_filled_color("#00000099")
  memwidget:set_rounded_size(0.6)
  --We just want the line of the graph
  memwidget:set_graph_color("#00ccff00")
  --Use transparency on graph line color to reduce the width of line with low resolution screen
  memwidget:set_graph_line_color("#00ccff88")
  memwidget:set_background_color("#00000044")
  vicious.register(memwidget, vicious.widgets.mem, "$1", 5)

--task_warrior menu
-- task_warrior=blingbling.task_warrior.new(beautiful.tasks)
-- task_warrior:set_task_done_icon(beautiful.task_done)
-- task_warrior:set_task_icon(beautiful.task)
-- task_warrior:set_project_icon(beautiful.project)

----Mpd widgets
-- mpdlabel= widget({ type = "textbox" })
-- mpdlabel.text='<span color="'..beautiful.textbox_widget_as_label_font_color..'" '..pango_small..'>MPD: </span>'
--
--  my_mpd=blingbling.mpd_visualizer.new()
--  my_mpd:set_height(16)
--  my_mpd:set_width(340)
--  my_mpd:update()
--  my_mpd:set_line(true)
--  my_mpd:set_h_margin(2)
--  my_mpd:set_mpc_commands()
--  my_mpd:set_launch_mpd_client(terminal .. " -e ncmpcpp")
--  my_mpd:set_show_text(true)
--  my_mpd:set_font_size(8)
--  my_mpd:set_graph_color("#d4aa00ff")
--  my_mpd:set_label("$artist > $title")
--   
--  my_mpd_volume=blingbling.volume.new()
--  my_mpd_volume:set_height(16)
--  my_mpd_volume:set_width(20)
--  my_mpd_volume:set_v_margin(3)
--  my_mpd_volume:update_mpd()
--  my_mpd_volume:set_bar(true)

--udisks-glue menu
  udisks_glue=blingbling.udisks_glue.new(beautiful.udisks_glue)
  udisks_glue:set_mount_icon(beautiful.accept)
  udisks_glue:set_umount_icon(beautiful.cancel)
  udisks_glue:set_detach_icon(beautiful.cancel)
  udisks_glue:set_Usb_icon(beautiful.usb)
  udisks_glue:set_Cdrom_icon(beautiful.cdrom)
  awful.widget.layout.margins[udisks_glue.widget]= { top = 4}
  udisks_glue.widget.resize= false
--Calendar widget
  my_cal =blingbling.calendar.new({type = "imagebox", image = beautiful.calendar})
  my_cal:set_cell_padding(2)
  my_cal:set_title_font_size(9)
  my_cal:set_font_size(10)
  my_cal:set_inter_margin(1)
  my_cal:set_columns_lines_titles_font_size(8)
  my_cal:set_columns_lines_titles_text_color("#d4aa00ff")

--disk usage widget
  fsrootlabel= widget({ type = "textbox", name = "fsrootlabel" })
  fsrootlabel.text='<span color="'..beautiful.textbox_widget_as_label_font_color..'" '..pango_small..'>DISK: </span>'
  fsroot = blingbling.value_text_box.new()
  fsroot:set_width(25)
  fsroot:set_height(widget_height)
  fsroot:set_filled(true)
  fsroot:set_filled_color("#00000099")
  fsroot:set_rounded_size(0.6)
  fsroot:set_values_text_color({{"#88aa00ff",0},{"#d4aa00ff", 0.5},{"#d45500ff",0.75}})
  fsroot:set_font_size(8)
  fsroot:set_background_color("#00000044")
  fsroot:set_label("$percent%")
  vicious.register(fsroot, vicious.widgets.fs, "${/ used_p}", 120 )

--Volume
--  volume_label = widget({ type = "textbox"})
--  volume_label.text='<span '..pango_small..'><span color="'..beautiful.textbox_widget_as_label_font_color..'">Vol.: </span></span>'
--  my_volume=blingbling.volume.new()
--  my_volume:set_height(16)
--  my_volume:set_v_margin(3)
--  my_volume:set_width(20)
--  my_volume:update_master()
--  my_volume:set_master_control()
--  my_volume:set_bar(true)
--  my_volume:set_background_graph_color("#00000099")
--  my_volume:set_graph_color("#00ccffaa")
-- wiboxs
    mywibox[s] = awful.wibox({ position = "top", screen = s, height=24 })
    
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
              {
                mytaglist[s],
                separator,
                mypromptbox[s],
                separator,
	              cpulabel,
                cpu.widget,
                separator,
	              memlabel,
                memwidget.widget,
	              separator,
	              udisks_glue.widget,
                separator,
                fsrootlabel,
                fsroot.widget,
                separator,
                batwidget,
                separator,
--                mpdlabel,
--                separator,
--                my_mpd_volume,
--                separator,
--                my_mpd.widget,
--                separator,
                layout = awful.widget.layout.horizontal.leftright
	            },
              separator,
              mytextclock,
	            --datewidget, 
              separator,
              my_cal.widget,
              separator,
              --task_warrior.widget,
              --separator,
	            s == 1 and mysystray or nil,
              separator,
              mytasklist[s],
              separator,
              --my_volume.widget,
              --volume_label,
              layout = awful.widget.layout.horizontal.rightleft
    }

end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),
    awful.key({ "Mod1", "Control" }, "l", function () awful.util.spawn("gnome-screensaver-command --lock") end),


--    awful.key({ "#151",        }, "c",     function () awful.util.spawn(browser)     end),
--    awful.key({ modkey, "Mod1"       }, "t",     function () awful.util.spawn("thunderbird") end),
--    awful.key({ modkey, "Mod1"       }, "v",     function () awful.util.spawn("vmware")  end),
--    awful.key({ modkey, "Mod1"       }, "p",     function () awful.util.spawn("pidgin")      end),
--    awful.key({ modkey, "Mod1"       }, "s",     function () awful.util.spawn("skype")      end),
--    awful.key({ modkey, "Mod1"       }, "n",     function () awful.util.spawn("nautilus")      end),
--    awful.key({ modkey, "Mod1"       }, "w",     function () awful.util.spawn("wireshark")      end),
--    awful.key({ modkey, "Modk"       }, "e",     function () awful.util.spawn("sublime_text")      end),
    
    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "Skype"},
      properties = { tag = tags[1][4], switchtotag = false } },
    { rule = { class = "Pidgin"},
      properties = { tag = tags[1][4], switchtotag = false } },
    { rule = { class = "Firefox"},
      properties = { tag = tags[1][5], switchtotag = false } },
    { rule = { class = "Chromium"},
      properties = { tag = tags[1][2], switchtotag = true } },
    { rule = { class = "Eclipse" },
      properties = { tag = tags[1][3], switchtotag = true } },
    { rule = { instance = "virtualbox" },
      properties = { tag = tags[1][3], switchtotag = false} },
    { rule = { instance = "vmware" },
      properties = { tag = tags[1][3], switchtotag = false} },
    { rule = { class = "Thunderbird" },
      properties = { tag = tags[1][4], switchtotag = false } },
}	
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
    -- Add a titlebar
    -- awful.titlebar.add(c, { modkey = modkey })

    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

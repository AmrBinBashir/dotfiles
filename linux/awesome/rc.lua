-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")



-- {{{ Error handling
--
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}



-- {{{ Variable definitions
--
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
modkey = "Mod4"
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating
}
-- }}}


-- {{{ Create workspaces/tags for each screen
--
awful.screen.connect_for_each_screen(
    function(s)
        awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    end
)
-- }}}


-- {{{ Key bindings
--
globalkeys = gears.table.join(
    -- Navigate between workspaces/tags
    awful.key({modkey}, "Left", awful.tag.viewprev,
        {description = "view previous", group = "tag"}),
    awful.key({modkey}, "Right", awful.tag.viewnext,
        {description = "view next", group = "tag"}),

    -- Change focus
    awful.key({modkey}, "j", function() awful.client.focus.byidx(1) end,
        {description = "focus next by index", group = "client"}),
    awful.key({modkey}, "k", function() awful.client.focus.byidx(-1) end,
        {description = "focus previous by index", group = "client"}),

    -- Swap windows/clients
    awful.key({modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
        {description = "swap with next client by index", group = "client"}),
    awful.key({modkey, "Shift"}, "k", function() awful.client.swap.byidx(-1) end,
        {description = "swap with previous client by index", group = "client"}),

    -- Change master window/client size
    awful.key({modkey}, "l", function() awful.tag.incmwfact(0.05) end,
        {description = "increase master width factor", group = "layout"}),
    awful.key({modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
        {description = "decrease master width factor", group = "layout"}),

    -- Change the number of master windows/clients
    awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1, nil, true) end,
    {description = "increase the number of master clients", group = "layout"}),
    awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1, nil, true) end,
    {description = "decrease the number of master clients", group = "layout"}),

    -- Change the number of stack column
    awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1, nil, true) end,
        {description = "increase the number of columns", group = "layout"}),
    awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1, nil, true) end,
        {description = "decrease the number of columns", group = "layout"}),

    -- Toggle between layouts
    awful.key({modkey}, "t", function() awful.layout.inc(1) end,
        {description = "select next", group = "layout"}),
    awful.key({modkey, "Shift"}, "t", function() awful.layout.inc(-1) end,
        {description = "select previous", group = "layout"}),

    -- Minimze window/client
    awful.key({modkey, "Control"}, "n",
            function()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
                end
            end,
        {description = "restore minimized", group = "client"}),

    -- Manage awesome-wm
    awful.key({modkey, "Shift"}, "r", awesome.restart,
        {description = "reload awesome", group = "awesome" }),
    awful.key({modkey, "Shift"}, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}),

    -- Show keybindings flyout
    awful.key({modkey}, "s", hotkeys_popup.show_help,
        {description = "show help", group = "awesome"})
)

clientkeys = gears.table.join(
    awful.key({modkey}, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({modkey}, "q",
            function(c)
                -- Minimizes spotify to tray rather than closing it
                if c.class == "Spotify" then
                    awful.spawn.with_shell("spotify-tray -t")
                else
                    c:kill()
                end
            end,
        {description = "close",group = "client"}),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}),
    awful.key({modkey, "Shift"}, "Return", function(c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}),
    -- Minimize/Maximize window/client
    awful.key({modkey}, "n", function(c) c.minimized = true end,
        {description = "minimize", group = "client"}),
    awful.key({modkey}, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
        {description = "(un)maximize", group = "client"})
)

function update_awesomewm_workspaces_for_polybar()
    local tags = awful.screen.focused().tags
    local args = ""

    for _,v in pairs(tags) do
        args = args..v.name
        if next(v:clients()) == nil then
            args = args.."-empty"
        else
            -- If the first workspace has only polybar then count it as empty
            if (v.name == "1" and #v:clients() == 1 and v:clients()[1].class == "Polybar") then
                args = args.."-empty"
            else
                args = args.."-full"
            end

        end

        if v.selected  then
            args = args.."-active/"
        else
            args = args.."-inactive/"
        end
    end

    awful.spawn.with_shell("python $HOME/dotfiles/linux/polybar/scripts/polybar-awesomewm-workspaces.py "..args)
end

-- Bind all key numbers to workspaces/tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
    -- View workspace/tag
    awful.key({modkey}, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then tag:view_only() end
                update_awesomewm_workspaces_for_polybar()
            end,
        {description = "view tag #" .. i, group = "tag"}),

    -- Move window/client to workspace/tag.
    awful.key({modkey, "Shift"}, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end,
        {description = "move focused client to tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end),
    awful.button({modkey}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end),
    awful.button({modkey}, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

-- Set keys
root.keys(globalkeys)
-- }}}



-- {{{ Rules
--
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = 0,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            titlebars_enabled = false,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui", "veromix", "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }, -- Add titlebars to normal clients and dialogs
    {
        rule_any = {type = {"dialog"}},
        properties = {titlebars_enabled = true}
    },
    {
        rule_any = { class = {"Polybar"}},
        properties = { focusable = false }
    }
}
-- }}}



-- {{{ Signals
--
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1,
        function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3,
        function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c):setup{
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--

-- Hotkeys Popup styling
beautiful.hotkeys_modifiers_fg = "#5E35B1"
beautiful.hotkeys_font = "Droid 10"
beautiful.hotkeys_description_font = "Droid 10"

-- Set gaps between windows/clients
beautiful.useless_gap = 5

-- Start my init script
awful.spawn.with_shell("sh $HOME/dotfiles/linux/init.sh")

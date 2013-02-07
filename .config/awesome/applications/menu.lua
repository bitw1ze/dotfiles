-- automatically generated file. Do not edit (see /usr/share/doc/menu/html)

module("applications.menu")

Applications_menu = {}
Applications_menu["Applications_Office"] = {
	{"LibreOffice Calc","/usr/bin/libreoffice --calc","/usr/share/icons/hicolor/32x32/apps/libreoffice-calc.xpm"},
	{"LibreOffice Impress","/usr/bin/libreoffice --impress","/usr/share/icons/hicolor/32x32/apps/libreoffice-impress.xpm"},
	{"LibreOffice Writer","/usr/bin/libreoffice --writer","/usr/share/icons/hicolor/32x32/apps/libreoffice-writer.xpm"},
}
Applications_menu["Applications_Games"] = {
  {"Steam", "/usr/bin/steam"},
  {"Gnome Solitaire Games","/usr/games/sol","/usr/share/pixmaps/aisleriot.xpm"},
}
Applications_menu["Applications_Utils"] = {
	{"aRandR","/usr/bin/arandr"},
  {"Catalyst Control Center","/usr/bin/amdcccle" },
	{"Character map","/usr/bin/gucharmap"},
	{"GNOME system monitor","/usr/bin/gnome-system-monitor"},
	{"pavucontrol","/usr/bin/pavucontrol"},
	{"Qalculate","/usr/bin/qalculate-gtk"},
	{"Xkill","xkill"},
}
Applications_menu["Applications"] = {
	{ "Games", Applications_menu["Applications_Games"] },
	{ "Office", Applications_menu["Applications_Office"] },
  { "Utils", Applications_menu["Applications_Utils"] },
}

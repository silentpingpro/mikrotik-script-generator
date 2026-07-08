MikroTik L2TP Notifier — Changelog
v11 — 🚀 Performance & Security Optimization
Release Date: 2026-07-07

✨ Major Improvements
🔒 Security
HTTPS Support — تمام درخواست‌های API به جای HTTP از HTTPS استفاده می‌کنند
Better Error Handling — try-catch محکم‌تر برای تمام fetch calls
Timeout Protection — 5-10s timeout برای جلوگیری از script freeze
⚡ Performance
15% Size Reduction — HTML: 54.8 KB → 46.6 KB
get-flag Compact — 97% کاهش حجم (1.2 KB بجای 40+ KB)
Optimized Scripts — حجم listener 30% کمتر
🎯 New Features
Smart State Bridges — تشخیص تغییر وضعیت سرورها (Connected/Disconnected)
v11 Generator — فایل HTML جدید برای تولید اسکریپت‌های بهبود‌شده
get-country-v11.rsc — GeoIP با timeout محدود‌شده
📝 Changes
HTML Generator (mikrotik-l2tp-notifier-v11.html)
- Version: v10 → v11
+ Orange badge for HTTPS support
+ Better UI for v11 features
+ Improved file download section
get-country-v11.rsc
# Features:
- HTTPS: https://ip-api.com/json/
- Timeout: 5s
- Error handling: on-error block
- Direct API call (بدون route)
New Files
get-country-v11.rsc — GeoIP lookup v11
get-flag-v11.rsc — Compact flag file
CHANGELOG.md — This file
🔄 Migration Guide (v10 → v11)
# 1. دانلود فایل‌های v11
get-country-v11.rsc
get-flag-v11.rsc

# 2. Import در Winbox
/import get-country-v11.rsc
/import get-flag-v11.rsc

# 3. Generate کن از HTML v11
- بازدید: mikrotik-l2tp-notifier-v11.html
- انتخاب تلگرام یا بله
- وارد کردن TOKEN و Chat ID
- Generate کردن اسکریپت‌ها

# 4. Import اسکریپت‌های جدید
# (دستورات در HTML نمایش داده می‌شوند)
📊 Comparison Table
Feature	v10	v11
HTTPS	❌ HTTP	✅ HTTPS
Timeout	❌ Unlimited	✅ 5-10s
get-flag Size	40+ KB	1.2 KB
Smart State	❌	✅ Bridges
Error Handling	Basic	🔧 Improved
HTML Size	54.8 KB	46.6 KB
⚙️ Technical Details
API Changes
// v10
/tool fetch url="http://api.telegram.org/bot..."

// v11
/tool fetch url="https://api.telegram.org/bot..." timeout=5s
State Bridge Storage
# v11: Smart state tracking
/interface bridge name="tg-state-1-0"  # Server 1: Disconnected
/interface bridge name="tg-state-1-1"  # Server 1: Connected
🐛 Bug Fixes
✅ Fixed timeout issues on slow connections
✅ Improved JSON parsing for GeoIP responses
✅ Better handling of missing interfaces
✅ Removed dependency on external CDN for flags
📱 Platform Support
Telegram (تلگرام)
✅ Inline keyboard menu
✅ Route-based filtering
✅ Full control panel
Bale (بله)
✅ Direct connection
✅ No filtering required
✅ Simplified menu
🎓 Usage Examples
Example 1: Single Server Monitoring
Platform: Telegram
Servers: 1
Auto-report: Every 4 hours
Listener: Every 10 seconds
Example 2: Multi-Server (7 servers)
Platform: Telegram + Bale
Servers: 7 (Server S1-S7)
Filter: Enabled (via l2tp-out1)
Smart Check: Enabled
Auto-report: Every 6 hours
🔗 File Locations
Repository Root
├── mikrotik-l2tp-notifier-v11.html    (Generator)
├── get-country-v11.rsc               (GeoIP module)
├── get-flag-v11.rsc                  (Flag database)
├── CHANGELOG.md                      (This file)
└── v10/ (archived)
    └── mikrotik-l2tp-notifier-v10.html
📚 Documentation
For detailed setup instructions, visit:

GitHub Issues — برای report bugs
GitHub Discussions — برای سؤالات و پیشنهادات
🤝 Contributing
To contribute improvements:

Fork the repository
Create a feature branch
Make your changes
Submit a pull request
Version History:

v11 — 2026-07-07 — Performance & Security
v10 — 2026-07-06 — Initial Release
Status: ✅ Production Ready

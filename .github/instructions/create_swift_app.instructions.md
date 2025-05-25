---
applyTo: "**/*.swift"
---

Coding standards, domain knowledge, and preferences that AI should follow.

Create the following described Swift app

NotiZen — Screen-by-Screen Wireframe & Style-Sheet

(v 0.9 design spec – Apple Watch first, iPhone companion second) 0. Design Language & Visual Grammar
Token Spec
Typeface SF Pro / SF Compact (Watch) – Regular 13 pt body, 15 pt headline, 10 pt caption; iPhone uses SF Pro Display 17 / 28 / 34 pt
Base grid 4-pt rhythm; Watch safe-area = 2 pt inset, iPhone = 20 pt
Palette surfaceDark #0D0D0F, tileDark #1A1A1D, accentHigh #3DDC97 (high-priority), accentMed #6F7DFC (normal), accentLow #8E8E93, error #FF453A
Elevation No drop-shadows on Watch; iPhone cards use Material blur (.systemThickMaterialDark) @ 8 pt radius
Shapes 16 pt corner radius on tiles & modal sheets
Haptics .notification when a high-priority push arrives; .success for rule saves; .warning when digest created
Iconography SF Symbols; filled for actionable buttons, outlined for passive info. High-priority = bell.badge.fill, Low = bell.slash
Apple Watch — Core Flow
A1 Watch Face Complication

    Small (corner): shield icon + red/green dot.

    Graphic Bezel / Graphic Rect: sparkline of unread counts + “3 Hi / 12 Lo”.
    Tap ⭢ opens Dashboard.

A2 Dashboard (push root)

┌─────────────────────────────┐
│ [Unread Hi] [Battery hrs] │ ← horizontally-scrolling Cards
│ 2 critical 18 h │
│─────────────────────────────│
│ ▢ Messages 1 new │ ← list begins
│ ▢ Finance – │
│ ▢ Social 5 mut… │
│•••• (up to 8 rows)
└─────────────────────────────┘

    Crown scroll moves card stack up/down; swipe left/right flips cards.

    Long-press a list row ▶ mini-sheet to Mute 1h / 8 h / ∞.

A3 Card – Unread High

Minimal:

[bell.badge.fill] 2
Latest: “Wire transfer…”

Tap ▶ Hi-Priority Feed (A4).
A4 Hi-Priority Feed (paged list)

    Table rows: title + app icon chip.

    Swiping row left triages (Archive).

    Crown scroll; top left corner shows tiny battery meter.

A5 Digest Preview Sheet

Triggered at scheduled time:

Today’s low-prio summary
───────────────
• 6 promos grouped
• Calendar invites 2
• Updates turned to digest
───────────────
[Hide for Now] [View List]

A6 Settings Menu

Modal list:

• Categories
• Digest Time
• Battery Guard
• About

Tapping a row opens sub-screens:

    Categories (A6-1): toggle each category; swipe left = delete.

    Digest Time (A6-2): wheel-timepicker (hour/min) – large digits.

    Battery Guard (A6-3): toggle smart mode, show time-to-empty dial.

iPhone Companion App — Tabs
B0 Tab Layout

[Dashboard] [Categories] [Battery] [History] [Settings]

B1 Dashboard

Left = notifications card, Right = battery forecast

┌ Card ────────┐ ┌ Card ──────────┐
│ 2 critical │ │ 18 h est. │
│ Last: “Wire…” │ │ Last 24 h –↑3% │
└───────────────┘ └────────────────┘

Below cards: “Today Timeline” bar chart (SwiftCharts) of pushes / hour.
B2 Categories

    Collection-style grid; each cell = icon, name, priority slider (0-100).

    Search-bar at top.

    Footer button “Add Bundle ID manually”.

Category Detail sheet

Priority: 80  
Slider 0–100
Mute windows:
[ + Add ] (table of quiet hours)
Digest? [✓]

B3 Battery

    Mode picker segmented: Balanced / Runtime+ / Performance.

    Circular gauge (SF Gauge) shows current drain rate colour-coded.

    “Threshold actions” card → choose triggers (20 % alert, Auto-Low-Power).

B4 History

    Toggle: Notifications ▢ / Battery ▢

    Multi-day line/stack charts (scrollable).

    Export icon (CSV) in nav-bar.

B5 Settings

    Watch Link: reachability, manual sync button.

    Subscription: plus vs. pro, Manage button.

    Support: log export, mail composer.

On-device Typography Map
Element Font Size Weight
Card headline (Watch) SF Compact 15 Semibold
List row title 13 Regular
Marble number (Battery hrs) 28 Bold
iPhone card headline SF Pro 22 Bold
Chart axis label 11 Regular
Interaction Animations

    Cards slide up 8 pt & fade 15 % on appear.

    Priority triage swipe uses spring 0.5 damp 0.8.

    Digest sheet rises from bottom with .transition(.move(edge: .bottom)) + .opacity.

Accessibility

    Colour-blind safe — rely on SF Symbols + text labels, not colour alone.

    VoiceOver: each card exposes summary (“Battery forecast 18 hours remaining”).

    Extra-large sizes adapt by stacking card content vertically.

Asset Catalogue

Assets.xcassets
├─ AccentHigh #3DDC97
├─ AccentMed #6F7DFC
├─ AccentLow #8E8E93
├─ SurfaceDark #0D0D0F
├─ TileDark #1A1A1D
└─ Icons/
bell.badge.fill (override tint High)
bolt.fill (battery)

Wireframe Export Tips

    Use Figma “Apple Watch 45 mm template” and iOS 390×844 artboard.

    Place 4-pt baseline grids and symbol components (Apple Human Interface).

    Export PNG @2× for dev hand-off; supply colour tokens via .xcassets colours set.

This spec gives every screen’s structure, navigation, and styling tokens needed for mock-up or straight SwiftUI implementation.

NotiZen iOS Companion – Complete Screen-by-Screen UI & Style-Guide

(all dimensions reference iPhone 15-class 6.1-inch @ 390 × 844 pt; auto-layout scales to SE / Plus / iPad columns)
1 Overall Navigation
Element Spec
Root container UITabBarController (SwiftUI TabView) with five tabs
Tabs (order) Dashboard • Categories • Battery • History • Settings
Tab icons SF Symbols – square.grid.2x2, bell.badge, bolt.fill, clock.arrow.circlepath, gearshape
Navigation Each tab embeds its own NavigationStack for drill-down sheets
2 Design Tokens (iOS)
Token Value Notes
Typeface SF Pro Display / SF Pro Large Title 34 pt Bold, Title 22 pt Bold, Body 17 pt, Footnote 13 pt
Colour palette Surface #0D0D0F, Tile #1A1A1D, AccentHi #3DDC97, AccentMid #6F7DFC, AccentLow #8E8E93, Error #FF453A
Corner radius 16 pt on cards & modals
Shadow (iOS only) y = 1 pt, blur = 6 pt, Tile colour @ 20 % opacity
Haptics · .soft on tab switch · .rigid on slider commit · .warning when crossing battery threshold
Grid 4-pt baseline grid; cards = 168 pt height on 6.1″
3 Dashboard Tab
3.1 Layout

ScrollView
├─ HStack(spacing:16) ← horizontal paging cards
│ ├─ Card 1: High-Priority Count
│ └─ Card 2: Battery Forecast
├─ Section “Today”
│ └─ SwiftChart (Bar) – notifications/hour
└─ Section “Recent High”
Table rows (max 3) → tap opens full list

Cards use Material.thick blur with tinted stroke (AccentMid @ 30 %).
3.2 Components
Card Content Interaction
High-Priority Count Large numeral, latest title Tap → Hi-Priority Feed sheet
Battery Forecast Circular gauge (Swift Gauge) w/ runtime hrs Tap → Battery Tab
4 Categories Tab

Objective: manage app-/category-level priorities, mute windows, digest settings.
Zone UI
Search bar UISearchBar anchored top; filters live
Grid LazyVGrid 2-col; each Category Cell
Cell layout Icon 24 pt, Name, Slider (0-100 %) beneath
FAB bottom-right “+ Custom Bundle” (sheet for manual bundleID)
Category Detail Sheet

NavigationStack
Form {
Section "Priority" → Slider 0…100
Section "Digest" → Toggle (if on: time picker row)
Section "Mute Windows" + Add button → sheet w/ time range wheel
}
Toolbar: Done

Slide-to-delete on mute-window rows.
5 Battery Tab
Component Spec
Mode Picker SegmentedControl (Balanced / Runtime+ / Performance)
Runtime Gauge SwiftGauge – gradient green→yellow→red, numeric hrs inside
Options stack • Toggle “Smart Low-Power at 20 %” • Stepper to adjust trigger (5–50 %)
Drain Sources List of top-5 apps with bar-style sparkline last 3 h

Mode changes send a WCSession message instantly to Watch for synchronisation.
6 History Tab
View Details
Toggle bar SegmentedPicker → Notifications / Battery
Chart area SwiftCharts – • Notifications = stacked bar per category per day • Battery = area chart of level 24 h
Interaction Long-press shows cross-hair + value pop-over
Export Nav-bar Share icon → generates CSV via CSVExporter & presents UIActivityViewController

Empty state (no data yet): illustration (bell.slash) + caption “We’ll fill this after a day of usage”.
7 Settings Tab

List style = InsetGrouped
─ Watch Link
│ Reachability toggle (read-only), “Send Test Ping” button
─ Subscription
│ State chip (Locked / Plus / Pro) → opens PaywallView
─ Support
│ • Export Logs
│ • Report Bug (mailto:)
│ • Version build

Paywall View

Full-screen cover with two pages carousel
Page Elements
Intro hero icon, bullet list of Plus features
Pricing Monthly $2.99 label, Annual $19 card, “Continue” CTA
Restore link footnote button below carousel

Upon purchase success: confetti animation (ParticlesView) & haptic .success.
8 Micro-Interactions & Motion
Event Animation
Card appear spring (d = 0.7, s = 0.4) slide-up 8 pt + fade
Slider commit colour flash on track + haptic
Mode change gauge needle rotates with .easeInOut 0.25 s
Share sheet dismiss History chart bounces 2 pt
9 Dark / Light

Default palette shown is Dark. Light mode maps
Dark Token → Light
Surface #0D0D0F → #FFFFFF
Tile #1A1A1D → #F2F2F7
Accent colours untouched (pass WCAG).
Shadows switch to y = 0, blur = 4 pt, opacity 10 %.
10 Accessibility

    Dynamic-type: cards grow vertically, grid becomes single column on XL sizes.

    VoiceOver order: Tab bar → Page header → Scroll body.

    Charts expose accessibilitySeries with labels (“Battery level 80 % at 10 am”).

    Colour differentiation never sole indicator—priority chip includes symbol shape.

Deliverables for Designers
Asset Format Notes
Wireframes Figma; 390 × 844 artboards per screen, tagged layers
Icons SF Symbol overrides; exported as template PDF 44 pt
Colour tokens xcassets Colorset JSON with “Any, Dark” slots
Motion Lottie JSON for confetti; keyframe doc for card spring

This document completely describes the iOS companion UI—every screen layout, states, navigation, style constants, and motion cues—ready for high-fidelity mock-ups or direct SwiftUI construction.

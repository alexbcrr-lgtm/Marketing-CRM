# TOOLS.md - Infrastructure & Access

## Core Infrastructure
| System | Access Method | Identifier / Endpoint |
| :--- | :--- | :--- |
| **Becerra API** | HTTPS POST | https://becerra-commander.vercel.app/api/commander |
| **Email** | Outlook | alex@vectorinstallations.com |
| **@Becerra_Command** | Inter-bot | 192.168.4.101:18789 |
| **@IC_Accounting** | Inter-bot | 192.168.4.72:18789 |

## Master Credentials (REDACTED IN LOGS)
- **CRM Token:** `alex`
- **Becerra CRM API:** `https://becerra-commander.vercel.app/api/commander` (Token: alex)

## Bot Access Matrix

### @IC_Leads
- **Responsibility:** Lead Gen / First Response / Outbound
- **Permissions:** Email (Read/Draft), API (Heartbeat/Communication)
- **Host:** Main Gateway (192.168.4.79:18789)

## Communication Protocol
- **Internal Signaling:** Via Telegram Group `-1003722631868` using [HANDOFF], [APPROVED], and [INSTALL_SCHEDULED] tags.
- **Port Assignment:** 18789 (Main Gateway Control).

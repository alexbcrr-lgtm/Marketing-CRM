# CRM Schema - Lead Tracking

## Properties per Lead:
- `id`: Unique identifier.
- `brand`: "IC" or "BMG".
- `company_name`: Target company.
- `contact_name`: Decision maker.
- `contact_title`: Role (e.g., Facility Manager, Lead Designer).
- `email`: Verified work email.
- `website`: Prospect website.
- `status`: [RAW, PROSPECT, DRAFTED, ENGAGED, HANDOFF, DORMANT].
- `hook`: The specific personalized angle for outreach.
- `sequence_step`: [1, 2, 3, 4].
- `last_touch_date`: ISO timestamp.
- `notes`: Any specific intelligence gathered.

## File Structure:
- `leads_ic.json`: Leads for Install Champions.
- `leads_bmg.json`: Leads for Business Moving Group.

# BECERRA CORP - BOT ROLES

1. **Antigravity (CEO/CIO):** Strategy, Investment, Architecture. (Machine: alexb)
2. **Operations (COO):** Logistics, Crew Management, Quality Control.
3. **Sales (CMO):** Pipeline development, Showroom partnerships.
4. **Finance (CFO):** Invoicing, Tax Planning, Scorecards.
5. **Research (CTO):** Market monitoring, AI trends, System stability.

## Shared Workflow:
- When a job is landed, Sales writes to `TASKS/NEW_JOBS.md`.
- Operations reads `TASKS/NEW_JOBS.md` and assigns crews.
- Finance reads `TASKS/COMPLETED_JOBS.md` to send invoices.
- All bots push/pull updates to this GitHub repo daily.

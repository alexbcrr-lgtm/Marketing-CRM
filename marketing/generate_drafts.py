import json
import os
from datetime import datetime

# Load Leads
with open('targets.json', 'r') as f:
    leads = json.load(f)

# Templates
TOUCH_1 = """Subject: Regional Logistics Infrastructure & Fulfillment Support for {company}

Hi {contact_name},

I’m reaching out because {company} requires the kind of scalable logistics infrastructure that can keep pace with your project volume in {location}.

Install Champions provides the Southern California backbone for high-end furniture logistics. With a 20,000 sq ft Strategic Fulfillment Center and a massive regional fleet, we have the capacity to handle your most complex, enterprise-scale projects.

We aren't just a service provider; we are a massive logistics powerhouse designed to be your regional hub. Ship your entire project inventory to our fulfillment center—we manage the high-throughput receiving, inspection, and end-to-end installation with military precision. We have the sheer force and infrastructure to handle any project requirement in the region.

Do you have 5 minutes for a brief call next Tuesday to discuss integrating our logistics power into your supply chain?

Best,

ALEX BECERRA
CEO | Install Champions
"""

# Draft Generation
if not os.path.exists('marketing/drafts'):
    os.makedirs('marketing/drafts')

    for lead in leads:
        company = lead['company']
        description = lead['description']
        location = lead['location']
        contact_name = lead.get('contact_name', '')
        if not contact_name or contact_name == "Pending Recon":
            contact_name = "Team"

        draft = TOUCH_1.format(
            company=company,
            location=location,
            description=description,
            contact_name=contact_name
        )
    filename = f"marketing/drafts/{lead['company'].replace(' ', '_').replace('|', '_')}_T1.txt"
    with open(filename, 'w') as f:
        f.write(draft)

print(f"Generated {len(leads)} drafts in marketing/drafts/")

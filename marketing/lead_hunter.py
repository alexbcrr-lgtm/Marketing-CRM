#!/usr/bin/env python3
"""
IC_LOGISTICS Lead Hunter
Expands dealer target list for commercial kitchen equipment market
"""
import json
import random
from datetime import datetime

# Expanded target list based on research of commercial kitchen equipment dealers
NEW_DEALERS = [
    # Tier 1: Large multi-location dealers (immediate priority)
    {"name": "Restaurant Equipment World", "region": "Bay Area", "tier": 1, "est_size": "50+", "specialty": "full_service"},
    {"name": "Mission Restaurant Supply", "region": "Los Angeles", "tier": 1, "est_size": "100+", "specialty": "logistics_heavy"},
    {"name": "CKitchen", "region": "San Diego", "tier": 1, "est_size": "75+", "specialty": "ecommerce_logistics"},
    {"name": "The Restaurant Store", "region": "Central Valley", "tier": 1, "est_size": "60+", "specialty": "distribution"},
    
    # Tier 2: Regional players (high value)
    {"name": "Superior Restaurant Equipment", "region": "Bay Area", "tier": 2, "est_size": "25-50", "specialty": "installation"},
    {"name": "California Restaurant Services", "region": "Los Angeles", "tier": 2, "est_size": "30-50", "specialty": "consulting"},
    {"name": "Bay Area Kitchen Supply", "region": "Bay Area", "tier": 2, "est_size": "20-40", "specialty": "logistics"},
    {"name": "Central Cal Equipment", "region": "Central Valley", "tier": 2, "est_size": "25-40", "specialty": "warehousing"},
    {"name": "Valley Restaurant Supply", "region": "Sacramento", "tier": 2, "est_size": "20-35", "specialty": "delivery"},
    
    # Tier 3: Specialized/Local (partnership opportunities)
    {"name": "NorCal Commercial Kitchens", "region": "Sacramento", "tier": 3, "est_size": "10-20", "specialty": "custom"},
    {"name": "Pacific Food Equipment", "region": "San Diego", "tier": 3, "est_size": "15-25", "specialty": "repair"},
    {"name": "Coastline Restaurant Supply", "region": "Los Angeles", "tier": 3, "est_size": "10-20", "specialty": "coastal_delivery"},
    {"name": "Sierra Kitchen Solutions", "region": "Central Valley", "tier": 3, "est_size": "8-15", "specialty": "rural"},
    {"name": "Metro Kitchen Equipment", "region": "Bay Area", "tier": 3, "est_size": "12-20", "specialty": "urban"},
]

def load_targets():
    try:
        with open('marketing/dealer_targets.json', 'r') as f:
            return json.load(f)
    except FileNotFoundError:
        return {"dealers": [], "total_dealers": 0}

def save_targets(data):
    with open('marketing/dealer_targets.json', 'w') as f:
        json.dump(data, f, indent=2)

def main():
    print("[LEAD_HUNTER] Expanding dealer target list...")
    
    data = load_targets()
    existing_names = {d.get('name') for d in data.get('dealers', [])}
    
    added = 0
    for dealer in NEW_DEALERS:
        if dealer['name'] not in existing_names:
            dealer['added_date'] = datetime.now().isoformat()
            dealer['status'] = 'identified'
            data.setdefault('dealers', []).append(dealer)
            added += 1
    
    # Organize by tier
    data['priority_tiers'] = {
        'tier_1': [d for d in data['dealers'] if d.get('tier') == 1],
        'tier_2': [d for d in data['dealers'] if d.get('tier') == 2],
        'tier_3': [d for d in data['dealers'] if d.get('tier') == 3]
    }
    
    data['total_dealers'] = len(data['dealers'])
    data['new_dealers_added'] = added
    data['last_updated'] = datetime.now().isoformat()
    
    save_targets(data)
    
    print(f"[LEAD_HUNTER] Added {added} new dealers")
    print(f"[LEAD_HUNTER] Total targets: {data['total_dealers']}")
    print(f"[LEAD_HUNTER] Tier 1: {len(data['priority_tiers']['tier_1'])} | Tier 2: {len(data['priority_tiers']['tier_2'])} | Tier 3: {len(data['priority_tiers']['tier_3'])}")

if __name__ == "__main__":
    main()
